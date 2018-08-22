//
//  UITestTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "UITestTableViewController.h"
#import "ViewTestController.h"
#import "CoreTextController.h"
#import "HtmlToPdfViewController.h"
#import "JTCalendarTestController.h"
#import "FSCalenderController.h"
#import "ColletionInScrollController.h"

@interface UITestTableViewController ()
@property (nonatomic, strong) NSArray   *dataSource;
@end

@implementation UITestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"view",@"CoreText",@"html->pdf",@"JTCalendar测试",@"FSCalendar测试",@"collectionViewInScrollView"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.view addSubview:view];
    NSLog(@"view window:%@",view.window);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"dispatch after view window:%@",view.window);
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        vc = [ViewTestController new];
    }else if (indexPath.row == 1){
        vc = [CoreTextController new];
    }else if (indexPath.row == 2){
        vc = [HtmlToPdfViewController new];
    }else if (indexPath.row == 3){
        vc = [JTCalendarTestController new];
    }else if (indexPath.row == 4){
        vc = [FSCalenderController new];
    }else if (indexPath.row == 5){
        vc = [ColletionInScrollController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self pushToVc:vc];
}


@end
