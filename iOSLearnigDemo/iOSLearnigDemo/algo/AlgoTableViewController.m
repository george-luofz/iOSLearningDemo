//
//  AlgoTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AlgoTableViewController.h"
#import "StringArrayViewController.h"
#import "LinkListViewController.h"
#import "PointerViewController.h"
#import "SortViewController.h"
#import "StringViewController.h"

@interface AlgoTableViewController ()
@property (nonatomic, strong)   NSArray *dataSource;

@end

@implementation AlgoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"算法与数据结构";
    self.dataSource = @[@"链表",@"数组",@"指针",@"排序",@"字符串"];
   
    int c = countDigitOne(1410065408);
    NSLog(@"%d",c);
    
    int a[8] = {4,1,4,6,10,10,9,9};
    int *arr = singleNumbers(&a, 8, NULL);
    NSLog(@"%p",arr);
    
    int d = 3 & 3;
    NSLog(@"%d",d);
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
    UIViewController *vc;
    if(indexPath.row == 0){
        vc = [LinkListViewController new];
    }else if(indexPath.row == 1){
        vc = [StringArrayViewController new];
    }else if (indexPath.row == 2){
        vc = [PointerViewController new];
    }else if (indexPath.row == 3){
        vc = [SortViewController new];
    }else if (indexPath.row == 4){
        vc = [StringViewController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self pushToVc:vc];
    
}

int countDigitOne(int n){
    // 12341
    if (n == 0)  return 0;

    // 找到每一位是1
    // 只要有一位是1就可以了
    int count = 0;
    
    int high = n / 10, cur = n % 10, low = 0;
    int digit = 1;

    while (high != 0 || cur != 0) {
        if (cur == 0) count += high * digit;
        else if (cur == 1) count += (high * digit + low + 1);
        else count += (high + 1) * digit;

        low += cur * digit;
        cur = high % 10;
        digit *= 10;
        high /= 10;
    }
    return count;
}

int* singleNumbers(int* nums, int numsSize, int* returnSize){
    if (nums == NULL || numsSize < 4) return NULL;

    int *result = (int *)malloc(sizeof(int) * 2);

    // 求得异或结果
    int k = 0;
    for (int i = 0; i < numsSize;i++) {
        k ^= nums[i];
    }

    // 找到分组mask
    int mask = 1;
    while ((k & mask) == 0) {
        mask <<= 1;
    }

    // 分组找到a,b
    int a = 0, b = 0;
    for (int i = 0; i < numsSize;i++) {
        int cur = nums[i];
        if ((cur & mask) == 0) {
            a ^= cur;
        } else {
            b ^= cur;
        }
    }

    // 组装结果
    result[0] = a;
    result[1] = b;
    return result;
}

@end
