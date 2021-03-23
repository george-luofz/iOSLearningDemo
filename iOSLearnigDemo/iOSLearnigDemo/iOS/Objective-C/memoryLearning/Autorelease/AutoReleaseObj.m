//
//  AutoReleaseObj.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/9.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "AutoReleaseObj.h"

@implementation AutoReleaseObj

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s",__func__);
}

- (void)testMethod {
    
    @autoreleasepool {
        NSObject *obj = [NSObject new];
    }
    
}

@end
