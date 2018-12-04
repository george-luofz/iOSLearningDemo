//
//  ViewController.m
//  粒子效果测试
//
//  Created by 谭启宏 on 16/3/17.
//  Copyright © 2016年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "YXLiveRoomFreeGiftAnimationViewHandler.h"

/**
 1·      一个或多个 CAEmitterCells ：发射器电池可以看作是单个粒子的原型（例如，一个单一的粉扑在一团烟雾）。当散发出一个粒子，UIKit根据这个发射粒子和定义的基础上创建一个随机粒子。此原型包括一些属性来控制粒子的图片，颜色，方向，运动，缩放比例和生命周期。
 
 2·      一个或多个 CAEmitterLayers， 但通常只有一个：这个发射的层主要控制粒子的形状（例如，一个点，矩形或圆形）和发射的位置（例如，在矩形内，或边缘）。这个层具有全局的乘法器，可以施加到系统内的CAEmitterCells。这些给你一个简单的方法覆盖的所有粒子的变化。比如一个人为的例子将改变x雨来模拟风的速度。
 
 基础是简单的，但这些参数却是相当微妙的。CAEmitterLayer有超过30种不同的参数进行自定义粒子的行为。
 */

@interface ViewController ()
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) YXLiveRoomFreeGiftAnimationViewHandler *viewHandler;
@end

@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    [self animation2]; //0.7Mb 内存
//    [self animation1];
    
    CGRect viewBounds = self.view.bounds;
    CGRect frame = CGRectMake(viewBounds.size.width - 200, 0, 200, viewBounds.size.height);
    YXLiveRoomFreeGiftAnimationViewHandler *view = [[YXLiveRoomFreeGiftAnimationViewHandler alloc] initWithFrame:frame];
    self.viewHandler = view;
    [self.view addSubview:view];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100, 30);
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked:(UIButton *)sender{
    [self.viewHandler startAnimation];
}


@end
