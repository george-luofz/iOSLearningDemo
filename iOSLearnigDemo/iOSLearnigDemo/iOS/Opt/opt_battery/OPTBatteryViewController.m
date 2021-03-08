//
//  OPTBatteryViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/2/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "OPTBatteryViewController.h"
#import "IOPSKeys.h"
#import "IOPowerSources.h"
#include <pthread/pthread.h>

@interface OPTBatteryViewController ()

@end

@implementation OPTBatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self getBatteryLevel2];
//    [self testSet_target_queue];
    [self testGCD_PrioryQueue];
}

- (void)getBatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceBatteryLevelDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) { // Level has changed
        NSLog(@"Battery Level Change");
        NSLog(@"电池电量：%.2f", [UIDevice currentDevice].batteryLevel);
    }];
}

// 使用IOKit私有库，精度1%
-(double) getBatteryLevel2 {
    // 返回电量信息
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    // 返回电量句柄列表数据
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    // 返回数组大小
    int numOfSources = CFArrayGetCount(sources);
    // 计算大小出错处理
    if (numOfSources == 0) {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }

    // 计算所剩电量
    for (int i=0; i<numOfSources; i++) {
        // 返回电源可读信息的字典
        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
        if (!pSource) {
            NSLog(@"Error in IOPSGetPowerSourceDescription");
            return -1.0f;
        }
        psValue = (CFStringRef) CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));

        int curCapacity = 0;
        int maxCapacity = 0;
        double percentage;

        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);

        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);

        percentage = ((double) curCapacity / (double) maxCapacity * 100.0f);
        NSLog(@"curCapacity : %d / maxCapacity: %d , percentage: %.1f ", curCapacity, maxCapacity, percentage);
        return percentage;
    }
    return -1;
}

#pragma mark - QOS

- (void)testQOS {
    // NSOperation (qos可调整)
    NSOperation *myOperation = [[NSOperation alloc] init];
    myOperation.qualityOfService = NSQualityOfServiceUserInteractive;
    myOperation.qualityOfService = NSQualityOfServiceUserInitiated;
    myOperation.qualityOfService = NSQualityOfServiceDefault;
    myOperation.qualityOfService = NSQualityOfServiceUtility;
    myOperation.qualityOfService = NSQualityOfServiceBackground;
    
    // gcd (不可调整)
    dispatch_queue_attr_t qosAttribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0);
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t myQueue = dispatch_queue_create("com.YourApp.YourQueue", qosAttribute);
    
//    int relative_priority_ptr;
//    dispatch_queue_attr_t qosClasss = dispatch_queue_get_qos_class(myQueue,&relative_priority_ptr);
    
    // gcd block （出现优先级反转问题）
    dispatch_block_t myBlock;
    myBlock = dispatch_block_create_with_qos_class(
                                                   0, QOS_CLASS_UTILITY, -8, ^{
        
    });
    dispatch_async(myQueue, myBlock);
    
    // NSThread
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadFuc) object:nil];
    thread.qualityOfService = NSQualityOfServiceDefault;
    

    // pthreads
    pthread_t pthread;
    pthread_attr_t qosAttribute1;
    pthread_attr_init(&qosAttribute1);
    pthread_attr_set_qos_class_np(&qosAttribute1, QOS_CLASS_UTILITY, 0);
    void *f;
    pthread_create(&pthread, &qosAttribute1, f, NULL);
}

- (void)threadFuc {
    
}

// set_target_queue
- (void)testSet_target_queue {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);

    dispatch_queue_t firstQueue = dispatch_queue_create("com.starming.gcddemo.firstqueue", DISPATCH_QUEUE_SERIAL);

    dispatch_queue_t secondQueue = dispatch_queue_create("com.starming.gcddemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(firstQueue, serialQueue);

    dispatch_set_target_queue(secondQueue, serialQueue);


    dispatch_async(firstQueue, ^{
        NSLog(@"1");

        [NSThread sleepForTimeInterval:3.f];

    });

    dispatch_async(secondQueue, ^{
        NSLog(@"2");

        [NSThread sleepForTimeInterval:2.f];

    });

    dispatch_async(secondQueue, ^{
        NSLog(@"3");

        [NSThread sleepForTimeInterval:1.f];

    });

}

#pragma mark - qos 进阶

// 前提：
// 1. 行队列之间是并行执行得，如果让你串行执行，则用dispatch_set_target_queue
// 2. dispatch_set_target_queue会将原任务插到目标队列执行，从而让串行队列之间也串行，前提是目标队列是串行队列
// 3. 默认创建队列得target_queue是global queue

// gcd优先级队列
- (void)testGCD_PrioryQueue {
    dispatch_queue_t low = dispatch_queue_create("low",DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t high = dispatch_queue_create("high",DISPATCH_QUEUE_SERIAL);
    // low 队列的目标队列指定为 high
    dispatch_set_target_queue(low, high);
    // 执行一个 low 任务
    dispatch_async(low,^{
        NSLog(@"Low");
    });

    // 要分派到高优先级队列，暂停低优先级队列，并且在高优先级块结束后恢复低优先级队列：
    dispatch_suspend(low);
    dispatch_async(high,^{
        NSLog(@"High1");
        dispatch_resume(low);
    });

    dispatch_suspend(low);
    dispatch_async(high,^{
        NSLog(@"High2");
        dispatch_resume(low);
    });
}

/*
 Global queue

 Corresponding QoS class

 Main thread

 User-interactive

 DISPATCH_QUEUE_PRIORITY_HIGH

 User-initiated

 DISPATCH_QUEUE_PRIORITY_DEFAULT

 Default

 DISPATCH_QUEUE_PRIORITY_LOW

 Utility

 DISPATCH_QUEUE_PRIORITY_BACKGROUND

 Background
 */
@end
