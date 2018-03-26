//
//  UIViewController+Push.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "UIViewController+Push.h"

@implementation UIViewController (Push)
- (void)pushToVc:(UIViewController *)vc{
    vc.view.backgroundColor = [UIColor whiteColor];
    if(![vc isKindOfClass:[UIViewController class]]) return;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
