//
//  SortViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/27.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "SortViewController.h"

@interface SortViewController ()

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int a[6] = {1,3,5,4,2,8};
    quickSort(a, 0, 5);
    NSLog(@"array");
}

#pragma mark -- 快速排序
void quickSort(int a[], int a0, int al){
    if(a[a0] < a[al]){
        int q = partion(a, a0, al);
        quickSort(a, a0, q-1);
        quickSort(a, q+1, al);
    }
}
int partion(int a[], int l0, int ln){
    // 1.选择最后一个为主元
    int key = a[ln];
    // 2.选择一个记录指针
    int i = l0-1;
    // 3.开始从l0遍历
    for(int j = l0 ;j < ln;j++){
        // 如果比key值大，则交换
        if(a[j] <= key){
            i=i+1;
            swap(&a[i], &a[j]);
        }
    }
    swap(&a[ln], &a[i]);
    return i;
}
void swap(int *a,int *b){
    int temp = *a;
    *a = *b;
    *b = temp;
//    *a = *a^*b;
//    *b = *a^*b;
//    *a = *a^*b;
}
@end
