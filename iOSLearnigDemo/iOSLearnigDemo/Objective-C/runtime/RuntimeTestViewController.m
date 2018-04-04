//
//  RuntimeTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/4.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "RuntimeTestViewController.h"
#import <objc/runtime.h>
#import "Person2.h"

@interface RuntimeTestViewController ()
@end

@implementation RuntimeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSObject *se;
    [self _test_IMP];
    [self _test_superKeyWords];
    [self _test_ivarList];
//    [self _test_runtime_method];
    
    [self _test_runtime_selector];
}
#pragma mark -- self/super
- (void)_test_superKeyWords{
    NSLog(@"hahahhah");
    Class selfClass = [self class];
    Class superClass = [super class];
    
    NSLog(@"self:%@,super:%@",selfClass,superClass);
}

// 直接通过IMP调用方法，不走cache那一套
- (void)_test_IMP{
    void (*imp)(id receiver, SEL sel, ...);
    // methodForSelector NSObject对象方法
    imp = (void(*)(id,SEL,...))[self methodForSelector:@selector(_test_IMP_Log)];
    imp(self,@selector(_test_IMP_Log));
}
- (void)_test_IMP_Log{
    // c语言预定义符
    NSLog(@"%s %s %s %d %s",__func__,__DATE__,__FILE__,__LINE__,__TIME__);
}

#pragma mark -- ivar
- (void)_test_ivarList{
    int outCount = 0;
    Ivar *varList = class_copyIvarList(objc_getClass("Person2"), &outCount);
    int outCount2 = 0;
    objc_property_t *propList = class_copyPropertyList(objc_getClass("Person2"), &outCount2);
    
    for(int i = 0 ;i < outCount;i++){
        Ivar ivar = varList[i];
        char *name = ivar_getName(ivar);
        NSLog(@"ivar: %s\n",name);
    }
    for(int i = 0 ;i < outCount2;i++){
        objc_property_t pro = propList[i];
        char *name = property_getName(pro);
        NSLog(@"prop:%s\n",name);
    }
    free(varList);
    free(propList);
    
    // 2. 新建一个类，添加ivar
    
    Class TestObjectClass = objc_allocateClassPair(NSClassFromString(@"NSObject"), "TestObject", sizeof(48));
    // 2.1添加一个属性
    BOOL flag = class_addIvar(TestObjectClass, "prop", sizeof(int), 0, @encode(int));
    if(flag){
        NSLog(@"%@ add ivar:prop success",TestObjectClass);
    }else{
        NSLog(@"%@ add ivar:prop success",TestObjectClass);
    }
    objc_registerClassPair(TestObjectClass);
    // 2.2 打印一下
    [self _test_printf_classIvarList:TestObjectClass];
    
    // 2.3 添加一个方法
}

- (void)_test_printf_classIvarList:(Class)class{
    int outCount = 0;
    Ivar *varList = class_copyIvarList(class, &outCount);
    for(int i = 0 ;i < outCount;i++){
        Ivar ivar = varList[i];
        char *name = ivar_getName(ivar);
        NSLog(@"%@ ivar: %s\n",class,name);
    }
}
#pragma mark -- method
- (void)_test_runtime_method{
    // 1.替换一个方法 Person2 test

    // 1.拿到selector对应的方法
    Method swizzMethod = class_getInstanceMethod([self class], @selector(_test_person_replace_method));
    Method originalMethod = class_getInstanceMethod([Person2 class], @selector(test));
    // 2.尝试用替换方法为主类添加一个方法
    BOOL success = class_addMethod([Person2 class], @selector(test), method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    // 2.1 添加成功；说明Person2中没有test方法，则说明父类有实现，将替换方法实现改为父类的实现
    if(success){
        class_replaceMethod([Person2 class], @selector(_test_person_replace_method), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        // 2.2 未添加成功，交换方法的imp
        method_exchangeImplementations(originalMethod, swizzMethod); //直接替换两个实现
    }
    
    
    [[Person2 new] test];
    // 2.添加一个方法
    
    
}

- (void)_test_person_replace_method{
    NSLog(@"%s",__func__);
}

#pragma mark -- selector
- (void)_test_runtime_selector{
    // 1. 三种方式获取SEL
    SEL selector1 = @selector(_test_runtime_method);
    SEL selector2 = sel_registerName("_test_runtime_method");
    SEL selector3 = NSSelectorFromString(@"_test_runtime_method");
    NSLog(@"1:%p,2:%p,3:%p",selector1,selector2,selector3);
    
    // 2.不同类相同名字的方法获取到的SEL是一样的
    SEL test_selector1 = @selector(test2);
    SEL test_selector2 = @selector(test:);
    NSLog(@"\n1:%p\n2:%p",test_selector1,test_selector2);
    [[Person2 new] test2];
    // 3.执行方法
    [self performSelector:test_selector1];
    void (*imp)(id re,SEL se);
    imp = (void (*)(id re,SEL se))[self methodForSelector:test_selector1];
    imp(self,@selector(test));
    
}

- (void)test:(NSString *)str{
    
}

- (void)test2{
    NSLog(@"%s",__func__);
}

@end
