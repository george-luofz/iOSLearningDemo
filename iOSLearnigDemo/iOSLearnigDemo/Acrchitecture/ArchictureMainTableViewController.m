//
//  ArchictureMainTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//  tableView复用
//  controller庞大

#import "ArchictureMainTableViewController.h"

@interface ArchictureMainTableViewController ()

@end

@implementation ArchictureMainTableViewController

- (NSArray *)dataSource {
    return @[
        @{@"设计模式" : @"DesignPatternMainTableController"},
        @{@"MVC": @"MVCTestViewController"},
        @{@"MVP": @"MVPTestViewController"},
        @{@"MVVM": @"MVVMTestViewController"},
        ];
}

@end
