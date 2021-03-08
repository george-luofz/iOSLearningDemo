//
//  childView.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/19.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "childView.h"

@implementation childView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    UIGestureRecognizer *ges = self.gestureRecognizers.firstObject;
    NSLog(@"ges state:%d",ges.state);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    UIGestureRecognizer *ges = self.gestureRecognizers.firstObject;
    NSLog(@"ges state:%d",ges.state);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    UIGestureRecognizer *ges = self.gestureRecognizers.firstObject;
    NSLog(@"ges state:%d",ges.state);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    UIGestureRecognizer *ges = self.gestureRecognizers.firstObject;
    NSLog(@"ges state:%d",ges.state);
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super pointInside:point withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super hitTest:point withEvent:event];
}
@end
