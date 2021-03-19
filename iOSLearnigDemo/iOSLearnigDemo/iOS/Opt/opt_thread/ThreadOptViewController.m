//
//  ThreadOptViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/19.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "ThreadOptViewController.h"
#import <mach/mach.h>
#include <dlfcn.h>
#include <pthread.h>
#include <sys/types.h>
#include <limits.h>
#include <string.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

@interface ThreadOptViewController ()

@end

@implementation ThreadOptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testGetAllThreadStacks];

    NSLog(@"bb");
}

#pragma mark - 获取所有线程堆栈
/*
 1. task_threads通过获取所有线程
 2. 找到当前线程pc记录
 3. 通过当前fp，找到上一个线程fp，找到该线程pc
 4. 循环直到结束
 */
- (void)testGetAllThreadStacks {
    thread_act_array_t threads;
    mach_msg_type_number_t thread_count = 0;
    const task_t this_task = mach_task_self();
    
    kern_return_t kr = task_threads(this_task, &threads, &thread_count);
    NSMutableString *resultString = [NSMutableString stringWithFormat:@"Call Backtrace of %u threads:\n", thread_count];
    for(int i = 0; i < thread_count; i++) {
        [resultString appendString:backtraceOfThread(threads[i])];
    }
}

// 找到每个线程得fp、lr
NSString *backtraceOfThread(thread_t thread) {
    _STRUCT_MCONTEXT machineContext;
    mach_msg_type_number_t state_count = ARM_THREAD_STATE64_COUNT;
    kern_return_t kr = thread_get_state(thread, ARM_THREAD_STATE64, (thread_state_t)&machineContext.__ss, &state_count);
    if (kr != KERN_SUCCESS) return nil;

    return nil;
}


@end
