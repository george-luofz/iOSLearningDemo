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

@interface EventTestViewController ()

@end

@implementation EventTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    YXLiveRoomView *roomView = [[YXLiveRoomView alloc] initWithFrame:self.view.bounds];
//    roomView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:roomView];
    
    YXLiveRoomView *displayerView = [[YXLiveRoomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    displayerView.backgroundColor = [UIColor blueColor];
    
//    displayerView.penetrate = YES;
    [self.view addSubview:displayerView];
    
    YXLiveRoomView *liteView = [[YXLiveRoomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    liteView.backgroundColor = [UIColor blueColor];
    liteView.penetrate = YES;
    [self.view addSubview:liteView];
    
    YXLiveRoomMovableView *movableView = [[YXLiveRoomMovableView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    movableView.backgroundColor = [UIColor yellowColor];
    movableView.penetrate = YES;
    
    [self.view addSubview:movableView];
    
//    YXLiveRoomView *fixedMovableView = [[YXLiveRoomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    fixedMovableView.backgroundColor = [UIColor grayColor];
//    fixedMovableView.penetrate = YES;
//    [self.view addSubview:fixedMovableView];
    
    YXLiveRoomView1 *roomView1 = [[YXLiveRoomView1 alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    roomView1.backgroundColor = [UIColor whiteColor];
    roomView1.penetrate = YES;
    [movableView addSubview:roomView1];
    
    YXLiveRoomView2 *roomView2 = [[YXLiveRoomView2 alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    roomView2.backgroundColor = [UIColor redColor];
    [displayerView addSubview:roomView2];
    
    YXLiveRoomView3 *roomView3 = [[YXLiveRoomView3 alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    roomView3.backgroundColor = [UIColor redColor];
    [liteView addSubview:roomView3];
//    NSLog(@"富中 %@,%@,%@",roomView,displayerView,fixedMovableView);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
