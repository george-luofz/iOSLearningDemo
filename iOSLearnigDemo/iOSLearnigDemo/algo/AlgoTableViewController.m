//
//  AlgoTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AlgoTableViewController.h"
#import "StringArrayViewController.h"
#import "LinkListViewController.h"
#import "PointerViewController.h"
#import "SortViewController.h"
#import "StringViewController.h"

@interface AlgoTableViewController ()
@property (nonatomic, strong)   NSArray *dataSource;

@end

@implementation AlgoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"算法与数据结构";
    self.dataSource = @[@"链表",@"数组",@"指针",@"排序",@"字符串"];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    UIViewController *vc;
    if(indexPath.row == 0){
        vc = [LinkListViewController new];
    }else if(indexPath.row == 1){
        vc = [StringArrayViewController new];
    }else if (indexPath.row == 2){
        vc = [PointerViewController new];
    }else if (indexPath.row == 3){
        vc = [SortViewController new];
    }else if (indexPath.row == 4){
        vc = [StringViewController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self pushToVc:vc];
    
}

@end
