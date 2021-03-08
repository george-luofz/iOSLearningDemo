//
//  CategoryObj+new.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/7.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CategoryObj+Test.h"
#import <objc/runtime.h>

@implementation CategoryObj (Test)

+ (void)load{
    NSLog(@"%s",__func__);
}

+ (void)initialize{
    NSLog(@"%s",__func__);
}

- (void)print{
    NSLog(@"%s",__func__);
}
@end
