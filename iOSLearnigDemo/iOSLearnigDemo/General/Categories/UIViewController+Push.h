//
//  UIViewController+Push.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>

extern void _objc_autoreleasePoolPrint();//打印注册到自动释放池中的对象
extern uintptr_t _objc_rootRetainCount(id obj);//获取对象的引用计数

@interface UIViewController (Push)
- (void)pushToVc:(UIViewController *)vc;
@end
