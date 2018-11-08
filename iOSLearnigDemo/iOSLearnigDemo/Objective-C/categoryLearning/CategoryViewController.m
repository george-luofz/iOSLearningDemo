//
//  CategoryViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryObj.h"
#import "CategoryObj+Test.h"
#import <objc/runtime.h>

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self _test_exetensions];
    
    [self _test_load_initilize];
    
//    [self _test_usePrivateMethod];
    [self _test_call_same_method];
    
    [self _testPointer];
}

#pragma mark -- extension
- (void)_test_exetensions{
    unsigned int count = 0;
    objc_property_t *propList = class_copyPropertyList([CategoryObj class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t prop = propList[i];
        NSLog(@"%d:%s",i,property_getName(prop));
    }
    free(propList);
}

- (void) _test_usePrivateMethod{
    [[CategoryObj new] privateMethod];
}

- (void)_test_load_initilize{
    [[CategoryObj new] test2];
}

- (void)_test_call_same_method{
    [[CategoryObj new] print];
    
    // 调用主类的print方法
    unsigned int count = 0;
    IMP mainIMP = NULL;
    Method *methodList = class_copyMethodList([CategoryObj class], &count);
    for(int i = 0 ;i < count;i++){
        Method method = methodList[i];
        SEL sel = method_getName(method);
        // 如果是print方法
        if([NSStringFromSelector(sel) isEqualToString:NSStringFromSelector(@selector(print))]){
            mainIMP = method_getImplementation(method);
        }
    }
    if(mainIMP){
//        mainIMP();
    }
}

#pragma mark - tagged pointer

- (void)_testPointer{
    CategoryObj *obj = [CategoryObj new];
    obj.width = 100;
    NSLog(@"obj width:%lf, %@",obj.width,@(obj.width));
    obj.width = 100.1f;
    NSLog(@"obj width2:%lf, %@",obj.width,@(obj.width));
}
@end
