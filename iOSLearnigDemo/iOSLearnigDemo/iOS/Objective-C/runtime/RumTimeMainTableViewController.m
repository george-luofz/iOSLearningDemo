//
//  RumTimeMainTableViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/4/17.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "RumTimeMainTableViewController.h"

@interface RumTimeMainTableViewController ()

@end

@implementation RumTimeMainTableViewController

- (NSArray *)dataSource {
    return @[
        @{@"基础": @"RuntimeTestViewController"},
        @{@"Cache": @"RuntimeCacheTestController"},
        ];
}

@end
