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
#import "TimerViewController.h"

@interface ObjectCMainTableController ()
@property (nonatomic, nullable, strong) NSArray *dataSource;
@end

@implementation ObjectCMainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                @{@"property": @"PropertyLearningController"},
                @{@"category": @"CategoryViewController"},
                @{@"内存": @"MemoryManageViewController"},
                @{@"runtime": @"RuntimeTestViewController"},
                @{@"timer": @"TimerViewController"},
                @{@"KVO": @"KVOTestController"},
                @{@"KVC": @"KVCTestViewController"},
                ];
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
    cell.textLabel.text = [(NSDictionary *)self.dataSource[indexPath.row] allKeys].firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *vcDict = self.dataSource[indexPath.row];
    NSString *title = vcDict.allKeys.firstObject;
    NSString *vcClazz = vcDict.allValues.firstObject;
    
    if (!vcClazz) return;
    
    UIViewController *vc = [[NSClassFromString(vcClazz) alloc] init];
    vc.title = title;
    [self pushToVc:vc];
    
}
@end
