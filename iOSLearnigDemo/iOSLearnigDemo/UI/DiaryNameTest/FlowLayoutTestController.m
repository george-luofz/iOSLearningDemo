//
//  FlowLayoutTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "FlowLayoutTestController.h"
#import "Header.h"

@interface FlowLayoutTestController ()

@end

@implementation FlowLayoutTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Header *header = [[Header alloc] initWithFrame:CGRectMake(0, 80, self.view.nn_width, 500)];
    [self.view addSubview:header];
}


@end
