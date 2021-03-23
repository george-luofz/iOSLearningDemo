//
//  UIView+NNAdd.h
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NNAdd)

@property (nonatomic) CGFloat nn_left;
@property (nonatomic) CGFloat nn_right;
@property (nonatomic) CGFloat nn_top;
@property (nonatomic) CGFloat nn_bottom;
@property (nonatomic) CGFloat nn_width;
@property (nonatomic) CGFloat nn_height;
@property (nonatomic) CGFloat nn_centerX;
@property (nonatomic) CGFloat nn_centerY;

@property (nonatomic) UIEdgeInsets nn_extendInset;

//- (void)nn_runAddAnimaion;
//- (void)nn_runRemoveAnimaion;
//- (void)nn_keyframeAnimation;

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;

@end
