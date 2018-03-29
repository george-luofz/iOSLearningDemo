//
//  MemoryManageViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MemoryManageViewController.h"
#import "MRCObject.h"
#import "ARCObject.h"

@interface MemoryManageViewController ()

@end

@implementation MemoryManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self _testMRC];
    [self _testARC];
}

#pragma mark -- MRC
- (void)_testMRC{
    
//    #if(!__has_feature(objc_arc))
    MRCObject *obj = [[MRCObject alloc] init];  // init引用计数为1
    [obj test];
//    [obj release];
//    #endif
    
}

- (void)_testARC{
    ARCObject *obj = [[ARCObject alloc] init];
    [obj test];
}
@end
