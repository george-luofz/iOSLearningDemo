//
//  NetworkRequsetTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "NetworkRequsetTestController.h"
#import "APIRequest.h"

@interface NetworkRequsetTestController ()

@end

@implementation NetworkRequsetTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _test];
}

- (void)_test{
    [APIRequest requestUserInfoWithParams:nil response:^(NSError *error, id responseObject) {
        NSLog(@"%s,error:%@,responobj:%@",__func__,error,responseObject);
    }];
}
@end
