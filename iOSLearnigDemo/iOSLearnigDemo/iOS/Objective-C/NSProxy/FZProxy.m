//
//  FZProxy.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "FZProxy.h"

@implementation FZProxy

-(void)transformToObject:(NSObject *)obj {
    self.obj = obj;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (self.obj && [self.obj respondsToSelector:aSelector]) {
        return [self.obj methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = [anInvocation selector];
    if (self.obj && [self.obj respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self.obj];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

@end
