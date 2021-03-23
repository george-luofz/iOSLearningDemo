//
//  MemoryMainTableViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MemoryMainTableViewController.h"

@interface MemoryMainTableViewController ()

@end

@implementation MemoryMainTableViewController

- (NSArray *)dataSource {
    return @[
        @{@"内存基础": @"MemoryBaseViewController"},
        @{@"weak" : @"WeakTestViewController"},
        @{@"autorelease" : @"AutoReleaseTestViewController"},
        ];
}

@end
