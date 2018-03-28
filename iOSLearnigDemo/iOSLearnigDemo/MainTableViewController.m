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

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray   *dataSource;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS learning demo";
    
    self.dataSource = @[@"Objective-C",@"多线程",@"网络",@"算法",@"架构",@"图形处理",@"视频处理"];
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
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    if(indexPath.row == 0){
        vc = [ObjectCMainTableController new];
    }else if(indexPath.row == 1){
        vc = [ThreadTableViewController new];
    }else if(indexPath.row == 3){
        vc = [AlgoTableViewController new];
    }
    if(vc){
        vc.title = self.dataSource[indexPath.row];
        [self pushToVc:vc];
    }
}

@end
