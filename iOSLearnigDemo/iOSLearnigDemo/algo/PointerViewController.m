//
//  PointerViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/25.
//  Copyright © 2018年 George_luofz. All rights reserved.
//  指针学习：

#import "PointerViewController.h"
#import "ListNode.h"
@interface PointerViewController ()

@end

@implementation PointerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _test_pointer];
}

- (void)_test_pointer{
    int a = 1;
    int *p = &a;
    int **p_ref = &p; //指向p的地址
    int ***p_ref_ref = &p_ref; //指向p_ref的地址
    
    NSLog(@"\n&a:%p\np:%p\n&p:%p\np_ref:%p\n*p_ref:%p\n&p_ref:%p\np_ref_ref:%p\n",&a,p,&p,p_ref,*p_ref,&p_ref,p_ref_ref);
}
@end
