//
//  ThreadTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ThreadTableViewController.h"
#import "GCDViewController.h"

@interface ThreadTableViewController ()
@property (nonatomic, strong) NSArray     *dataSource;
@end

@implementation ThreadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    self.dataSource = @[@"gcd",@"NSOperationQueue",@"NSThread"];
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
    if(indexPath.row == 0){
        [self pushToVc:[GCDViewController new]];
    }
}


@end
