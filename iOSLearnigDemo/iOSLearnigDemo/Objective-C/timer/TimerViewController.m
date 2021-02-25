//
//  TimerViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/2/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "TimerViewController.h"
#import <mach/mach.h>

@interface TimerViewController ()
@property (nonatomic, strong) NSMutableDictionary *tempDict;
@property (nonatomic, strong) dispatch_source_t gcdTimer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testPreTimers];
//    [self testMultiTimers];
    self.tempDict = [NSMutableDictionary dictionary];
    NSLog(@"gcd create timer");
    for (int i = 0;i < 20;i++) {
        [self testGCDTimer:i];
    }
}

- (void)testMultiTimers {
    for (int i = 0 ;i < 20;i++) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(multiTimersFuc:) userInfo:@{@"c": @(i)} repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)testPreTimers {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(preTimerFuc:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)multiTimersFuc:(NSTimer *)timer {
    NSLog(@"multiTimersFuc : %d",[[self class] cpuUsage]);
}

- (void)preTimerFuc:(NSTimer *)timer {
    NSLog(@"preTimerFuc : %d",[[self class] cpuUsage]);
}

#pragma mark - cpu

+ (integer_t)cpuUsage {
    thread_act_array_t threads; //int 组成的数组比如 thread[1] = 5635
    mach_msg_type_number_t threadCount = 0; //mach_msg_type_number_t 是 int 类型
    const task_t thisTask = mach_task_self();
    //根据当前 task 获取所有线程
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    integer_t cpuUsage = 0;
    // 遍历所有线程
    for (int i = 0; i < threadCount; i++) {
        
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            // 获取 CPU 使用率
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                cpuUsage += threadBaseInfo->cpu_usage;
            }
        }
    }
    assert(vm_deallocate(mach_task_self(), (vm_address_t)threads, threadCount * sizeof(thread_t)) == KERN_SUCCESS);
    return cpuUsage;
}

#pragma mark - gcd timer

// timer必须强引，不然出了函数作用域就释放了
- (void)testGCDTimer:(int)index {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, 1.f * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, startTime, 1.f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        [self timerFuc:index]; // 如果不用__weak，dealloc可能不会走
    });
    dispatch_resume(timer);
    [self.tempDict setObject:timer forKey:@(index).stringValue];
}

- (void)timerFuc:(NSInteger)index {
    NSLog(@"gcd timer fired :%ld",(long)index);
}

@end
