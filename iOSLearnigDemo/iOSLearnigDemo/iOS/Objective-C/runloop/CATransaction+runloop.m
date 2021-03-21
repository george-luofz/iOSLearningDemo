//
//  CATransaction+runloop.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/21.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "CATransaction+runloop.h"
#import <objc/NSObjCRuntime.h>
#import <objc/runtime.h>

@implementation CATransaction (runloop)

+ (void)begin {
    NSLog(@"%s",__func__);
    
    [self invokeOriginalMethod:[self class] selector:@selector(begin)];
}

+ (void)commit {
    NSLog(@"%s",__func__);
    
    [self invokeOriginalMethod:[self class] selector:@selector(commit)];
}

+ (void)flush {
    NSLog(@"%s",__func__);
    
    [self invokeOriginalMethod:[self class] selector:@selector(flush)];
}


+ (void)invokeOriginalMethod:(id)target selector:(SEL)selector {
    // Get the class method list
    uint count;
    Method *list = class_copyMethodList([target class], &count);

    // Find and call original method .
    for ( int i = count - 1 ; i >= 0; i--) {
        Method method = list[i];
        SEL name = method_getName(method);
        IMP imp = method_getImplementation(method);
        if (name == selector) {
            ((void (*)(id, SEL))imp)(target, name);
            break;
        }
    }
    free(list);
}

@end
