//
//  ThreadTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ThreadTableViewController.h"
#import "GCDViewController.h"

@interface ThreadTableViewController ()

@end

@implementation ThreadTableViewController

- (NSArray *)dataSource {
    return @[
        @{@"GCD" : @"GCDViewController"},
    ];
}

@end
