//
//  TestRuntimeForward.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "TestRuntimeForward.h"
#import <objc/runtime.h>

@interface TestObj : NSObject
- (void)test;
@end

@implementation TestObj
- (void)test{
    NSLog(@"%s",__func__);
}
@end

@implementation TestRuntimeForward

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSEL = @selector(say);
        SEL newSEL = @selector(newSay);
        // 替换一个方法
        Method originalMethod = class_getInstanceMethod(self, originalSEL);
        Method newMethod = class_getInstanceMethod(self, newSEL);
        // 添加一个方法
        BOOL flag = class_addMethod(self, originalSEL, method_getImplementation(newMethod), "v@:");
        if(flag){
            class_replaceMethod(self, newSEL, method_getImplementation(originalMethod), "v@:");
        }else{
            method_exchangeImplementations(originalMethod, newMethod);
        }
    });
}
- (void)say{
    NSLog(@"hello world");
}

- (void)newSay{
    NSLog(@"hello new world");
}

- (void)test_self_super{
    NSLog(@"\nself class:%@\nsuper class:%@",[self class],[super class]);
}

-(void)_testIMP{
    NSLog(@"%s",__func__);
    [self _test_getPropertyList];
}
#pragma Mark - 消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if([NSStringFromSelector(sel) isEqualToString:@"test"]){
        Method method = class_getInstanceMethod(self, @selector(_testIMP));
        bool success = class_addMethod(self, @selector(test), method_getImplementation(method), "v@:");
        if(success) return YES;
        return NO;
    }
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if([NSStringFromSelector(aSelector) isEqualToString:@"test"]){
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
//    if([NSStringFromSelector(aSelector) isEqualToString:@"test"]){
//        return [[TestObj alloc] init];
//    }
    return [super forwardingTargetForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    SEL sel = anInvocation.selector;
//    if([NSStringFromSelector(sel) isEqualToString:@"test"]){
//        TestObj *obj = [TestObj new];
//        if([obj respondsToSelector:sel]){
//            [anInvocation invokeWithTarget:obj];
//            return;
//        }
//    }
    [super forwardInvocation:anInvocation];
}
- (Class)class{
    return [NSObject class];
}

#pragma mark -- 添加protocol
- (void)_test_addProtocol{
    Protocol *protocol = objc_allocateProtocol("heehehhe");
    objc_registerProtocol(protocol);
    class_addProtocol([self class], protocol);
    
}

#pragma mark -- 添加属性/变量
- (void)_test_addProperty{
//    class_addProperty(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>, <#const objc_property_attribute_t * _Nullable attributes#>, <#unsigned int attributeCount#>)
}

#pragma mark -- 获取属性列表
- (void)_test_getPropertyList{
    int count = 0;
//    objc_property_t *prop = class_copyPropertyList([self class], &count);
    
    objc_property_t *prop = class_copyPropertyList(objc_getClass("TestRuntimeForward"), &count);
    for(int i = 0 ;i < count;i ++){
        NSLog(@"%d,%s", i,property_getName(prop[i]));
    }
    free(prop);
}

- (NSString *)description{
    return [NSString stringWithFormat:@"prop=%@",_prop]; //description中不能打印self，不然会递归
}
@end



#pragma mark -- 协议可以多继承
@protocol a <NSObject>
@end

@protocol b <NSObject>
@end

@protocol c <a,b>
@end
