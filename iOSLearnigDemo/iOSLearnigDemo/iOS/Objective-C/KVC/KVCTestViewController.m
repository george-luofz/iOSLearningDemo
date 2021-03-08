//
//  KVCTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/6.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "KVCTestViewController.h"
#import "KVCObject.h"

@interface KVCTestViewController ()

@end

@implementation KVCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    KVCObject *obj = [KVCObject new];
    
    [obj addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
//    [obj setValue:@(10) forKeyPath:@"age"];
    [obj setValue:@(10) forKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",change);
}

/* 1.KVC 调用顺序
1. set、_set
2. 判断accessInstanceVarierbleValues为NO，抛出异常
3. _age、_isAge、age、isAge顺序访问成员变量，都没有也抛异常
 */

/* 2. kvc 会触发kvo
 NSObject(NSKeyValueCoding)扩展，内部都会调用NSKeyValueNotifyObserver
 1. 有set方法走set逻辑
 2. 没有set方法，setValue:forKey: 会处理
 */

/* 3. kvc取值过程
 1. getAge、age、_age、isAge
 
 */

@end
