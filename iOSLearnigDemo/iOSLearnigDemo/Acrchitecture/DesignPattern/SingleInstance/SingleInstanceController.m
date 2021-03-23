//
//  SingleInstanceController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "SingleInstanceController.h"
#import "SingleTest.h"

@interface SingleInstanceController ()

@end

@implementation SingleInstanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SingleTest *test1 = [SingleTest shareInstance];
//    SingleTest *test2 = [test1 copy];
//    SingleTest *test3 = [SingleTest new];
    
//    NSLog(@"%@, %@, %@",test1, test2, test3);
}

// 1.重写allocWithZone copyWithZone mutableCopyWithZone
// 2.利用编译器属性，禁止访问new、alloc、init、copy等
// 3.NSZone一段内存，传nil，不能单独创建
@end
