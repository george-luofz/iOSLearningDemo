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
#import "GroupSelectorTestViewController.h"
#import "FlowLayoutTestController.h"

@interface UITestTableViewController ()
@property (nonatomic, strong) NSArray   *dataSource;
@end

@implementation UITestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"view",@"CoreText",@"html->pdf",@"JTCalendar测试",@"FSCalendar测试",@"collectionViewInScrollView",@"groupSelector",@"flowLayout"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.view addSubview:view];
    NSLog(@"view window:%@",view.window);
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    UINavigationController *navVc = self.navigationController;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [navVc popViewControllerAnimated:NO];
//        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIViewController *vc = [UIViewController new];
//        vc.view.backgroundColor = [UIColor whiteColor];
//        NSLog(@"navVC:%@",navVc);
//        [navVc pushViewController:vc animated:YES];
//        //        });
//        
//    });
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
    }else if (indexPath.row == 6){
        vc = [GroupSelectorTestViewController new];
    }else if (indexPath.row == 7){
        vc = [FlowLayoutTestController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self pushToVc:vc];
}

// 笔记本，数据从哪来；网络来
// UI控件，布局、交互、事件
// 1.

@end
