//
//  MemoryManageViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MemoryManageViewController.h"
#import "MRCObject.h"
#import "ARCObject.h"

@interface MemoryManageViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MemoryManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"MRC",@"ARC",@"自动释放池"];
//    [self _testMRC];
    [self _testARC];
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
    if(indexPath.row == 0){
        [self _testMRC];
    }else if (indexPath.row == 1){
        [self _testARC];
    }else if (indexPath.row == 2){// 自动释放池
        [self _test_autorealeasepool];
    }
}
#pragma mark -- MRC
- (void)_testMRC{
    
//    #if(!__has_feature(objc_arc))
    MRCObject *obj = [[MRCObject alloc] init];  // init引用计数为1
    [obj test];
//    [obj release];
//    #endif
    
}

- (void)_testARC{
    ARCObject *obj = [[ARCObject alloc] init];
    [obj test];
}

- (void)_test_autorealeasepool{
    MRCObject *obj = [[MRCObject alloc] init];
    [obj test_autoreleasepool];
}
@end
