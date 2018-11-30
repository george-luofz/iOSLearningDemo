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

static CGFloat KShapelayerLineWidth = 2;
static CGFloat KShapeLayerMargin = 10;
static CGFloat KShapeLayerRadius = 30;
static CGFloat KShapeLayerWidth = 60;

@interface AnimationTestViewController () <CAAnimationDelegate>
@property (nonatomic, strong) YXLGradientColorView *gradientView;
@end

@implementation AnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self _testOpacity];
//    [self _testRotation];
    [self _testCellAnimation];
//    [self animation1];
    [self _testRotation];
    [self _testCircleLoadingAni];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
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

#pragma mark - 粒子动画

- (void)_testCellAnimation{
    CAEmitterLayer *fireworksLayer = [CAEmitterLayer layer];
    CGRect bounds = self.view.layer.bounds;
    fireworksLayer.emitterPosition = CGPointMake(bounds.size.width / 2.f, bounds.size.height);
    fireworksLayer.emitterSize = CGSizeMake(bounds.size.width / 2.0f, 0);
    fireworksLayer.emitterMode = kCAEmitterLayerOutline;
    fireworksLayer.emitterShape = kCAEmitterLayerLine;
    fireworksLayer.renderMode = kCAEmitterLayerAdditive;
    fireworksLayer.seed = arc4random() % 100 + 1;
    
    CAEmitterCell *rockect = [CAEmitterCell emitterCell];
//    rockect.name = @"snow";
    rockect.birthRate = 1.f;
    rockect.emissionRange = .25 * M_PI;
    rockect.velocity = 380;
    rockect.velocityRange = 100;
    rockect.yAcceleration = 75;
    rockect.lifetime = 1.02;
    rockect.contents = (id)[[UIImage imageNamed:@"DazRing"] CGImage];
    rockect.scale = .2;
    rockect.color = [[UIColor yellowColor] CGColor];
    rockect.greenRange = 1.f;
    rockect.redRange = 1.f;
    rockect.blueRange = 1.f;
    rockect.spinRange = M_PI;
    
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    burst.birthRate = 1.f;
    burst.velocity = 0;
    burst.scale = 2.5;
    burst.redSpeed = -1.5f;
    burst.blueSpeed = 1.5f;
    burst.greenSpeed = 1.0;
    burst.lifetime = .35;
    
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.birthRate = 400;
    spark.velocityRange = 125;
    spark.emissionRange = 2 * M_PI;
    spark.yAcceleration = 75;
    spark.lifetime = 3;
    spark.contents = (id)[[UIImage imageNamed:@"DazStarOutline"] CGImage];
    spark.scaleSpeed = -.2;
    spark.greenSpeed = -.1;
    spark.redSpeed = .4;
    spark.blueSpeed = -.1;
    spark.alphaSpeed = - .25;
    spark.spin = 2 * M_PI;
    spark.spinRange = 2 * M_PI;
    
    
    fireworksLayer.emitterCells = @[rockect];
    rockect.emitterCells = @[burst];
    burst.emitterCells = @[spark];
    [self.view.layer addSublayer:fireworksLayer];

}


//雪花动画
- (void)animation1 {
    
    //粒子发射器
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //粒子发射的位置
    snowEmitter.emitterPosition = CGPointMake(100, 30);
    //发射源的大小
    snowEmitter.emitterSize        = CGSizeMake(self.view.bounds.size.width, 0.0);;
    //发射模式
    snowEmitter.emitterMode        = kCAEmitterLayerOutline;
    //发射源的形状
    snowEmitter.emitterShape    = kCAEmitterLayerLine;
    
    //创建雪花粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名称
    snowflake.name = @"snow";
    //粒子参数的速度乘数因子。越大出现的越快
    snowflake.birthRate        = 1.0;
    //存活时间
    snowflake.lifetime        = 120.0;
    //粒子速度
    snowflake.velocity        = -10;                // falling down slowly
    //粒子速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;        // some variation in angle
    //子旋转角度范围
    snowflake.spinRange        = 0.25 * M_PI;        // slow spin
    //粒子图片
    snowflake.contents        = (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    //粒子颜色
    snowflake.color            = [[UIColor redColor] CGColor];
    
    //设置阴影
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // 将粒子添加到粒子发射器上
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

#pragma mark - 圆周动画
- (void)_testCircleLoadingAni{
    /// 底部的灰色layer
    CAShapeLayer *bottomShapeLayer = [CAShapeLayer layer];
    bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1].CGColor;
    bottomShapeLayer.fillColor = [UIColor clearColor].CGColor;
    bottomShapeLayer.lineWidth = KShapelayerLineWidth;
    bottomShapeLayer.path = [UIBezierPath
                             bezierPathWithRoundedRect:CGRectMake(KShapeLayerMargin, 0, KShapeLayerWidth, KShapeLayerWidth) cornerRadius:KShapeLayerRadius].CGPath;
    [self.view.layer addSublayer:bottomShapeLayer];
    /// 橘黄色的layer
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor colorWithRed:0.984 green:0.153 blue:0.039 alpha:1.000].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = KShapelayerLineWidth;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(KShapeLayerMargin, 0,KShapeLayerWidth, KShapeLayerWidth) cornerRadius:KShapeLayerRadius].CGPath;
    [self.view.layer addSublayer:ovalShapeLayer];
    
    bottomShapeLayer.frame = CGRectMake(0, 100, KShapeLayerWidth, KShapeLayerWidth);
    ovalShapeLayer.frame = bottomShapeLayer.frame;
//    ovalShapeLayer.lineDashPattern = @[@6,@3];
    
    /// 起点动画[占满整个圆]
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    
    /// 终点动画
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    /// 组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation];
    animationGroup.duration = 2.f;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [ovalShapeLayer addAnimation:animationGroup forKey:nil];

}

- (void)_testCircle2{
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    
//        pathAnimation.calculationMode = kCAAnimationPaced;
//    
//        pathAnimation.fillMode = kCAFillModeForwards;
//    
//        pathAnimation.removedOnCompletion = NO;
//    
//        pathAnimation.duration = 0.5;
//    
//        pathAnimation.repeatCount = 0;
//    
//        
//    
//        CGMutablePathRef curvedPath = CGPathCreateMutable();
//    
//        
//    
//        CGPathMoveToPoint(curvedPath, NULL, LeftDragLine.center.x, LeftDragLine.center.y);//移动到动画开始的点（10，200）
//    
//        CGPathAddArcToPoint(curvedPath, NULL, 200 ,320,RightDragCricleBtn.center.x, RightDragCricleBtn.center. y , 0);
//    
//        CGPathAddArcToPoint(curvedPath, NULL ,RightDragCricleBtn.center.x-3, 150 ,102 ,50, 0);
//    
//        pathAnimation.path = curvedPath;
//    
//        CGPathRelease(curvedPath);
//    
//        [LeftDragLine.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

}

@end
