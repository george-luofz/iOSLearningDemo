//
//  MJPerson.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/6.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MJPerson.h"

@implementation MJPerson

- (void)setAge:(NSInteger)age {
    [self willChangeValueForKey:@"age"];
    _age = age;
    [self didChangeValueForKey:@"age"];
}

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

//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    return NO;
//}

@end
