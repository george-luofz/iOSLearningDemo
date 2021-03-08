//
//  Person.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/4.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "Person2.h"
@interface Person2(){
    int age;
}
@end
@implementation Person2
- (void)test{
    NSLog(@"%s",__func__);
}

- (void)test2{
    SEL test_selector1 = @selector(test);
    NSLog(@"\n%p",[self class],test_selector1);
}
@end
