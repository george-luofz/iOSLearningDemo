//
//  WeakTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/9.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "WeakTestViewController.h"
#import "WeakObject.h"
#import "TagPointerNum.h"

@interface WeakTestViewController ()

@end

@implementation WeakTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test_callback];
    
    [self testTagPointer];
}

/* __weak 原理
 objc_initWeak //非线程安全
    store_weak();
        
*/

/* SideTable结构体
 struct SideTable {
     spinlock_t slock;
     RefcountMap refcnts;
     weak_table_t weak_table;
 */

/*
 T& operator[] (const void *p) {
     return array[indexForPointer(p)].value;
 }
 */

- (void)test_fun1 {
    NSObject *obj = [NSObject new];
//    __weak NSObject *weakObj = obj;
    id __weak weakObj = obj;
    __weak typeof(self) weakSelf = self;
    NSLog(@"%s",__func__);
}

- (void)test_callback {
    WeakObject *obj = [WeakObject new];
    __weak WeakObject *weakObj = obj;
    [weakObj testMethod];
}

#pragma mark - tag pointer

- (void)testTagPointer {
    TagPointerNum *tpNum = [TagPointerNum numberWithInt:1];
    
}

@end
