//
//  ViewController.m
//  粒子效果测试
//
//  Created by 谭启宏 on 16/3/17.
//  Copyright © 2016年 tqh. All rights reserved.
//

#import "ViewController.h"


/**
 1·      一个或多个 CAEmitterCells ：发射器电池可以看作是单个粒子的原型（例如，一个单一的粉扑在一团烟雾）。当散发出一个粒子，UIKit根据这个发射粒子和定义的基础上创建一个随机粒子。此原型包括一些属性来控制粒子的图片，颜色，方向，运动，缩放比例和生命周期。
 
 2·      一个或多个 CAEmitterLayers， 但通常只有一个：这个发射的层主要控制粒子的形状（例如，一个点，矩形或圆形）和发射的位置（例如，在矩形内，或边缘）。这个层具有全局的乘法器，可以施加到系统内的CAEmitterCells。这些给你一个简单的方法覆盖的所有粒子的变化。比如一个人为的例子将改变x雨来模拟风的速度。
 
 基础是简单的，但这些参数却是相当微妙的。CAEmitterLayer有超过30种不同的参数进行自定义粒子的行为。
 */

@interface ViewController ()

@end

@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self animation2]; //0.7Mb 内存
//    [self animation1];
}

//雪花动画
- (void)animation1 {

    //粒子发射器
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //粒子发射的位置
    snowEmitter.emitterPosition = CGPointMake(100, 30);
    //发射源的大小
    snowEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width, 0.0);;
    //发射模式
    snowEmitter.emitterMode		= kCAEmitterLayerOutline;
    //发射源的形状
    snowEmitter.emitterShape	= kCAEmitterLayerLine;
    
    //创建雪花粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名称
    snowflake.name = @"snow";
    //粒子参数的速度乘数因子。越大出现的越快
    snowflake.birthRate		= 1.0;
    //存活时间
    snowflake.lifetime		= 120.0;
    //粒子速度
    snowflake.velocity		= -10;				// falling down slowly
    //粒子速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
      //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
    //子旋转角度范围
    snowflake.spinRange		= 0.25 * M_PI;		// slow spin
    //粒子图片
    snowflake.contents		= (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    //粒子颜色
//    snowflake.color            = [[UIColor redColor] CGColor];
    
    //设置阴影
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // 将粒子添加到粒子发射器上
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

//烟花动画
- (void)animation2 {
    // Cells spawn in the bottom, moving up
   
    CALayer *containerLayer = [CALayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    containerLayer.masksToBounds = YES;
    CGRect frame = CGRectMake(viewBounds.size.width/2.0, viewBounds.size.height / 2, 100, 800 );;
    containerLayer.frame = frame;
    
    //分为3种粒子，子弹粒子，爆炸粒子，散开粒子
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    fireworksEmitter.frame = containerLayer.bounds;
    
    fireworksEmitter.emitterPosition = CGPointMake(50,800);
    fireworksEmitter.emitterSize	= CGSizeMake(0, 0.0);
    fireworksEmitter.emitterMode	= kCAEmitterLayerPoint;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerUnordered;
//    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0;  // some variation in angle
    rocket.velocity			= 500;
    rocket.velocityRange	= 0;
    rocket.yAcceleration	= -400;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    
    //小圆球图片
    rocket.contents			= (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    rocket.scale			= 1.0;
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0.5;        //速度为0
    burst.scale				= 0.5;      //大小
    burst.lifetime			= 0.35;     //存在时间
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
//    spark.scale             = 1.0f;
    spark.birthRate			= 20;
    spark.velocity			= 125;
    spark.emissionRange		= M_PI;	// 360 度
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 3;
    //星星图片
    spark.contents			= (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    spark.scaleSpeed		=-0.3;
    spark.alphaSpeed		=-0.25;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    
    // 烟花尾焰
    CAEmitterCell *dots = [CAEmitterCell emitterCell];
    dots.birthRate = 3;
    
    
    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:containerLayer];
    [containerLayer addSublayer:fireworksEmitter];
}


//🔥效果，有点屌哦
- (void)animation3 {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
