//
//  UIView+NNAdd.m
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "UIView+NNAdd.h"
#import <objc/runtime.h>

static char touchExtendInsetKey;

@implementation UIView (NNAdd)
+ (void)load {
//    swizzle_method(self, @selector(pointInside:withEvent:), @selector(nn_pointInside:withEvent:));
}

- (BOOL)nn_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.nn_extendInset, UIEdgeInsetsZero) || self.hidden || ([self isKindOfClass:[UIControl class]] && !((UIControl *)self).enabled)) {
        return [self nn_pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.nn_extendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

- (void)setNn_extendInset:(UIEdgeInsets)nn_extendInset {
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:nn_extendInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)nn_extendInset {
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue];
}

- (CGFloat)nn_left {
    return self.frame.origin.x;
}


- (void)setNn_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)nn_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setNn_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)nn_top {
    return self.frame.origin.y;
}

- (void)setNn_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)nn_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setNn_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)nn_width {
    return self.frame.size.width;
}

- (void)setNn_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)nn_height {
    return self.frame.size.height;
}

- (void)setNn_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setNn_centerX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)nn_centerX {
    
    return self.center.x;
}

- (void)setNn_centerY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)nn_centerY {
    
    return self.center.y;
}

- (void)nn_runAddAnimaion {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.layer setValue:@1.7 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.layer setValue:@0.9 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.layer setValue:@1 forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

- (void)nn_runRemoveAnimaion {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.layer setValue:@0.8 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.layer setValue:@1 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)nn_keyframeAnimation {
    CGPoint pt = self.layer.position;
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint pt1 = CGPointMake(pt.x + 20, pt.y);
    CGPoint pt2 = CGPointMake(pt.x - 20, pt.y);
    CGPoint pt3 = CGPointMake(pt.x + 10, pt.y);
    CGPoint pt4 = CGPointMake(pt.x - 10, pt.y);
    
    keyframe.values = @[[NSValue valueWithCGPoint:pt],
                        [NSValue valueWithCGPoint:pt1],
                        [NSValue valueWithCGPoint:pt2],
                        [NSValue valueWithCGPoint:pt3],
                        [NSValue valueWithCGPoint:pt4],
                        [NSValue valueWithCGPoint:pt]];
    
    keyframe.keyTimes = @[@(0.0),@(0.2),@(0.4),@(0.6),@(0.8),@(1.0)];
    keyframe.duration = 0.5;
    [self.layer addAnimation:keyframe forKey:nil];
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners {
    
    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    //1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
                             CGRectGetWidth(self.frame)-borderWidth, CGRectGetHeight(self.frame)-borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    //2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.frame)-1, CGRectGetHeight(self.frame)-1);
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
    
    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    clipLayer.lineWidth = 1;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;
    
    self.layer.mask = clipLayer;
}
@end
