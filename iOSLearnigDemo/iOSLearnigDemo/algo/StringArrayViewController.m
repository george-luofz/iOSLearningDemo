//
//  StringArrayViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/23.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "StringArrayViewController.h"

@interface StringArrayViewController ()

@end

@implementation StringArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.获取二维数组指定位置
    [self _getValueIndexForMetrix:7];
    
    // 2.替换字符串中指定字符
    char string[60] = "a b c d e f g h i j k l m n "; //注意字符串初始化
    [self _replaceBlankToANSCIIString:string];
    int a[20] = {2,4,6,8,9};
    int b[5] = {1,3,5,7,10};
    mergeTwoSortArray(a, 5, b, 5);
}

#pragma mark - 题目一 找出有序二维数组(从上到下有序，从左到右有序)中指定位置的数字
// 思路：每次从数组的右上角(或者左下角)取值，这样一次就可以过滤掉一行；因为数组有序，所以若a比右上角值小，则排除右上角所在列；若a比右上角值大，则排除右上角所在行；以此类推，直到找到该值，或者数组遍历完毕
// 分析：二维数组只需要一次遍历，时间复杂度o(n)
- (NSArray *)_getValueIndexForMetrix:(int)value{
    NSArray *array1 = @[@(1),@(2),@(8),@(9)];
    NSArray *array2 = @[@(2),@(4),@(9),@(12)];
    NSArray *array3 = @[@(4),@(7),@(10),@(13)];
    NSArray *array4 = @[@(6),@(8),@(11),@(15)];
    NSArray *metrix = [NSArray arrayWithObjects:array1,array2,array3,array4,nil];
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
#pragma mark --  用%20替换字符串中的空格
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
#pragma mark -- 上述题目扩展
// 合并两个有序数组，a1是长数组
void mergeTwoSortArray(int a1[], int length1, int a2[], int length2){
    int totalLength = length1 + length2;
    int temp = totalLength;
    //    int output[totalLength--];
    while (length1 >= 0 && length2 >= 0) {
        if(a1[length1-1] > a2[length2-1]){
            a1[--totalLength] = a1[--length1];
            //            NSLog(@"length1:%d,length2:%d,totalLength:%d,output[%d]=%d,a1[%d]=%d",length1,length2,totalLength,totalLength+1,output[totalLength+1],length1+1,a1[length1+1]);
        }else if(a1[length1 - 1] < a2[length2 - 1]){
            a1[--totalLength] = a2[--length2];
            //            NSLog(@"length1:%d,length2:%d,totalLength:%d,output[%d]=%d,a2[%d]=%d",length1,length2,totalLength,totalLength+1,output[totalLength+1],length2+1,a2[length2+1]);
        }else if(a1[length1 - 1] == a2[length2 - 1]){
            a1[--totalLength] = a1[--length1];
            length2--;
            totalLength--;//此时需要减2
            //            NSLog(@"length1:%d,length2:%d,totalLength:%d,output[%d]=%d",length1,length2,totalLength,totalLength+1,output[totalLength+1]);
        }
        
    }
    for(int i = 0 ;i < temp ;i++){
        NSLog(@"%d=%d",i,a1[i]);
    }
    
}

#pragma mark -- 二叉树前序、中序转重置
struct BinaryNode{
    int root;
    struct BinaryNode *leftNode;
    struct BinaryNode *rightNode;
};
- (void)_test_constuctBinaryNode{
    int pre[8] = {1,2,4,7,3,5,6,8};
    int mid[8] = {4,7,2,1,5,3,8,6};
    struct BinaryNode *node = construct(pre, mid, 8);
    
}

struct BinaryNode *construct(int *pre, int *mid ,int length){
    if(pre == NULL || mid == NULL || length == 0) return NULL;
    // 1.判断
    // 2.调用core方法
    return construnctCore(pre,mid,length);
}
struct BinaryNode *construnctCore(int *pre, int *mid, int length){
    // 1.判断
    if(length == 0){
        return NULL;
    }
    // 2.构建前序左子树、右子树；中序左子树、右子树
    int *pre_left,*pre_right;
    int *mid_left,*mid_right;
    // 3.找到根节点
    int rootIndex = 0;
    for(int i = 0 ;i < length;i++){
        if(mid[i] == pre[0]){
            rootIndex = i;
            break;
        }
        
    }
    struct BinaryNode *node = malloc(sizeof(struct BinaryNode));
    node->root = pre[0];
    // 4. 构建左子树，前序左子树要从第二个开始，中序左子树就直接拿过来就行
    for(int i = 0;i < rootIndex;i++){
        pre_left[i] = pre[i+1]; //从第二个开始
        mid_left[i] = mid[i];
    }
    // 5. 构建右子树
    for(int i = rootIndex + 1, j=0 ; i < length;i++){
        pre_right[j] = pre[i];
        mid_right[j] = mid[i];
    }
    // 6. 递归构建左子树，右子树
    node->leftNode = construnctCore(pre_left, mid_left, rootIndex);
    node->rightNode = construnctCore(pre_right, mid_right, length-rootIndex-1);
    return node;
}
@end


@interface TreeNode:NSObject
@property TreeNode *leftNode;
@property TreeNode *rightNode;
@end

@implementation TreeNode


@end
