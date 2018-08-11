//
//  MyWindow.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/19.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
//    if(self.hidden || self.alpha < 0.01 || self.userInteractionEnabled == NO) return nil;
//    if([self pointInside:point withEvent:event] == NO) return nil;
//    NSInteger count = self.subviews.count;
//    for(int i = count - 1 ;i >= 0 ;i--){
//        UIView *view = self.subviews[i];
//        CGPoint subpoint = [self convertPoint:point toView:view];
//        if([view pointInside:subpoint withEvent:event]){
//            UIView *newView = [view hitTest:subpoint withEvent:event];
//            if(newView) return newView;
//        }
//    }
//    return self;
    return [super hitTest:point withEvent:event];
}
@end
