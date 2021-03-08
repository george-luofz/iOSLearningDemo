//
//  TestRuntimeForward+category.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/7.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "TestRuntimeForward+category.h"
#import <objc/runtime.h>

static char * keyName = "addPropKey";

@implementation TestRuntimeForward (category)

@dynamic aProp;

- (void)setAProp:(NSString *)prop{
    objc_setAssociatedObject(self, keyName, prop, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)aProp{
   return objc_getAssociatedObject(self, keyName);
}
@end
