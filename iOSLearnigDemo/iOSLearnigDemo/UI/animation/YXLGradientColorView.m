//
//  YXLGradientColorView.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/11/7.
//  Copyright © 2018 George_luofz. All rights reserved.
//

#import "YXLGradientColorView.h"

@implementation YXLGradientColorView

+ (Class)layerClass{
    return [CAGradientLayer class];
}

- (void)setBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor{
    CAGradientLayer *layer =  (CAGradientLayer *)self.layer;
    
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    if (beginColor && endColor) {
        layer.colors = @[(__bridge id)beginColor.CGColor,(__bridge id)endColor.CGColor];
    }
}

@end
