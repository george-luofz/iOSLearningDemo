//
//  ARCObject.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ARCObject.h"

@implementation ARCObject
- (void)test{
    // 1. unsafe_unretained
    [self _test_unsafe_unRetained];
    
//    NSMutableArray * __unsafe_unretained str = [[NSMutableArray alloc] init]; //会崩溃
    NSString * __unsafe_unretained str = [[NSString alloc] init]; //不会崩溃
    NSLog(@"str: %@",str);
    NSInteger count = _objc_rootRetainCount(str);
    NSLog(@"%@ before retainCount:%ld",str,count);
    [self _test_functionParamType:str];
    NSInteger count2 = _objc_rootRetainCount(str);
    NSLog(@"%@ after retainCount:%ld",str,count2);
}
#pragma mark -- ARC
#pragma mark -- 变量标识符 __unsafe_unRetained 和 __weak 、__strong、 __autoreleasing
- (void)_test_unsafe_unRetained{
    //1. ARC下，obj并未持有对象，对象立即释放，所以下边应该崩溃；非ARC下不会崩溃，虽然没有引用，但要手动释放
//    NSMutableArray __unsafe_unretained *obj = [[NSMutableArray alloc]init];
//    [obj addObject:@"obj"];
    
//    NSMutableArray __unsafe_unretained *array = [NSMutableArray array];
//    [array addObject:@"124"];
    
    //2.
    id __unsafe_unretained obj1 = nil;
//    @autoreleasepool{
    
        {
            //        id  obj0 = [[NSMutableArray alloc] init];      //会崩溃
            //[NSMutableArray array] 会崩溃原因是：
            //objc_autoreleaseReturnValue函数会检查使用该函数的方法或函数调用方的执行命令列表，如果方法或函数的调用方在调用了方法或函数后紧接着调用objc_retainAutoreleasedReturnValue函数，那么就不将返回的对象注册到autoreleasepool中，而是直接传递到方法或函数的调用方
            //                id  obj0 = [NSMutableArray array];
            id  obj0 = [NSMutableArray arrayWithObjects:@"234", nil]; //不会崩溃，内部有retain
            
            [obj0 addObject:@"obj"];
            obj1 = obj0;
            NSLog(@"obj0 = %@", obj0);
        }
//    }
    // obj0强引用仅限{}作用域，出了作用域之后，就释放掉了
    NSInteger count = _objc_rootRetainCount(obj1);
    
    NSLog(@"obj1 = %@", obj1);
    
    // 2. 测试函数返回值这种情况
    id __unsafe_unretained obj2 = nil;  //大括号作用域，超出大括号之后，对象就会被释放
    {
        id obj0 = [[self class] allocObject]; // obj0强引用对象，当出了作用域之后，对象失去强引用，所以被释放
        [obj0 addObject:@"obj"];
        obj2 = obj0;
        NSLog(@"obj0 = %@", obj0);
    }
    
    NSLog(@"obj2 = %@", obj2);
    
}

+ (id)Object
{
    return [[NSMutableArray alloc] init]; //崩溃
}
+ (id)allocObject
{
//    return [NSMutableArray array]; // 崩溃
    return [NSMutableArray arrayWithObjects:@"134", nil]; // 不崩溃
}
+ (id)Object2
{
    NSMutableArray *marr = [NSMutableArray array]; //会崩溃
    return marr;
}
// __autoreleasing使用时机
// 1.对象作为函数的返回值，runtime会在返回时自动调用objc_autoreleaseReturnValue()函数，不过有个坑：如果发现紧接着调用了objc_retainAutoreleasedReturnValue方法，则不会加入autoreleasepool中
// 2.id类型指针,即id *p这种；或者叫对象指针，类似于NSError **error;

- (void)_test_strong{
    id __strong obj0;
    id __weak obj1;
    id __autoreleasing obj2;
    // __strong,__weak,__autoreleasing可以保证附有这些修饰符的自动变量初始化为nil
}
// 疑惑：函数参数的默认类型是啥?
- (void)_test_functionParamType:(NSString *)str{ //str引用计数没变，要么是__autorelease的，要么是__weak的
    NSInteger count = _objc_rootRetainCount(str);
    NSLog(@"%@ retainCount:%ld",str,count);
}
@end
