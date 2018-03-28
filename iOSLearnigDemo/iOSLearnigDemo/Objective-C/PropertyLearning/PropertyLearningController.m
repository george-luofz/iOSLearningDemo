//
//  PropertyLearningController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "PropertyLearningController.h"
typedef void(^Block) (void);

@interface PropertyLearningController ()
@property (nonatomic, strong) Block block1;
@property (nonatomic, copy)   Block block2;
@property (nonatomic, retain) Block block3;

@property (nonatomic, copy)   NSString *string1;
@property (nonatomic, strong) NSString *string2;

@property (nonatomic, unsafe_unretained) NSString *a;
@property (nonatomic, weak) NSString *b;

//总共是6种，unsafe_unretained和retain常常忘记
@end

@implementation PropertyLearningController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _test1];
    [self _test_copy_mutableCopy];
}

#pragma mark --
// strong / retain
// retain 修饰的block不会被copy
- (void)_test1{
    Block block1 = ^(void){
        NSLog(@"block1 test");
    };
    Block block2 = ^(void){
        NSLog(@"block2 test");
    };
    Block block3 = ^(void){
        NSLog(@"block3 test");
    };
    self.block1 = block1;
    self.block2 = block2;
    self.block3 = block3;
    
    NSLog(@"\nblock1:%@\nstrong block1:%@\nblock2:%@\ncopy block2:%@\nblock3:%@\nstrong block3:%@",block1,_block1,block2,_block2,block3,_block3);
    // 打印结果
    /*
     block1:<__NSGlobalBlock__: 0x100234448>
     strong block1:<__NSGlobalBlock__: 0x100234448>
     block2:<__NSGlobalBlock__: 0x100234488>
     copy block2:<__NSGlobalBlock__: 0x100234488>
     block3:<__NSGlobalBlock__: 0x1002344c8>
     strong block3:<__NSGlobalBlock__: 0x1002344c8>
     */
    // 都是一样的，这是为何
    // 浅拷贝
    
    
    NSString *string1 = @"1111";
    NSString *string2 = @"2222";
    self.string1 = string1;
    self.string2 = string2;
    NSString *string3 = @"3333";
    NSString *copyString = [string3 copy]; // 浅拷贝，只是引用计数加1
    NSMutableString *mutableCopyString = [string3 mutableCopy];
    [mutableCopyString appendString:@"1235"];
    NSLog(@"\nstring1:%p\ncopy string1:%p\nstring2:%p\nstrong string2:%p\nstring3:%p\ncopy string3%p\nmutableCopyString3:%p",string1,self.string1,string2,self.string2,string3,copyString,mutableCopyString);
    
    
    // 释放之后，copy的还在，那么不知道拷贝的是啥
    NSString *testStr = @"1123";
    NSString *copyTestStr = [testStr copy];
    testStr = nil;
    NSLog(@"testStr:%p,copy %p",testStr,copyTestStr);
    
}
// copy 与 mutableCopy
- (void)_test_copy_mutableCopy{
    NSArray *array = [NSArray arrayWithObject:@(1)];
    NSArray *copyArray = [array copy];
    NSMutableArray *mutableCopyArray = [array mutableCopy];
    NSLog(@"array:%p,copyArray:%p,mutableCopyArray:%p",&array,&copyArray,mutableCopyArray);
    // 可变容器对象
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@(2)];
    NSArray *copyMutableArray = [mutableArray copy];
    NSArray *mutableCopyMutableArray = [mutableArray mutableCopy];
    NSLog(@"mutableArray:%p,copyMutableArray:%p,mutableCopyMutableArray:%p",mutableArray,copyMutableArray,mutableCopyMutableArray);
    // 打印新array中元素的地址，由下图可见元素地址都是相同的，所以深拷贝只拷贝对象本身，其元素依然是浅拷贝
    NSLog(@"mutableArray obj:%p,copyMutableArray obj:%p,mutableCopyMutableArray obj:%p",mutableArray.firstObject,copyMutableArray.firstObject,mutableCopyMutableArray.firstObject);
    
    // 可变容器的copy与mutableCopy属于单层深拷贝，
    // 1.如果想完全深拷贝，可以使用系统提供的API
    // 2.可以使用NSKeyArchiver，生成一个新的
    
    // ***********
    // 加深理解：nil与release区别
    // 将变量置为nil，只是将该指针变量置空，对象本身引用计数没发生变化，所以不会立即释放；要release才会将引用计数-1，最终对象释放
    // 所以copy方法拷贝的是一个新的指针变量，对象本身还是独一份
}
// assgin 与 weak

@end
