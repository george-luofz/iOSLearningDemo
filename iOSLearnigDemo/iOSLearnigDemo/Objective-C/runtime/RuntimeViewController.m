//
//  RuntimeViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/1.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.元类是个啥玩意
//    [self _test_meta_class];
    [self _test_metaClass2]; //http://ios.jobbole.com/81657/
}
#pragma mark -- 元类

- (void)_test_meta_class{
    NSArray *arr = [NSArray array];
    Class cls = [arr class];
    int i = 0;
    
    while (1) {
        NSLog(@"%d---cls:%p---nsobject:%p", i, cls, objc_getMetaClass("NSObject"));
        
        i++;
        if (cls == objc_getMetaClass("NSObject")) break;
        
        cls = object_getClass(cls);
    }
}
/*
 2018-04-01 18:27:29.599275+0800 iOSLearnigDemo[6651:377543] 0---cls:0x10d57b4e8---nsobject:0x10cff5e58
 2018-04-01 18:27:29.599580+0800 iOSLearnigDemo[6651:377543] 1---cls:0x10d57b510---nsobject:0x10cff5e58
 2018-04-01 18:27:29.599701+0800 iOSLearnigDemo[6651:377543] 2---cls:0x10cff5e58---nsobject:0x10cff5e58
 */

- (void)_test_metaClass2{
    Class newClass =
    objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    objc_registerClassPair(newClass);
    Class metaClass =  [newClass class];
    
    
    id instanceOfNewClass =
    [[newClass alloc] initWithDomain:@"someDomain" code:0 userInfo:nil];
    [instanceOfNewClass performSelector:@selector(report)];
    
}

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 4; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}


@end
