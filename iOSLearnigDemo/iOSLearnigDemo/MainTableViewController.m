//
//  MainTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MainTableViewController.h"
#import "ThreadTableViewController.h"
#import "ObjectCMainTableController.h"
#import "AlgoTableViewController.h"
#import "UITestTableViewController.h"
#import "ViewTestController.h"
#import "AVFoundationTestController.h"

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray   *dataSource;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS learning demo";
    
    self.dataSource = @[
                @{@"Objective-C": @"ObjectCMainTableController"},
                @{@"UI": @"UITestTableViewController"},
                @{@"多线程": @"ThreadTableViewController"},
                @{@"算法": @"AlgoTableViewController"},
                @{@"AVFoundation": @"AVFoundationTestController"},
                @{@"优化相关": @"OptMainTableViewController"},
                ];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
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
