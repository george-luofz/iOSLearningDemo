//
//  NNLunarCalenderManager.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/15.
//  Copyright © 2018年 George_luofz. All rights reserved.
//  功能：
//  公历转农历，节气、特殊节日等

#import <Foundation/Foundation.h>

@interface NNLunarCalenderManager : NSObject

/**
 单例方法

 @return 单例对象
 */
+ (nullable instancetype)sharedInstance;

/**
 公历对应的农历字典
 
 eg: 2018.08.15 -> {@"year":@"2018",@"month":@"正月",@"day":@"十四",@"solarTerms":@""}
 @param date 公历日期
 @return 农历字典
 */
- (nullable NSMutableDictionary *)lunarDayOfSolarDay:(NSDate *)date;

/**
 公历这天对应的字符串：十四/清明/

 @param date 公历日期
 @return 字符串
 */
- (nullable NSString *)dayStringOfSoloarDay:(NSDate *)date;
@end
