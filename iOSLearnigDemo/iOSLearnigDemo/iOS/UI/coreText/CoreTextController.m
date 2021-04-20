//
//  CoreTextController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CoreTextController.h"
#import "CTDisplayView.h"

@interface CoreTextController ()

@end

@implementation CoreTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _test1];
}

- (void)_test1 {
    CTDisplayView *view = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 88, 100, 200)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
}


@end
