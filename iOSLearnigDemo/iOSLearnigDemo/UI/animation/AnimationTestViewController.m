//
//  AnimationTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AnimationTestViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YXLGradientColorView.h"
#import "YXLBubbleCell.h"

@interface AnimationTestViewController () <CAAnimationDelegate>
@property (nonatomic, strong) YXLGradientColorView *gradientView;
@end

@implementation AnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self _testOpacity];
    [self _testRotation];
}

#pragma mark - 测试渐隐动画
- (void)_testOpacity{
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

#pragma mark - 测试翻转动画

- (void)_testRotation{
    CGRect frame = CGRectMake(self.view.nn_width - 140 , self.view.nn_height - 48 - 49, 140, 48);
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:containerView];
    
    YXLGradientColorView *gradientView = [[YXLGradientColorView alloc] initWithFrame:containerView.bounds];
    [gradientView setBeginColor:[UIColor colorWithRed:1.000 green:0.141 blue:0.282 alpha:1.00] endColor:[UIColor colorWithRed:1.000 green:0.592 blue:0.063 alpha:1.00]];
    [containerView addSubview:gradientView];
    self.gradientView = gradientView;
    
    YXLBubbleCell *cell = [[YXLBubbleCell alloc] initWithFrame:gradientView.bounds];
    [gradientView addSubview:cell];

//    [self _testKeyframeAni];
    [self _testSystemAni];
}

- (void)_testSystemAni{
    /// 系统动画
        [UIView transitionWithView:self.gradientView duration:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{

        } completion:^(BOOL finished) {
            [self.gradientView setBeginColor:[UIColor greenColor] endColor:[UIColor greenColor]];
            [UIView transitionWithView:self.gradientView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
//
            } completion:^(BOOL finished) {
//                [self.gradientView setBeginColor:[UIColor greenColor] endColor:[UIColor greenColor]];
                NSLog(@"旋转动画结束");
            }];
        }];

//    [UIView animateWithDuration:1.f  animations:^{
//        self.gradientView.layer.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);
//    } completion:^(BOOL finished){
//        [self.gradientView setBeginColor:[UIColor greenColor] endColor:[UIColor greenColor]];
//        [UIView animateWithDuration:1.f  animations:^{
//            self.gradientView.layer.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);
//        } completion:^(BOOL finished){
//            // code to be executed when flip is completed
////            self.gradientView.layer.transform = CATransform3DIdentity;
//        }];
//    }];
}

- (void)_testKeyframeAni{
    /// 关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    
    // 旋转角度， 其中的value表示图像旋转的最终位置
    
    keyAnimation.values = [NSArray arrayWithObjects:
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1,0,0)],
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI/2), 1,0,0)],
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1,0,0)],
                           
                           nil];
    
    keyAnimation.cumulative = NO;
    
    keyAnimation.duration = 1.6f;
    
    keyAnimation.repeatCount = 0;
    
    keyAnimation.removedOnCompletion = NO;
    
    keyAnimation.delegate = self;
    
    self.gradientView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    [self.gradientView.layer addAnimation:keyAnimation forKey:@"transform"];
    
    [self performSelector:@selector(changeImageView) withObject:nil afterDelay:.8];
}

- (void)changeImageView{
    [self.gradientView setBeginColor:[UIColor greenColor] endColor:[UIColor greenColor]];
}
@end
