//
//  DesignPatternMainTableController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "DesignPatternMainTableController.h"

@interface DesignPatternMainTableController ()
@property (nonatomic, nullable, strong) NSArray *dataSource;
@end

@implementation DesignPatternMainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                @{@"单例": @"SingleInstanceController"},
                @{@"工厂": @"FactoryViewController"},
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
