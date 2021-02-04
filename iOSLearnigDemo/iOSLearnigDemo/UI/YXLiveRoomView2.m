//
//  YXLiveRoomView2.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2020/4/24.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "YXLiveRoomView2.h"

@implementation YXLiveRoomView2

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"富中 dis sub:%@",view);
    return view;
}

@end
