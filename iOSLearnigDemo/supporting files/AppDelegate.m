//
//  AppDelegate.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AppDelegate.h"
#import "FJReplayKit.h"

#import "MainTableViewController.h"
#import <OSLog/OSLog.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    os_log_t logger = os_log_create("com.yixia.iOSLearnigDemo", "performance");
    os_signpost_id_t spid = os_signpost_id_generate(logger);
    os_signpost_id_t signPostId = os_signpost_id_make_with_pointer(logger,spid);
    //标记时间段开始
    os_signpost_interval_begin(logger, signPostId, "Launch","%{public}s", "");
    
    // Override point for customization after application launch.
    // 开启屏幕录制
//    [[FJReplayKit sharedReplay] catreButton:YES];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MainTableViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //标记结束
    os_signpost_interval_end(logger, signPostId, "Launch");
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);
////    [super touchesBegan:touches withEvent:event];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}



#pragma mark requestid

/*请求id 生成规则
【1位订单标识】+【2位业务编码】+【3位子系统类型】+【17位时间(礼物总线服务器时间)】+【8位随机数】+【用户ID(目前是11位用户ID,支持后续位数的扩展)】 A+10+101+yyyyMMddHHmmssSSS+RANDOM(8)+USERID -> A10101201812010915237651234567851111111112 */
NSString *buildRequestId(NSString *currentUserUid) {
    return [NSString stringWithFormat:@"A10101%@%@%@", buildRequestTimeStr(),generateNO(8),currentUserUid];
}

// YYYYMMDDhhmmssSSS
NSString *buildRequestTimeStr() {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
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
