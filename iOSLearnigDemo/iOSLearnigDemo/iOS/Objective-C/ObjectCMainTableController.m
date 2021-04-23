//
//  ObjectCMainTableController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ObjectCMainTableController.h"

@interface ObjectCMainTableController ()
@end

@implementation ObjectCMainTableController

- (NSArray *)dataSource {
    return @[
        @{@"内存": @"MemoryMainTableViewController"},
        @{@"property": @"PropertyLearningController"},
        @{@"category": @"CategoryViewController"},
        @{@"runtime": @"RumTimeMainTableViewController"},
        @{@"runloop": @"RunloopTestViewController"},
        @{@"timer": @"TimerViewController"},
        @{@"KVO": @"KVOTestController"},
        @{@"KVC": @"KVCTestViewController"},
        @{@"NXProxy": @"NXProxyTestViewController"},
        @{@"block" : @"BlockTestViewController"},
        @{@"NSArray" : @"NSArrayTestViewController"},
        ];
}

@end
