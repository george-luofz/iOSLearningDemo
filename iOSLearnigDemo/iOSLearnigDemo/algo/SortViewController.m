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
    
    //
    int age[10] = {21,22,25,23,22,24,21,30,29,30};
    sortAges(age, 10);
    
    //
    int circleA[7] = {3,4,5,0,1,2,3};
    int index = smalletItem(circleA, 7);
    NSLog(@"smallest:%d",circleA[index]);
    
    //
    long long fibN = Fibonacci(10);
    NSLog(@"fibN:%ld",fibN);
    
    double a1 = 0.000000003;
    double a2 = 0.000000004;
    if(equal(a1, a2)){
        NSLog(@"is equal");
    }else{
        NSLog(@"is not equal");
    }
}
bool equal(double a,double b){
    if((a-b) > -0.0000001 && (a-b) < 0.0000001){
        return YES;
    }
    return NO;
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

#pragma mark -- 年龄排序--剑指offer 7
void sortAges(int ages[], int length){
    if(ages == NULL || length == 0 ) return;
    const int oldestAge = 99;
    int timesOfAges[oldestAge+1];
    // 1. 先初始化timesOfAges数组
    for(int i = 0 ;i < oldestAge;i++){
        timesOfAges[i] = 0;
    }
    // 2. 遍历一次ages，记录每个age的次数
    int smallestAge = ages[0]; //记录最小年龄
    for(int i = 0;i < length;i++){
        int age = ages[i];
        if(age < smallestAge){
            smallestAge = age;
        }
        timesOfAges[age]++;
    }
    // 3. 调整ages数组，思路：记录一个总索引，从timesOfAges中取每个年龄的个数，不停得加这个值就好了
    int totalIndex = 0;
    for(int i = smallestAge; i < oldestAge;i++){
        if(timesOfAges[i] == 0) continue;
        for(int j = 0;j < timesOfAges[i];j++){
            ages[totalIndex] = i;
            totalIndex++;
        }
    }
    // 4.log
    for(int i = 0 ;i < length;i++){
        NSLog(@"%d:%d",i,ages[i]);
    }
    
}

#pragma mark -- 第8题 旋转子数组中最小元素
//思路：可以看成两个有序的子数组，第二个数组的第一个元素就是最小值；第一个数组的最后一个元素就是最大的值；采用二分查找的思想，分别用两个指针p1,p2指向数组开头和结尾，如果中间指针mid大于p1的值，说明最小值位于数组右边，此时更新p1；若mid值小于p2，说明最小值位于数组左边，更新p2；当p2-p1==1，也就是位于相邻位置时，p2就是最小值的索引；
int smalletItem(int a[], int length){
    if(a == NULL || length == 0) return -1;
    int index1 = 0;
    int index2 = length - 1;
    int mid = 0;
    while (1) {
        if(index2 - index1 == 1){
            return index1; //最大元素
            return index2; //最小元素
        }
        mid = index1 + (index2-index1)/2;
        if(a[mid] >= a[index1]){
            index1 = mid;
//            mid = index1 + (index2 - index1)/2;
            continue;
        }
        if(a[mid] <= a[index2]){
            index2 = mid;
//            mid = index1 + (index2 - index1)/2;
            continue;
        }
    }
    return 0;
}

#pragma mark -- 第九题 斐波那契数列
//思路：
// 不使用递归，因为有很多重复数字计算，可以从f(0)，f(1)开始，f(2) = f(0)+f(1);然后f(3) = f(1)+f(2);
long long Fibonacci(unsigned int n){
    int result[2] = {0,1};
    if(n < 2) return result[n];
    long long fibMinusOne = 0;
    long long fibMinusTwo = 1;
    long long fibN = 0;
    for(int i = 2;i < n;i++){
        fibN = fibMinusOne + fibMinusTwo; //当前的f(n)
        fibMinusTwo = fibMinusOne; // 更新f(2)
        fibMinusOne = fibN; // 更新f(1),为上次计算后的值
    }
    return fibN;
}
// 思考：
// 数组操作，常常要思考头指针、尾指针，中间指针这些参数
// 位运算，感觉并不实用，所以暂时不学习了



@end
