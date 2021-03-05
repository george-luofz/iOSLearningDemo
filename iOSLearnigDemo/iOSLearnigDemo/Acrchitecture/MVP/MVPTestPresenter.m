//
//  MVPTestPresenter.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MVPTestPresenter.h"

@interface MVPTestPresenter()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) NSArray *dataSource;
@end
@implementation MVPTestPresenter

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        self.viewController = viewController;
        
        // data
        [self setUpData];
        
        // view
        [self setupViews];
    }
    return self;
}

- (void)setUpData {
    self.dataSource = @[@"姓名",@"年龄"];
}

- (void)setupViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.viewController.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.viewController.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
