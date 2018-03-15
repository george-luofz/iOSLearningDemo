//
//  GCDViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"gcd学习";
    
    [self test_barrier_async];
    
}

#pragma mark -- 多线程
- (void)test_barrier_async{
    dispatch_queue_t queue = dispatch_queue_create("concurrent_Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"log1");
    });
    dispatch_async(queue, ^{
        NSLog(@"log2");
    });
    dispatch_async(queue, ^{
        NSLog(@"log3");
    });
    //    dispatch_barrier_sync(queue, ^{
    //        for(int i = 0 ;i < 10000;i++){
    //            NSLog(@"barrier%d",i);
    //        }
    //        NSLog(@"barrier log finished");
    //    });
    
    dispatch_sync(queue, ^{
        for(int i = 0 ;i < 10000;i++){
            NSLog(@"sync%d",i);
        }
        NSLog(@"sync log finished");
    });
    dispatch_async(queue, ^{
        for(int i = 0 ;i < 10000;i++){
            NSLog(@"sync2 %d",i);
        }
        NSLog(@"sync2 log finished");
    });
}

- (void)test_dipatch_sync{
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    //        NSLog(@"main queue");
    //    });
    dispatch_queue_t queue = dispatch_queue_create("concurrent_Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"global queue invoked");
        dispatch_sync(queue, ^{
            sleep(2);
            NSLog(@"sync queue invoked");
        });
        NSLog(@"globla queue invoked after sync queue");
    });
}

@end
