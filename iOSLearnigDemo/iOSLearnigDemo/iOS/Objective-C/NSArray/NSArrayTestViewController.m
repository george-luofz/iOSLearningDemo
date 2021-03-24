//
//  NSArrayTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/24.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "NSArrayTestViewController.h"
#import "FZMutableArray.h"

// 结构体内存布局跟对象不一样，打印肯定不对
//struct FZMutableArrayStruct {
//    unsigned long long _used;
//    unsigned long long _doHardRetain:1;
//    unsigned long long _doWeakAccess:1;
//    unsigned long long _size:62;
//    unsigned long long _hasObjects:1;
//    unsigned long long _hasStrongReferences:1;
//    unsigned long long _offset:62;
//    unsigned long long _mutations;
//    __unsafe_unretained id *_list;
//};

@interface NSArrayTestViewController ()

@end

@implementation NSArrayTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testArr];
//    [self testMutArr];
    
    [self testEmu];
}

/*
 OC数组有哪几种遍历方式?
 哪种方式效率最高?为什么?
 各种遍历方式的内部实现是怎么样的?
 NS(Mutable)Array的内部结构是怎么样的?
 */

// 环形队列，在两端插入、删除效率较高，头部删除，只需更新offset；头部插入，则插在最后一位，更新offset

- (void)testArr {
    NSArray *arr0 = [NSArray alloc]; //__NSPlaceholderArray
    NSArray *arrs = [[NSArray alloc] init]; //__NSArray0
    
    NSArray *arr1 = @[]; // __NSArray0
    NSArray *arr11 = @[@"ooooo"]; // __NSSingleObjectArrayI
    NSArray *arr12 = @[@"ooooo",@"ooool"]; // __NSArrayI
    NSArray *arr2 = [NSArray arrayWithObject:@"hhha"]; // __NSSingleObjectArrayI
    NSArray *arr3 = [NSArray arrayWithObjects:@"hhha",@"gggg",@"aaaa",nil]; // __NSArrayI
    NSMutableArray *arr4 = [NSMutableArray arrayWithCapacity:3]; //__NSArrayM
}

- (void)testMutArr {
    // ERROR:不能继承NSMutableArray,
    /*
     '*** -[NSMutableArray initWithCapacity:]: method only defined for abstract class.  Define -[FZTestMutableArray initWithCapacity:]!'
     */
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:3];
    [tempArr addObject:@"2"];
    
    // ERROR: 打印出来结果也不对
    FZMutableArray *fzArr = (FZMutableArray *)tempArr;
    NSLog(@"%llu, %llu, %llu",fzArr->_size,fzArr->_offset, fzArr->_used);
}

// for in最快，遍历器其次，for(int )第三，enu方法最慢
- (void)testEmu {
    NSInteger count = 1000;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0 ;i < count;i++) {
        [tempArr addObject:@(i)];
    }
    
    CFTimeInterval time1 = CACurrentMediaTime();
    for (int i = 0 ;i < count;i++) {
        int temp = [tempArr[i] integerValue];
    }
    CFTimeInterval time2 = CACurrentMediaTime();
    
    for (NSNumber *num in tempArr) {
        int temp = [num integerValue];
    }
    CFTimeInterval time3 = CACurrentMediaTime();
    
    [tempArr enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int temp = [obj integerValue];
    }];
    CFTimeInterval time4 = CACurrentMediaTime();
    
    NSEnumerator *enu = tempArr.objectEnumerator;
    NSNumber *num = nil;
    while (num = enu.nextObject) {
        int temp = [num integerValue];
    }
    CFTimeInterval time5 = CACurrentMediaTime();
    
    NSLog(@"%lf, %lf, %lf, %lf", (time2 - time1), (time3 - time2), (time4 - time3), (time5 - time4));
    // 0.000283, 0.000191, 0.000534, 0.000254
    
}

@end
