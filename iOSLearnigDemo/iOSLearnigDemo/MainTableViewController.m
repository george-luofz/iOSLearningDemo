//
//  MainTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (NSArray *)dataSource {
    return @[
        @{@"Objective-C": @"ObjectCMainTableController"},
        @{@"UI": @"UITestTableViewController"},
        @{@"多线程": @"ThreadTableViewController"},
        @{@"网络" : @"NetWorkMainViewController"},
        @{@"优化相关": @"OptMainTableViewController"},
        @{@"算法": @"AlgoTableViewController"},
        @{@"架构" : @"ArchictureMainTableViewController"},
        @{@"AVFoundation": @"AVFoundationTestController"},
        ];
}

@end
