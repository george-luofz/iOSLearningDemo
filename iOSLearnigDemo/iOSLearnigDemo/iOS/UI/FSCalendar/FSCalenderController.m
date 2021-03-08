//
//  FSCalenderController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "FSCalenderController.h"
#import <FSCalendar/FSCalendar.h>
#import "NNLunarCalenderManager.h"
#import "DIYCalendarCell.h"

@interface FSCalenderController () <FSCalendarDataSource,FSCalendarDelegate>
@property (nonatomic) FSCalendar *calendar;
@end

@implementation FSCalenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self _test];
}

- (void)_test{
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, self.view.nn_width, 500)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = YES;
    
    calendar.backgroundColor = [UIColor clearColor];
    
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:NSStringFromClass([DIYCalendarCell class])];
    
    FSCalendarAppearance *appearance = calendar.appearance;
    appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase; //去掉周
    appearance.weekdayTextColor = [UIColor grayColor];
    appearance.titleWeekendColor = [UIColor redColor];
    appearance.subtitleWeekendColor = [UIColor redColor];
    appearance.selectionColor = [UIColor orangeColor];
    appearance.borderRadius = 0;
    
    // 设置字体、颜色等
    // 1. 周六、周日 红色
    
    // 2. 节气 绿色
    // 3. 普通的灰色
    
    // 事件
    // 1. 有事件浅黄
    // 2. 选中时黄色，字体居左，添加编辑按钮
    
    // 设置offset
    appearance.subtitleOffset = CGPointMake(0, 10);
    appearance.titleOffset = CGPointMake(0, 0);
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

#pragma mark - calendar datasource
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    return [[NNLunarCalenderManager sharedInstance] dayStringOfSoloarDay:date];
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = (DIYCalendarCell *)[calendar dequeueReusableCellWithIdentifier:NSStringFromClass([DIYCalendarCell class]) forDate:date atMonthPosition:monthPosition];
    cell.titleLabel.backgroundColor = [UIColor greenColor];
    cell.subtitleLabel.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

//- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
//{
//    return 2;
//}
// 配置该行cell
- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    
}
@end
