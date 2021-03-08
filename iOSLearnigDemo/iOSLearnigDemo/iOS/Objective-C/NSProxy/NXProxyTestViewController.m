//
//  NXProxyTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "NXProxyTestViewController.h"
#import "FZProxy.h"
#import "ClassA.h"
#import "ClassB.h"

@interface NXProxyTestViewController ()

@end

@implementation NXProxyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ClassA *clsA = [[ClassA alloc] init];
    ClassB *clsB = [[ClassB alloc] init];
    
    FZProxy *proxy = [FZProxy alloc];
    // 变身为clsA的代理
    [proxy transformToObject:clsA];
    [proxy performSelector:@selector(funcA) withObject:nil];
    // 变身为clsB的代理
    [proxy transformToObject:clsB];
    [proxy performSelector:@selector(funcB) withObject:nil];
    
}

/*
 1.代理类，实现了<NSObject>协议，performSelector等方法
 2.没有init方法
 3.子类需要实现methodSignature方法，及forwardToInvocation方法
 应用场景:
 1. 解决NSTimer循环引用
 2. 事件分发
 3. 模拟多继承
 */
@end
