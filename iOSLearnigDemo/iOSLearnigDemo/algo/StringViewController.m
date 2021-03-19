//
//  StringViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/12.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "StringViewController.h"

@interface StringViewController ()

@end

@implementation StringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    char *str = "-91283472332";
    NSLog(@"result:\n %d",strToInt(str));
}

int strToInt(char* str){
    int result = 0; //结果
    int negSign = 1; //负数标记位
    bool hasCount = false; // 已有数字
    bool hasSign = false; //是否有符号

    int boundry = INT_MAX / 10; //边界值
    int boundryLastValue = INT_MAX % 10; // 最后一位最大值

    int cIndex = 0;
    char c = str[cIndex];
    while (c != '\0') {
        if (c == ' ') { //空格右移
            // 已有数字，结束
            if (hasCount) break;
        } else if (c == '+' || c == '-') { // 符号位
            if (hasCount || hasSign) break; // 已有数字或已有符号位，结束
            if (c == '-') negSign = -1;
            hasSign = true;
        } else if (c >= '0' && c <= '9') { // 0 - 9
            // 50 1
            int value = (c - '0');

            // 判断越界
            if (negSign == -1) { //负数
                if (result > boundry) { //直接超过边界
                    return INT_MIN;
                } else if (result == boundry && value > boundryLastValue) { // 再加一位超边界
                    return INT_MIN;
                }
            } else { // 正数
                if (result > boundry) { //直接超过边界
                    return INT_MAX;
                } else if (result == boundry && value >= boundryLastValue) { // 再加一位超边界
                    return INT_MAX;
                }
            }
            // 计算
            result = result * 10 + value;
            hasCount = true;
        } else { // 非法字符结束
            break;
        }
        cIndex++;
        c = str[cIndex];
    }

    return negSign * result;
}

@end
