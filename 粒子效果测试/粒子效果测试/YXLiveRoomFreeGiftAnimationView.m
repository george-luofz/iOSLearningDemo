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
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    self.rocketCell = rocket;
    
    rocket.birthRate        = 1;
    rocket.emissionRange    = 0;  // some variation in angle
    rocket.velocity            = 500;
    rocket.yAcceleration    = -450;
    rocket.lifetime            = 1.02;    // we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    rocket.scale            = 1.0;
    
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    self.burst = burst;
    burst.birthRate            = 1.0;        // at the end of travel
    burst.velocity            = .5;        //速度为0
    burst.scale                = 0.5;      //大小
    burst.lifetime            = .2;     //存在时间
    
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 40;
    spark.velocity            = 250;
    spark.emissionLatitude  = .5f;
    spark.emissionRange        = M_PI_2;    // 360 度
    spark.yAcceleration        = 125;        // gravity
    spark.lifetime            = 1.5;
    
    //星星图片
    spark.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    spark.scaleSpeed        =-0.3;
    spark.alphaSpeed        =-0.25;
    spark.spin                = 2* M_PI;
    spark.spinRange            = 2* M_PI;
    

    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    fireworksEmitter.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                = [NSArray arrayWithObject:burst];
    burst.emitterCells                = [NSArray arrayWithObject:spark];

    return fireworksEmitter;
}

- (CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer){
        _emitterLayer = [self _buildEmitterLayer];
    }
    return _emitterLayer;
}
@end
