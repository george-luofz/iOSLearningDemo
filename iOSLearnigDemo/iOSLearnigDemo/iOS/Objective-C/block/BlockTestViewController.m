//
//  BlockTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "BlockTestViewController.h"
#import "TestClass.h"
#import "BlockObj.h"
typedef void(^Block) (void);
typedef void(^Block) (void);

@interface BlockTestViewController ()

@end

@implementation BlockTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestClass *classes = [TestClass new];
    [classes testMethods];
    
    // 2. block copy时机
    Block block = ^(void) {
        NSLog(@"block copy test");
    };
    NSLog(@"%@",block);
    
    // 3. auto对象类型强引用、弱引用
    BlockObj *person = [BlockObj new];
    __weak typeof(person) weakP = person;
    Block blockP = ^ {
        NSLog(@"%@",weakP);
    };
    NSLog(@"blockP %@",blockP);
}

// 2. copy时机
// 返回值
// 局部变量
// cocoa / gcd 

// 3. block 对block内引用对象内存管理
// block在栈上，对内部对象不会强引用，因为自己生命周期随时会死
// block在堆上，对对象调用_Block_object_assign，根据对象的修饰符决定强、弱引用

@end
