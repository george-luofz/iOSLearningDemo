//
//  FSCalenderController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "FSCalenderController.h"
#import <FSCalendar/FSCalendar.h>

@interface FSCalenderController () <FSCalendarDataSource,FSCalendarDelegate>
@property (nonatomic) FSCalendar *calendar;
@end

@implementation FSCalenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _test];
}

- (void)_test{
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, self.view.nn_width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

@end
