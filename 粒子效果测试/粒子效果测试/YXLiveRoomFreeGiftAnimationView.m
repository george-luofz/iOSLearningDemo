//
//  YXLiveRoomFreeGiftAnimationView.m
//  粒子效果测试
//
//  Created by 罗富中 on 2018/11/22.
//  Copyright © 2018 tqh. All rights reserved.
//

#import "YXLiveRoomFreeGiftAnimationView.h"

@interface YXLiveRoomFreeGiftAnimationView()
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) CAEmitterCell *rocketCell;
@property (nonatomic, strong) CAEmitterCell *burst;

@property (nonatomic, strong) CAEmitterLayer *emitterLayer2;
@end
@implementation YXLiveRoomFreeGiftAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.animationStatus = YXLiveRoomFreeGiftAnimationStatusReady;
    }
    return self;
}

- (void)startAnimation{
    self.animationStatus = YXLiveRoomFreeGiftAnimationStatusStart;
    if (!self.emitterLayer.superlayer){
        [self.animationSuperLayer addSublayer:self.emitterLayer];
        [self.animationSuperLayer addSublayer:self.emitterLayer2];
    }
//    if (self.emitterLayer.beginTime == 0){
//        self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
//    } else if (CACurrentMediaTime() - self.emitterLayer.beginTime > 1){
////        self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
//    } else if (CACurrentMediaTime() - self.emitterLayer.beginTime <= 1){
////        self.emitterLayer.beginTime += 1;
//    }
    self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
    self.emitterLayer2.beginTime = CACurrentMediaTime() - 1;
    self.emitterLayer.birthRate = 1.f;
    self.emitterLayer2.birthRate = 1.f;
//    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:.1];
}

- (void)stopAnimation{
    self.emitterLayer.birthRate = 0.f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.emitterLayer.hidden = YES;
        [self.emitterLayer removeFromSuperlayer];
        self.emitterLayer = nil;
//        self.emitterLayer.beginTime = CACurrentMediaTime();
//        self.animationStatus = YXLiveRoomFreeGiftAnimationStatusEnded;
    });
}

#pragma mark - private

- (CAEmitterLayer *)_buildEmitterLayer{
    
    //分为3种粒子，子弹粒子，爆炸粒子，散开粒子
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    
    fireworksEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height - 40);
    fireworksEmitter.emitterSize    = CGSizeMake(0, 0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerPoints;
    fireworksEmitter.emitterShape    = kCAEmitterLayerPoint;
    fireworksEmitter.renderMode        = kCAEmitterLayerAdditive;
    fireworksEmitter.birthRate      = 1;
//    fireworksEmitter.seed = 3;
    
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    rocket.emissionLongitude = - M_PI / 2;
    rocket.birthRate        = 1;
    rocket.velocity         = 800;
    rocket.velocityRange    = 100;
    rocket.yAcceleration    = 900;
    rocket.lifetime         = 1.04f;
    rocket.contents         = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    rocket.contentsScale    = 1.0;
    
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    burst.birthRate            = 1;        // at the end of travel
    burst.velocity            = 0.5;        //速度为0
    burst.scale                = 0.5;      //大小
    burst.lifetime            = .2;     //存在时间
//    burst.beginTime = rocket.beginTime - .2;
//    burst.emissionLongitude   = - M_PI / 2;
//    burst.emissionLongitude  = 7 / 8 * M_PI; //垂直方向
//    burst.emissionRange        = 1/2 * M_PI;    // 360 度
    
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    spark.birthRate            = 20;
    spark.velocity            = 150;
//    spark.emissionLongitude  = M_PI / 2; //垂直方向
    spark.emissionRange        = 2 * M_PI;    // 360 度
    spark.yAcceleration        = 100;        // gravity
    spark.lifetime            = 1.7;
    spark.lifetimeRange       = .1f;
    spark.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    spark.alphaSpeed        = -0.5;
    spark.spin                =  M_PI; //越小转得越慢
    spark.spinRange            = 1/2 * M_PI;

    
//    upStars.alphaSpeed = - .2 ;
    
    // 爆炸尾焰
    CAEmitterCell *boomStars = [CAEmitterCell emitterCell];
    boomStars.birthRate = 50;
    boomStars.lifetime = 1.f;
    boomStars.lifetimeRange = .1f;
    boomStars.velocity = 160;
    boomStars.yAcceleration = 100;
    boomStars.contents      = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    boomStars.scale         = .15f;
    boomStars.scaleRange    = .15f;
    boomStars.emissionLongitude  = 0;
    boomStars.emissionRange = M_PI * 2;
    boomStars.alphaSpeed -=.2f;
    
//    fireworksEmitter.emitterCells    = [NSArray arrayWithObjects:rocket,nil];
//    rocket.emitterCells                = [NSArray arrayWithObjects:burst,nil];
//    burst.emitterCells                = [NSArray arrayWithObjects:spark,nil];
//    NSMutableArray *firstEmiterArr = [NSMutableArray arrayWithArray:upstarsArray];
//    [upstarsArray insertObject:rocket atIndex:0];
    fireworksEmitter.emitterCells    = @[rocket];
    rocket.emitterCells                = [NSArray arrayWithObjects:burst,nil];
    burst.emitterCells                = [NSArray arrayWithObjects:spark,boomStars,nil];
    
    CAEmitterLayer *fireworksEmitter2 = [CAEmitterLayer layer];
    self.emitterLayer2 = fireworksEmitter;
    fireworksEmitter2.emitterPosition = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height - 40);
    fireworksEmitter2.emitterSize    = CGSizeMake(10, 0);
    fireworksEmitter2.emitterMode    = kCAEmitterLayerPoints;
    fireworksEmitter2.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter2.renderMode      = kCAEmitterLayerAdditive;
    fireworksEmitter2.birthRate      = 0;
    
    // 上升尾焰
    NSMutableArray *upstarsArray = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0;i < 5 ;i++){
        CAEmitterCell *upStars = [CAEmitterCell emitterCell];
        upStars.birthRate = 5;
        upStars.lifetime = .3f;
        upStars.velocity = 1000;
        upStars.yAcceleration = 900;
        upStars.contents      = (id) [[UIImage imageNamed:@"emitterGift1"] CGImage];
        upStars.scale         = .15f;
        upStars.scaleRange    = .05f;
        upStars.emissionLongitude  = - M_PI / 2;
        upStars.emissionRange = M_PI * 1.f/18;
        [upstarsArray addObject:upStars];
    }
    fireworksEmitter2.emitterCells = [upstarsArray copy];
    
    return fireworksEmitter;
}

- (CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer){
        _emitterLayer = [self _buildEmitterLayer];
    }
    return _emitterLayer;
}
@end
