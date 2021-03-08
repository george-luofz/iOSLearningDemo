//
//  KVCObject.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/6.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "KVCObject.h"
#import <objc/runtime.h>

@interface KVCObject()
@end

@implementation KVCObject

//@dynamic age;

- (void)setAge:(int)age {
    _age = age;

    NSLog(@"%s",__func__);
}

//- (void)_setAge:(int)age {
//    _age = age;
//
//    NSLog(@"%s",__func__);
//}

//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
//}

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"before %s",__func__);
    [super willChangeValueForKey:key];
    NSLog(@"after %s",__func__);
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"before %s",__func__);
    [super didChangeValueForKey:key];
    NSLog(@"after %s",__func__);
}

- (NSString *)debugDescription {
    return @"debug description";
}

@end
