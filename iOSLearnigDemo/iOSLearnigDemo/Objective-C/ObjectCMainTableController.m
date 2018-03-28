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

@interface ObjectCMainTableController ()
@property (nonatomic, nullable, strong) NSArray *dataSource;
@end

@implementation ObjectCMainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"property相关",@"category",@"autoreleasepool"];
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
    }
    if(vc){
        vc.title = self.dataSource[indexPath.row];
        [self pushToVc:vc];
    }
    
}
@end
