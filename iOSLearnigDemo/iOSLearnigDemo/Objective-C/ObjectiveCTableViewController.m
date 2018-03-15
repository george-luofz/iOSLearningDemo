//
//  ObjectiveCTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/15.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ObjectiveCTableViewController.h"

@interface ObjectiveCTableViewController ()

@end

@implementation ObjectiveCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Objective-C";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
//    [self _testBlock];
    
    [self _test_autoreleasepool];;
}
#pragma mark -- __block
// __block关键字修饰过后，可以改变其值
- (void)_testBlock{
    __block int a = 0;
    NSLog(@"block before:%p",&a);
    void (^func)(void) = ^{
        NSLog(@"block in:%p",&a);
    };
    NSLog(@"block after:%p",&a);
    func();
}

#pragma mark - autoreleasepool
- (void)_test_autoreleasepool{
   __weak NSString *a;
    @autoreleasepool{
       NSString *b = [NSString stringWithFormat:@"%@",@"dddd"];
        a = b;
    }
    NSLog(@"a:%@",a);
}
@end
