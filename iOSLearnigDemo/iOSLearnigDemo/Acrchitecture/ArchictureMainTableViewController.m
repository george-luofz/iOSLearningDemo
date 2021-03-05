//
//  ArchictureMainTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//  tableView复用
//  controller庞大

#import "ArchictureMainTableViewController.h"

@interface ArchictureMainTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ArchictureMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                @{@"MVC": @"MVCTestViewController"},
                @{@"MVP": @"MVPTestViewController"},
                @{@"MVVM": @"MVVMTestViewController"},
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
