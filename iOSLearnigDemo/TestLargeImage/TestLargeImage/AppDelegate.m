//
//  AppDelegate.m
//  TestLargeImage
//
//  Created by 罗富中 on 2020/5/25.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"1:%.1lf",16545 / 10000.0);
    NSLog(@"2:%.1lf",floor(16545 * 10 / 10000.0) / 10);
    NSLog(@"3:%.1lf",floor((16545 * 10 / 10000.0) / 10));
    
    
    for (int i = 0;i < 1000000;i++) {
        NSLog(@"requestId:%@\n",buildRequestTimeStr());
    }
    return YES;
}


/*请求id 生成规则
【1位订单标识】+【2位业务编码】+【3位子系统类型】+【17位时间(礼物总线服务器时间)】+【8位随机数】+【用户ID(目前是11位用户ID,支持后续位数的扩展)】 A+10+101+yyyyMMddHHmmssSSS+RANDOM(8)+USERID -> A10101201812010915237651234567851111111112 */
NSString *buildRequestId(NSString *currentUserUid) {
    return [NSString stringWithFormat:@"A10101%@%@%@", buildRequestTimeStr(),generateNO(8),currentUserUid];
}

// YYYYMMDDhhmmssSSS
NSString *buildRequestTimeStr() {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}

// 8位随机数
NSString *generateNO(NSInteger kNumber){
    if (kNumber <= 0) return @"";
    
    NSString *sourceStr = @"0123456789";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < kNumber; i++){
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
