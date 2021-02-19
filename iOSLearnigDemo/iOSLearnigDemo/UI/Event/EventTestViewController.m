//
//  EventTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2019/8/16.
//  Copyright © 2019 George_luofz. All rights reserved.
//

#import "EventTestViewController.h"
#import "YXLiveRoomView.h"
#import "YXLiveRoomMovableView.h"
#import "YXLiveRoomDisplayerView.h"
#import "YXLiveRoomLiteView.h"

#import "YXLiveRoomView1.h"
#import "YXLiveRoomView2.h"
#import "YXLiveRoomView3.h"

@interface EventTestViewController ()<UIScrollViewDelegate>

@end

@implementation EventTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    YXLiveRoomView *roomView = [[YXLiveRoomView alloc] initWithFrame:self.view.bounds];
//    roomView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:roomView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 3);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UIView *displayerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    displayerView.backgroundColor = [UIColor blueColor];
    
    // scrollView内子视图，使用pan手势拦截scrollView滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
    [displayerView addGestureRecognizer:pan];
    [scrollView addSubview:displayerView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll:%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)pan {
    NSLog(@"pan");
}

@end
