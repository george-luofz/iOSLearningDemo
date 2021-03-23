//
//  SingleTest.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "SingleTest.h"

@interface SingleTest() <NSCopying, NSMutableCopying>

@end
@implementation SingleTest

+ (instancetype)shareInstance {
    static SingleTest *test = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[super allocWithZone:nil] init];
    });
    return test;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self.class shareInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [self.class shareInstance];
}

@end
