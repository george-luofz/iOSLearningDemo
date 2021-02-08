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

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testPreTimers];
    [self testMultiTimers];
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
@end
