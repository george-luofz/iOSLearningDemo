//
//  JTCalendarTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "JTCalendarTestController.h"
#import <JTCalendar/JTCalendar.h>
@interface JTCalendarTestController () <JTCalendarDelegate>
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@end

@implementation JTCalendarTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _test1];
}

- (void)_test1{
    _calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.nn_width, 64)];
    _calendarMenuView.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:_calendarMenuView];
    
    _calendarContentView = [[JTHorizontalCalendarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_calendarMenuView.frame), self.view.nn_width, 250)];
    _calendarContentView.backgroundColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:.5f];
    [self.view addSubview:_calendarContentView];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
}

@end
