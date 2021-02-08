//
//  OPTBatteryViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/2/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "OPTBatteryViewController.h"
//#import "IOPSKeys.h"
//#import "IOPowerSources.h"

@interface OPTBatteryViewController ()

@end

@implementation OPTBatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getBatteryLevel];
    
}

- (void)getBatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceBatteryLevelDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) { // Level has changed
        NSLog(@"Battery Level Change");
        NSLog(@"电池电量：%.2f", [UIDevice currentDevice].batteryLevel);
    }];

}

//-(double) getBatteryLevel2{
//    // 返回电量信息
//    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
//    // 返回电量句柄列表数据
//    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
//    CFDictionaryRef pSource = NULL;
//    const void *psValue;
//    // 返回数组大小
//    int numOfSources = CFArrayGetCount(sources);
//    // 计算大小出错处理
//    if (numOfSources == 0) {
//        NSLog(@"Error in CFArrayGetCount");
//        return -1.0f;
//    }
//
//    // 计算所剩电量
//    for (int i=0; i<numOfSources; i++) {
//        // 返回电源可读信息的字典
//        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
//        if (!pSource) {
//            NSLog(@"Error in IOPSGetPowerSourceDescription");
//            return -1.0f;
//        }
//        psValue = (CFStringRef) CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
//
//        int curCapacity = 0;
//        int maxCapacity = 0;
//        double percentage;
//
//        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
//        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
//
//        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
//        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
//
//        percentage = ((double) curCapacity / (double) maxCapacity * 100.0f);
//        NSLog(@"curCapacity : %d / maxCapacity: %d , percentage: %.1f ", curCapacity, maxCapacity, percentage);
//        return percentage;
//    }
//    return -1.
//}

@end
