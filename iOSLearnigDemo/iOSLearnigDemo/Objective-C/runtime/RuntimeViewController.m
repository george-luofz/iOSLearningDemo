//
//  RuntimeViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/1.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import "TestRuntimeForward.h"
#import "TestRuntimeForward+category.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.元类是个啥玩意
//    [self _test_meta_class];
    [self _test_metaClass2]; //http://ios.jobbole.com/81657/
    
    // 3. runtime_forward
    [self _test_message_forward];
    
    // 4. self super
    [self _test_self_super];
    // 5. invocation
    [self _test_invocation];
    // 6. category
    [self _test_category_addProp];
    // 7. json to model
    [self _test_jsonToModel];
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
    Class cls = objc_getClass("RuntimeErrorSubclass");
    if(cls) return;
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

#pragma mark -- 消息转发
- (void)_test_message_forward{
    [[TestRuntimeForward new] test];
}

#pragma mark -- self super
- (void)_test_self_super{
//    NSLog(@"self:%@ super:%@ %s",self,super,__func__);
    
//    NSLog(@"self class:%@\nsuper class:%@",[self class],[super class]);
    [[TestRuntimeForward new] test_self_super];
}

+ (void)_test_self_super{
//    NSLog(@"self:%@ super:%@ %s",self,super,__func__);
}

#pragma mark -- NSInvocation
- (void)_test_invocation{
    
    NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@::"];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(_test_invocation_print:)];
    int a = 2;
    [invocation setArgument:&a atIndex:2];
//    [invocation retainArguments];
    [invocation invoke];
}
- (void)_test_invocation_print:(int)a{
    NSLog(@"%s a=%d",__func__,a);
}

#pragma mark -- category
- (void)_test_category_addProp{
    TestRuntimeForward *obj = [TestRuntimeForward new];
    obj.prop = @"hhh";
    NSLog(@"prop%@",obj.prop);
}

#pragma mark -- json to model
- (void)_test_jsonToModel{
    NSDictionary *dict = @{@"prop":@"value",@"prop2":@"value2",@"prop3":@"value3"};
    
    TestRuntimeForward *model = [TestRuntimeForward new];

    unsigned int count = 0;
    objc_property_t *propList =  class_copyPropertyList(objc_getClass("TestRuntimeForward"), &count);
    for(int i = 0 ; i < count;i++){
        objc_property_t prop = propList[i];
        const char *name = property_getName(prop);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id value = [dict valueForKey:nameStr];
        if(value){
            [model setValue:value forKey:nameStr];
        }
    }
    free(propList);
    NSLog(@"model:%@",model);
}
@end
