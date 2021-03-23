//
//  MemoryBaseViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MemoryBaseViewController.h"

@interface MemoryBaseViewController ()

@end

@implementation MemoryBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 栈溢出，触发crash，stack_guard
//    [self test_stack_guard];
    
    fibonacci(10000);
}

#pragma mark -

- (void)test_stack_guard {
    int buf[1024*1024 * 80] = {0};
}

int fibonacci(int n) {
    if (n == 1) {
        return 1;
    }
    if (n == 2) {
        return 2;
    }
    return fibonacci(n) * fibonacci(n - 1);
}

#pragma mark - 1. iOS/Mac栈的大小是多少？
/*
 
 iOS上主线程栈空间大小为1MB
 iOS上子线程栈空间大小为512KB
 Mac OS上主线程栈大小为8MB
 对于子线程，线程的栈大小是在线程创建的时候就创建好的，但是只有实际使用到的时候才会分配到具体内存；同时，子线程能够允许的最小栈大小为16KB，且栈的大小必须是4KB的整数倍。

 */

#pragma mark - 2. 怎么避免栈溢出崩溃？
/*
 
 栈上申请内存不要超过512KB，建议超过100KB以上的内存申请，都使用堆上的内存分配方式，malloc,calloc等
 使用操作内存读写的系统函数时，保证大内存的内存操作在堆上进行
 避免使用递归，所有的递归都可以使用循环实现。即使不得不使用递归，也要对递归调用层次做优化和控制（感谢@老青菜提出的宝贵意见）。
 
 */

@end
