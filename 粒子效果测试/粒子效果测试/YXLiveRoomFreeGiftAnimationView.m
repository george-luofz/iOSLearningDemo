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
    }
    self.emitterLayer.beginTime = CACurrentMediaTime() - 1;
    self.emitterLayer.birthRate = 1.f;
//    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:.1];
}

- (void)stopAnimation{
    self.emitterLayer.birthRate = 0.f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.24f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.emitterLayer.hidden = YES;
        [self.emitterLayer removeFromSuperlayer];
        self.emitterLayer = nil;
        self.animationStatus = YXLiveRoomFreeGiftAnimationStatusEnded;
    });
}

#pragma mark - private

- (CAEmitterLayer *)_buildEmitterLayer{
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    fireworksEmitter.emitterPosition = CGPointMake(self.bounds.size.width -23,self.bounds.size.height + 500); //500
    fireworksEmitter.emitterSize    = CGSizeMake(0, 0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerPoints;
    fireworksEmitter.emitterShape    = kCAEmitterLayerPoint;
    fireworksEmitter.renderMode        = kCAEmitterLayerUnordered;
    fireworksEmitter.birthRate      = 1;
    
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.emissionLongitude = - M_PI / 2;
    rocket.birthRate        = 1;
    rocket.velocity         = 1780; //1780
    rocket.velocityRange    = 20;
    rocket.yAcceleration    = 1800; //1800
    rocket.lifetime         = 1.04f;
    rocket.contents         = (id) [[UIImage imageNamed:@"emitterGift_big"] CGImage];
    rocket.scale = .6;
    
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    burst.birthRate            = 1;
    burst.velocity            = 0;
    burst.lifetime            = .2;
    
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.birthRate            = 20;
    spark.velocity            = 200;
    spark.emissionLongitude  = -M_PI_2;
    spark.emissionRange        = -M_PI * 5/18;
    spark.yAcceleration        = 200;
    spark.lifetime            = 1.1;
    spark.lifetimeRange       = .1f;
    spark.contents            = (id) [[UIImage imageNamed:@"emitterGift"] CGImage];
    spark.alphaSpeed        = -0.8;
    spark.spin                =  M_PI;
    spark.spinRange            = M_PI_2;
    spark.scale = .9f;
    
    CAEmitterCell *boomStars = [CAEmitterCell emitterCell];
    boomStars.birthRate = 50;
    boomStars.lifetime = 1.f;
    boomStars.lifetimeRange = .1f;
    boomStars.velocity = 150;
    boomStars.yAcceleration = 100;
    boomStars.contents      = (id) [[UIImage imageNamed:@"boomDot"] CGImage];
    boomStars.emissionLongitude  = M_PI * 9/8;
    boomStars.emissionRange = M_PI * 3/8;
    boomStars.alphaRange = .5f;
    boomStars.alphaSpeed = -1.f;
    
    CAEmitterCell *upStars = [CAEmitterCell emitterCell];
    upStars.birthRate = 8;
    upStars.lifetime = .6f;
    upStars.velocity = 200;
    upStars.yAcceleration = 300;
    upStars.contents      = (id) [[UIImage imageNamed:@"upDot"] CGImage];
    upStars.emissionRange = M_PI * 1.f/18;
    upStars.beginTime = rocket.beginTime - 1.05f;
    upStars.alphaSpeed = -1.;
    
    fireworksEmitter.emitterCells    = @[rocket];
    rocket.emitterCells                = @[burst];
    burst.emitterCells                = @[spark];
    
    return fireworksEmitter;
}

- (CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer){
        _emitterLayer = [self _buildEmitterLayer];
    }
    return _emitterLayer;
}
@end
