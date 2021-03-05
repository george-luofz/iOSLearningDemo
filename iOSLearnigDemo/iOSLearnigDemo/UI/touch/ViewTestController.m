//
//  ViewTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ViewTestController.h"
#import "CustomView.h"

@interface ViewTestController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // openURL 不支持传空格，要转换成特殊字符
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vans.com.cn/wap/article-2775.html?utm_source=Miaopai&utm_medium=Homepage_4-1&utm_campaign=Vans2018 Brand"]];
    });
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 300) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.tableHeaderView = [UIView new];
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"iden1"];
    [self.view addSubview:tableView];

    // reloadRowsAtIndexPaths超过数据源崩溃
//    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesCancelled:touches withEvent:event];
}
- (void)tap{
    NSLog(@"%s",__func__);
}

- (void)btnClick{
    NSLog(@"%s",__func__);
}

#pragma mark - appearance
- (void)_testAppearance{
    /// test appearance
    [CustomView appearance].bgColor  = [UIColor redColor];
    
    CustomView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    [self.view addSubview:view];
}

#pragma mark - tableView
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iden1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iden1"];
    }
    cell.textLabel.text = @"1";
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
