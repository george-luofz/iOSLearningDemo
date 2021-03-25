//
//  WeakObject.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/9.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "WeakObject.h"

@implementation WeakObject

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)testMethod {
    
    NSObject *obj = [NSObject new];
//    __weak NSObject *weakObj = obj;
    id __weak obj1 = obj;
    NSLog(@"%s",__func__);
}

// objc源码说会回调_setWeaklyReferenced方法，测试无效
//- (void)setWeaklyReferenced {
//    NSLog(@"%s",__func__);
//    NSLog(@"%@",[NSThread callStackSymbols]);
//}

@end
