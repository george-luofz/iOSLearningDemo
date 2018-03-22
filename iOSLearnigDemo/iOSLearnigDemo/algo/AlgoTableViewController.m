//
//  AlgoTableViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AlgoTableViewController.h"

@interface AlgoTableViewController ()

@end

@implementation AlgoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _getValueIndexForMetrix:7];
    
    // 2.
    char string[60] = "a b c d e f g h i j k l m n "; //注意字符串初始化
    [self _replaceBlankToANSCIIString:string];
    
}
//求有序二维数组中，数值a的位置
- (NSArray *)_getValueIndexForMetrix:(int)value{
    NSArray *array1 = @[@(1),@(2),@(8),@(9)];
    NSArray *array2 = @[@(2),@(4),@(9),@(12)];
    NSArray *array3 = @[@(4),@(7),@(10),@(13)];
    NSArray *array4 = @[@(6),@(8),@(11),@(15)];
    NSArray *metrix = [NSArray arrayWithObjects:array1,array2,array3,array4,nil];
    
    
    // 从右上角遍历，若比右上小；则去掉该列；若比该值大，则可能在该列
//    for(int )
//    int row = metrix.count;
//    int column = [metrix.firstObject count];
//    int rowIndex,columnIndex = -1;
//    BOOL flag = NO;
//    for(int i = column - 1; i > 0;i--){
//
//        for(int j = 0; j < row;j++){
//            int indexValue = [[metrix[j] objectAtIndex:i] intValue];
//            if(value == indexValue) return @[];
//            if(value < indexValue){
//                flag = YES;
//                continue;
//            }else{
//
//            }
//        }
//        if(flag == YES){
//            flag = NO;
//            continue;
//        }
//
//    }
//    return nil;
    
    //用row * column；
    // 二维数组可以从右上角和左下角考虑问题，这样可以一次过滤一行或者一列
    int rows = metrix.count;
    int columns = [metrix.firstObject count];
    int row = 0;
    int column = columns - 1;
    while (row < rows && column > 0) {
        int tempValue = [[metrix[row] objectAtIndex:column] intValue];
        if(tempValue == value){
            NSLog(@"value %d:row=%d,column=%d",value,row,column);
            return @[@(row),@(column)];
        }else if(value < tempValue){
            column--;
        }else{
            row++;
        }
    }
    
    return nil;
}

// 将字符串中的空格换成%20
// 思路：
// 解法一：由于字符串中的空格占一个字符，%20占3个字符，若从前往后遍历，遇到一个空格做替换，每次替换空格后边的字符全部都要后移n次，n个空格，时间复杂度为o(n2)
// 解法二：可以考虑从后往前遍历，先找出空格的个数，那么新的字符串长度就是原长度n+2*空格个数；那么可以用两个指针*p1,*p2，第一个指向原字符串末尾，第二个指向新字符串末尾，开始遍历，将*p1指向的内容copy到*p2指向的位置，若遇到一个空格，将%20拷贝到*p2,并将*p2向前移动3个位置；遇到第二个也是同样操作；当*p1,*p2指向相同时，则处理完毕。

- (void)_replaceBlankToANSCIIString:(char [])string { //char *[]?
    //API已经有这个方法
//    NSString *str;
//    str stringByReplacingOccurrencesOfString:<#(nonnull NSString *)#> withString:<#(nonnull NSString *)#>
    // 不能用oc的API，oc是面向对象的
    // 1.先求字符串的长度，得道新字符串的长度
    NSLog(@"original str:%s",string);
    int strLength = 0;
    int blankNum = 0;
    
    while (string[strLength] != '\0') {
        if(string[strLength] == ' '){
            blankNum++;
        }
        strLength ++;
    }
//    char *p1 = string[strLength];
//    // 2. 调整*p2指向，开始从后向前遍历
//    char *p2 = *p1 + blankNum *2;
//    NSLog(@"%c,%c",*p1,*p2);
//    while (*p1 && *p2 && *p1 != *p2) {
//        // 如果不是空格
//        if(*p1 != ' '){
//            *p2 = *p1;
//            p1--;
//            p2--;
//        }else{
//            // 如果是空格
//            *p2 - 3 = &'%20';
//            *p2 -=3;
//            *p1--;
//        }
//    }
    int newStrLength = strLength + 2 * blankNum;
    while (strLength > 0 && newStrLength > strLength) {
        // 如果不是空格
//        if(string[strLength] != ' '){
//            string[newStrLength--] = string[strLength--];
//        }else{
//            string[newStrLength--] = '0';
//            string[newStrLength--] = '2';
//            string[newStrLength--] = '%';
//            strLength--;
//        }
        // 换一种写法
        strLength--;
        newStrLength--;
        if(string[strLength] !=' '){
            string[newStrLength] = string[strLength];
        }else{
            string[newStrLength--] = '0';
            string[newStrLength--] = '2';
            string[newStrLength] = '%';
        }
    }
    NSLog(@"new string:%s",string);
    // 基础知识：
    // 1.c语言字符串其实是字符数组，char a[10] = "adsjfklsdj";
    // 2.c语言数组定义时指定长度，指定完之后就不能再修改长度
}

@end
