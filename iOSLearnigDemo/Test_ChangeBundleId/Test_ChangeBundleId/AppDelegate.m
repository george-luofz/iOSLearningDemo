//
//  AppDelegate.m
//  Test_ChangeBundleId
//
//  Created by 罗富中 on 2020/7/16.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *bundleIdentifier =  [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"bundleIdentifier:%@",bundleIdentifier);
    
    NSString *infoDictBundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSLog(@"infoDict bundleIdentifier:%@",infoDictBundleIdentifier);
    
    NSString *localedInfoDictBundleIdentifier = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSLog(@"locale infoDict bundleIdentifier:%@",localedInfoDictBundleIdentifier);
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
