//
//  NNLunarCalenderManager.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/15.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "NNLunarCalenderManager.h"
#import "LunarCore.h"

@interface NNLunarCalenderManager()
@property (nonatomic) NSCalendar *gregorianCalendar;
@property (nonatomic) NSCalendar *chineseCalendar;
@end

@implementation NNLunarCalenderManager

+ (instancetype)sharedInstance{
    static NNLunarCalenderManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [NNLunarCalenderManager new];
        [manager _commonInit];
    });
    return manager;
}

- (NSMutableDictionary *)lunarDayOfSolarDay:(NSDate *)date{
    int year = (int)[_gregorianCalendar component:NSCalendarUnitYear fromDate:date];
    int month = (int)[_gregorianCalendar component:NSCalendarUnitMonth fromDate:date];
    int day = (int)[_gregorianCalendar component:NSCalendarUnitDay fromDate:date];
    
    // 暂不缓存
    return solarToLunar(year, month, day);
}

- (NSString *)dayStringOfSoloarDay:(NSDate *)date{
    NSMutableDictionary *dict = [self lunarDayOfSolarDay:date];
    NSString *returnStr = dict[@"lunarDayName"];
    if (![dict[@"term"] isEqualToString:@""]){
        returnStr = [dict[@"term"] copy];
    }
//    else if (![dict[@"solarFestival"] isEqualToString:@""]){
//        returnStr = dict[@"solarFestival"];
//    } else if (![dict[@"lunarFestival"] isEqualToString:@""]){
//        returnStr = dict[@"lunarFestival"];
//    }
    return returnStr;
}
#pragma mark - private
- (void)_commonInit{
    _gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
}

@end
