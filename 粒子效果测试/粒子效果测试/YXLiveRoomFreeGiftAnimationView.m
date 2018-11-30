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
@end
@implementation YXLiveRoomFreeGiftAnimationView

- (instancetype)init{
    if (self = [super init]){
        self.animationStatus = YXLiveRoomFreeGiftAnimationStatusReady;
    }
    return self;
}

- (void)startAnimation{
    self.animationStatus = YXLiveRoomFreeGiftAnimationStatusStart;
    if (!self.emitterLayer.superlayer){
        [self.animationSuperLayer addSublayer:self.emitterLayer];
    }
//    if (self.emitterLayer.beginTime == 0){
//        self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
//    } else if (CACurrentMediaTime() - self.emitterLayer.beginTime > 1){
////        self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
//    } else if (CACurrentMediaTime() - self.emitterLayer.beginTime <= 1){
////        self.emitterLayer.beginTime += 1;
//    }
    self.emitterLayer.beginTime = CACurrentMediaTime() - 1; //
    self.emitterLayer.birthRate = 1.f;
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:.1];
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
    
    fireworksEmitter.emitterPosition = CGPointMake(50,800);
    fireworksEmitter.emitterSize    = CGSizeMake(0, 0.0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerPoint;
    fireworksEmitter.emitterShape    = kCAEmitterLayerLine;
    fireworksEmitter.renderMode        = kCAEmitterLayerOldestFirst;
    fireworksEmitter.birthRate      = 0;
//    fireworksEmitter.seed = 3;
    
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    rocket.birthRate        = 1;
    rocket.velocity            = 500;
    rocket.yAcceleration    = -450;
    rocket.lifetime            = 1.02;    // we cannot set the birthrate < 1.0 for the burst
    rocket.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    rocket.scale            = 1.0;
    
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = .5;        //速度为0
    burst.scale                = 0.5;      //大小
    burst.lifetime            = .2;     //存在时间
//    burst.emissionLongitude = 2 * M_PI;
    
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    spark.birthRate            = 20;
    spark.velocity            = 250;
    spark.emissionLongitude  = 0; //垂直方向
    spark.emissionRange        = 2 * M_PI;    // 360 度
    spark.yAcceleration        = 125;        // gravity
    spark.lifetime            = 1.5;
    spark.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    spark.alphaSpeed        =-0.25;
    spark.spin                = 2 * M_PI; //越小转得越慢
//    spark.spinRange            =  M_PI;
    
    // 上升尾焰
    CAEmitterCell *upStars = [CAEmitterCell emitterCell];
    upStars.birthRate = 6;
    upStars.lifetime = .5f;
    upStars.velocity = 500;
    upStars.yAcceleration = -250;
    upStars.contents      = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    upStars.scale         = .15f;
    upStars.emissionLongitude  = 0;
    upStars.emissionRange = M_PI * 1/36;
    upStars.alphaSpeed = - 1.5 ;
    
    // 爆炸尾焰
    CAEmitterCell *boomStars = [CAEmitterCell emitterCell];
    boomStars.birthRate = 40;
    boomStars.lifetime = 1.5f;
    boomStars.lifetimeRange = 1.f;
    boomStars.velocity = 100;
    boomStars.yAcceleration = 60;
    boomStars.contents      = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    boomStars.scale         = .1f;
    boomStars.emissionLongitude  = 0;
    boomStars.emissionRange = M_PI * 2;
    boomStars.alphaSpeed -=.25;
    
    fireworksEmitter.emitterCells    = [NSArray arrayWithObjects:rocket,nil];
    rocket.emitterCells                = [NSArray arrayWithObjects:upStars,burst,nil];
    burst.emitterCells                = [NSArray arrayWithObjects:spark,boomStars,nil];
    return fireworksEmitter;
}

- (CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer){
        _emitterLayer = [self _buildEmitterLayer];
    }
    return _emitterLayer;
}
@end
