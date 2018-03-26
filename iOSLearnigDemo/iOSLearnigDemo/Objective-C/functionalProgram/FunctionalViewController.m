//
//  FunctionalViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/26.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "FunctionalViewController.h"

@interface Persons:NSObject
//- (Person *)run;
- (Persons *(^)(void))run;
- (void)study;
@end
@implementation Persons
//- (void)run{
//    NSLog(@"%s",__func__);
//}
//- (void)study{
//    NSLog(@"%s",__func__);
//}
//- (Person *)run{
//    NSLog(@"%s",__func__);
//    return [Person new];
//}
//- (void)study{
//    NSLog(@"%s",__func__);
//}
- (Persons *(^)(void))run{
    NSLog(@"%s",__func__);
    Persons* (^block)(void) = ^(){
        NSLog(@"run");
        return self;
    };
    return block;
}
- (void)study{
    NSLog(@"%s",__func__);
}
@end
@interface FunctionalViewController ()

@end

@implementation FunctionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 函数式编程
- (void)_test_functionalProgram{
    // 1.普通编程
    Persons *person = [Persons new];
    [person run];
    [person study];
    
    // 2.函数
    // person.runBlock().studyBlock();
    // 3.先实现这种
    [[person run] study];
    // 4.实现最终效果，返回一个block
    [person.run() study];
//    [person.run study];
    [[person run]() study];
    [person study];
}

@end
