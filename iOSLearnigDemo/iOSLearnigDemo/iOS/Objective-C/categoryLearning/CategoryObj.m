//
//  CategoryObj.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/7.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CategoryObj.h"
#import <objc/runtime.h>

@interface CategoryObj()
@property NSString *prop2;
@property NSString *prop3;
@property NSString *prop4;

@end
@implementation CategoryObj

- (void)privateMethod{
    NSLog(@"%s",__func__);
}

+ (void)initialize{
    NSLog(@"%s",__func__);
}

+ (void)load{
    NSLog(@"%s",__func__);
}
- (void)test2{
    NSLog(@"%s",__func__);
}

- (void)print{
    NSLog(@"%s",__func__);
}

#pragma mark - g/setter

- (CGFloat)width{
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj doubleValue];
}

//- (void)setWidth:(CGFloat)width{
//    objc_setAssociatedObject(self, @selector(width), @(width), OBJC_ASSOCIATION_RETAIN);
//}
@end
