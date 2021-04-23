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
#import "AnimationTestViewController.h"
#import "ImageViewTestViewController.h"
#import "CALayerTestViewController.h"
#import "EventTestViewController.h"
#import "PanTestViewController.h"

@interface UITestTableViewController ()
@property (nonatomic, strong) NSArray   *dataSource;
@end

@implementation UITestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"富中player viewDidLoad:%lf",CACurrentMediaTime());
    self.dataSource = @[@"view",@"CoreText",@"html->pdf",@"JTCalendar测试",@"FSCalendar测试",@"collectionViewInScrollView",@"groupSelector",@"flowLayout",@"动画",@"imageView测试",@"CALayer测试",@"事件传递",@"pan手势"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self.view addSubview:view];
    NSLog(@"view window:%@",view.window);
    UIImage *image = nil;
    
    view.layer.contents = (id )image.CGImage;
    view.layer.contentsCenter = CGRectMake(0, 0, 1, 1);
    view.layer.contentsScale = image.scale;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"富中player viewWillAppear:%lf",CACurrentMediaTime());
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"富中player viewDidAppear:%lf",CACurrentMediaTime());
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
    }else if (indexPath.row == 8){
        vc = [AnimationTestViewController new];
    }else if (indexPath.row == 9){
        vc = [ImageViewTestViewController new];
    }else if (indexPath.row == 10){
        vc = [CALayerTestViewController new];
    }else if (indexPath.row == 11){
        vc = [EventTestViewController new];
    }else if (indexPath.row == 12){
        vc = [PanTestViewController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self pushToVc:vc];
}

// 笔记本，数据从哪来；网络来
// UI控件，布局、交互、事件
// 1.

@end
