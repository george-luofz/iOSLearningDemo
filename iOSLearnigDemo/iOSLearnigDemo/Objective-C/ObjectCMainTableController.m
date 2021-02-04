//
//  ObjectCMainTableController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ObjectCMainTableController.h"
#import "PropertyLearningController.h"
#import "CategoryViewController.h"
#import "AutoreleasePoolController.h"
#import "MemoryManageViewController.h"
#import "RuntimeTestViewController.h"
#import "NetworkRequsetTestController.h"

@interface ObjectCMainTableController ()
@property (nonatomic, nullable, strong) NSArray *dataSource;
@end

@implementation ObjectCMainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = 10;
    double b = 20;
    float c = 30;
    
    
    self.dataSource = @[@"property相关",@"category",@"autoreleasepool",@"内存管理",@"runtime",@"网络模块"];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerFuc:) userInfo:nil repeats:YES];
//    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSString *string = @"sdkjflsdj";
    NSString *newStr = [string stringByAppendingPathComponent:nil];
    NSLog(@"newStri:%@",newStr);
    
//    NSMutableDictionary *dict = [@{} mutableCopy];
//    NSLog(@"%@",[dict objectForKey:nil]);
//    [dict setObject:@{} forKey:nil];
//    NSLog(@"dict:%@",dict);
}

- (void)timerFuc:(NSTimer *)timer{
    NSLog(@"%s",__func__);
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    if(indexPath.row == 0){
        vc = [PropertyLearningController new];
    }else if (indexPath.row == 1){
        vc = [CategoryViewController new];
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        vc = [MemoryManageViewController new];
    }else if (indexPath.row == 4){
        vc = [RuntimeTestViewController new];
    }else if (indexPath.row == 5){
        vc = [NetworkRequsetTestController new];
    }
    if(vc){
        vc.title = self.dataSource[indexPath.row];
        [self pushToVc:vc];
    }
    
}
@end
