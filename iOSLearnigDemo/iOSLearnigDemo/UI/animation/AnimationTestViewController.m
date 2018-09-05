//
//  AnimationTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AnimationTestViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AnimationTestViewController () <CAAnimationDelegate>

@end

@implementation AnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self arrangeSubtitle];
    });
}

- (void)arrangeSubtitle {
//    CATextLayer *textLayer = [CATextLayer layer];
//    textLayer.font = (__bridge CFTypeRef)[UIFont systemFontOfSize:18].fontName;
//    textLayer.fontSize = 18;
//    textLayer.string = @"hello world!";
//    textLayer.contentsScale = [[UIScreen mainScreen] scale];
//    textLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
//    textLayer.alignmentMode = kCAAlignmentCenter;
////    textLayer.truncationMode = kCATruncationNone;
//
    CGSize fontInSize = [@"hello world!" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]}];
//    textLayer.frame = CGRectMake(0, 64, fontInSize.width, fontInSize.height);
//
//    textLayer.opacity = 1.0;
//    [self.view.layer addSublayer:textLayer];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 64, fontInSize.width, fontInSize.height);
    layer.backgroundColor = [[UIColor redColor] CGColor];
    [self.view.layer addSublayer:layer];
    
    [self addShowAndHideAnimationForLayer:layer begin:AVCoreAnimationBeginTimeAtZero end:2 totalDuration:2];
}

- (void)addShowAndHideAnimationForLayer:(CALayer*)layer begin:(CFTimeInterval)begin end:(CFTimeInterval)end totalDuration:(CGFloat)totalDuration {
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    frameAnimation.duration = totalDuration;
    frameAnimation.beginTime = AVCoreAnimationBeginTimeAtZero;
    frameAnimation.delegate = self;
    frameAnimation.removedOnCompletion = NO;
    frameAnimation.fillMode = kCAFillModeForwards;
    frameAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:0.0f], nil];
    
    frameAnimation.keyTimes = [NSArray arrayWithObjects:
                               @(0),
                               @(0),
                               @(0.98),
                               @(1)
                               ,nil];

//    [layer addAnimation:frameAnimation forKey:@"frameAnimation"];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = totalDuration;
    animation.beginTime = begin;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0];
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"basicAnimation"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%s",__func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%s,finisded:%d",__func__,flag);
}

@end
