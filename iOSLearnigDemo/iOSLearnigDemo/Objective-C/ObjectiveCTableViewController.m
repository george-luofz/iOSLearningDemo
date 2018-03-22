//
//  ObjectiveCTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/15.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ObjectiveCTableViewController.h"
#import "Person.h"

@interface ObjectiveCTableViewController ()
{
//    __weak NSString *_weakValue;
}
@property (nonatomic, weak) NSString    *weakValue;
@end

@implementation ObjectiveCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Objective-C";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
//    [self _testBlock];
//    [self _test_bitHandle];
//    [self _test_yihuo];
//    [self _test_gcd_gloableQueue_runloop];
//    [self _test_copy_mutableCopy];
    [self _test_gcd];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"%s : a = %@",__func__,_weakValue);
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%s : a = %@",__func__,_weakValue);
//}
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
//   __weak NSString *a;
//    @autoreleasepool{
       NSString *b = [NSString stringWithFormat:@"%@",@"dddd"];
        _weakValue = b;
//    }
    NSLog(@"a:%@",_weakValue);
}

#pragma mark -- 位操作
//基础知识，参考：http://weihe6666.iteye.com/blog/1190033
// 正数的原码、反码和补码都相同
// 负数的反码为原码除符号位外各位取反，补码为反码加1，计算机中用补码表示负数
- (void)_test_bitHandle{
    int a = -10;
    // 1.判断正负，右移31位即可，i的值要么是0，要么是1
    int i = a >> 31;
    // 2.变换符号，就是取反加1；
    // 3.那么取绝对值就是先判断符号正负，再决定是否变化符号
//    int newI = i == 0 ? a : ~a + 1;
//    NSLog(@"%d",newI);
    // -----如果要求取绝对值不用逻辑表达式
    // 由于i要么是0要么是1，
    // i = 0时，与i亦或还是自身，再-0数值不变
    // i = -1时，与-1亦或就是取反，再减-1就是+1，因为-1就是0x111111...
    int newI2 = (a ^ i) - i;
    NSLog(@"%d",newI2);
    
//    int a,b;
//    a ^ = b;
//    b ^ = a;
//    a ^ = b;
}
// 题目：在一个数组中除1个数字只出现1次外，其它数字都出现了2次， 要求尽快找出这个数字
// 分析：由于数组中其他数字都出现了两次，利用异或的特点，两个相同异或得0，与0异或还是自身，即可求得结果
- (void)_test_yihuo{
    NSArray *arr = @[@(1),@(2),@(2),@(5),@(5),@(789),@(312),@(312),@(789)];
    int v = 0;
    for(int i = 0 ;i < arr.count; i++){
         v ^= [arr[i] intValue];
    }
    NSLog(@"result:%d",v);
    
    const int MAXN = 15;
    
    int a[MAXN] = {1, 347, 6, 9, 13, 65, 889, 712, 889, 347, 1, 9, 65, 13, 712};
    int lostNum = 0;
    for (int i = 0; i < MAXN; i++)
        lostNum ^= a[i];
    printf("缺失的数字为:  %d\n", lostNum);
}

#pragma mark -- runloop
- (void)_test_gcd_gloableQueue_runloop{
    dispatch_queue_t queue = dispatch_queue_create("com.yixia.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSThread *currentThread = [NSThread currentThread];
//        [self performSelectorOnMainThread:@selector(_test_yihuo) withObject:nil waitUntilDone:YES];
        [self performSelector:@selector(_test_yihuo) onThread:currentThread withObject:nil waitUntilDone:YES];
    });
}

#pragma mark - copy与mutableCopy
- (void)_test_copy_mutableCopy{
    // 可变对象
    NSMutableString *mutString = [NSMutableString stringWithString:@"abc"];
    NSMutableString *copyString = [mutString copy];
    NSMutableString *mutableCopyString = [mutString mutableCopy];
    NSLog(@"mutString:%p,copyString:%p,mutableCopyString:%p",mutString,copyString,mutableCopyString);
//    [copyString appendString:@"aaaa"]; //此处会引发崩溃
    // 容器对象
    NSArray *array = [NSArray arrayWithObject:@(1)];
    NSArray *copyArray = [array copy];
    NSMutableArray *mutableCopyArray = [array mutableCopy];
    NSLog(@"array:%p,copyArray:%p,mutableCopyArray:%p",array,copyArray,mutableCopyArray);
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@(2)];
    NSArray *copyMutableArray = [mutableArray copy];
    NSArray *mutableCopyMutableArray = [mutableArray mutableCopy];
    NSLog(@"mutableArray:%p,copyMutableArray:%p,mutableCopyMutableArray:%p",mutableArray,copyMutableArray,mutableCopyMutableArray);
    // 打印新array中元素的地址
    NSLog(@"mutableArray obj:%p,copyMutableArray obj:%p,mutableCopyMutableArray obj:%p",mutableArray.firstObject,copyMutableArray.firstObject,mutableCopyMutableArray.firstObject);
    
    // 自定义对象
    Person *person = [[Person alloc] init];
    person.name = @"luofuzhong";
    person.year = 26;
    Person *copyPerson = [person copy];
    Person *mutableCopyPerson = [person mutableCopy];
    NSLog(@"person:%p,copyPerson:%p,mutableCopyPerson:%p",person,copyPerson,mutableCopyPerson);
}

#pragma mark -- gcd
// gcd block cancel
- (void)_test_gcd{
    dispatch_queue_t queue = dispatch_queue_create("com.Maker", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t firstTask = dispatch_block_create(0, ^{
        NSLog(@"开始第一个任务");
        sleep(3.0);
        NSLog(@"结束第一个任务");
        
    });
    dispatch_block_t secondTask = dispatch_block_create(0, ^{
        NSLog(@"开始第二个任务");
        sleep(4.0);
        NSLog(@"结束第二个任务");
        
    });
    dispatch_async(queue, firstTask);
    dispatch_async(queue, secondTask);
    dispatch_block_cancel(firstTask);
    NSLog(@"尝试取消第一个任务");
    long code = dispatch_block_testcancel(firstTask);
    if (code == 0) {
        NSLog(@"已经开始执行第一个任务");
    } else {
        NSLog(@"已经取消第一个任务");
    }
    dispatch_block_cancel(secondTask);
    NSLog(@"尝试取消第二个任务");
    long code2 = dispatch_block_testcancel(secondTask); // 第二个任务不能取消掉，这个方法不准确
    if (code2 == 0) {
        NSLog(@"已经开始执行第二个任务");
    } else {
        NSLog(@"已经取消第二个任务");
    }
}
@end
