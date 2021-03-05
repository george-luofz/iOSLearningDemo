//
//  NetWorkMainViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/2.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "NetWorkMainViewController.h"

@interface NetWorkMainViewController ()

@end

@implementation NetWorkMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"proxy :%d",[self.class getProxyStatus]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/// 判断手机是否挂了代理
+ (BOOL)getProxyStatus {
    NSDictionary *proxySettings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    NSArray *proxies = (__bridge NSArray *)CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"http://www.google.com"], (__bridge CFDictionaryRef)proxySettings);
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
    }
    else
    {
        //设置代理了
        return YES;
    }
}
@end
