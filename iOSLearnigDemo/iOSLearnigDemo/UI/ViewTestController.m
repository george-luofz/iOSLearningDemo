//
//  ViewTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ViewTestController.h"

@interface ViewTestController ()

@end

@implementation ViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // openURL 不支持传空格，要转换成特殊字符
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vans.com.cn/wap/article-2775.html?utm_source=Miaopai&utm_medium=Homepage_4-1&utm_campaign=Vans2018 Brand"]];
    });
}


@end
