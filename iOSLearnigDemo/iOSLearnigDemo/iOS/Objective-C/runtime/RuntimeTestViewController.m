//
//  RuntimeTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/4.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "RuntimeTestViewController.h"
#import <objc/runtime.h>
#import "TestRuntimeForward.h"

@interface RuntimeTestViewController ()
@end

@implementation RuntimeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test_resolveInstanceMethod];
}

#pragma mark - hook objc_msg_send

- (void)test_resolveInstanceMethod {
    TestRuntimeForward *obj = [TestRuntimeForward new];
    [obj test];
}

@end
