//
//  YXLiveRoomFreeGiftAnimationViewHandler.m
//  粒子效果测试
//
//  Created by 罗富中 on 2018/11/22.
//  Copyright © 2018 tqh. All rights reserved.
//

#import "YXLiveRoomFreeGiftAnimationViewHandler.h"
#import "YXLiveRoomFreeGiftAnimationView.h"

static NSUInteger KYXLiveRoomMaxAnimationViews = 5;
static NSTimeInterval KYXLiveRoomAnimationLifeTime = 1.02f;

@interface YXLiveRoomFreeGiftAnimationViewHandler()<YXLiveRoomFreeGiftAnimationViewDelegate>
@property (nonatomic, strong) CALayer *containerLayer;
@property (nonatomic, strong) YXLiveRoomFreeGiftAnimationView *currentAnimationView;
@property (nonatomic, assign) NSInteger lastAnimationCount;

@end

@implementation YXLiveRoomFreeGiftAnimationViewHandler

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.lastAnimationCount = 0;
        self.animationLifeTime = KYXLiveRoomAnimationLifeTime;
        self.maxAnimationViews = KYXLiveRoomMaxAnimationViews;
        [self.layer addSublayer:self.containerLayer];
    }
    return self;
}

- (void)startAnimation{
    [self _startAnimation];
}

- (void)stopAnimation{
    
//    for (YXLiveRoomFreeGiftAnimationView *animationView in self.animationViews) {
//        if (animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusStart ||animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusPlaying){
//            [animationView stopAnimation];
//        }
//    }
}

- (void)startAnimationWithCount:(NSUInteger)count{
    if (count <=0 )return;
    self.lastAnimationCount+=count;
    
}


#pragma mark - private

- (void)_startAnimation{
    self.lastAnimationCount--;
    YXLiveRoomFreeGiftAnimationView *animationView = [[YXLiveRoomFreeGiftAnimationView alloc] initWithFrame:self.bounds];
    animationView.animationSuperLayer = self.containerLayer;
    animationView.animationLifeTime = self.animationLifeTime;
    animationView.delegate = self;
    [animationView startAnimation];
}

#pragma mark - g/setters
- (CALayer *)containerLayer{
    if (!_containerLayer){
        CALayer *containerLayer = [CALayer layer];
        containerLayer.masksToBounds = YES;
        containerLayer.frame = self.bounds;
        _containerLayer = containerLayer;
    }
    return _containerLayer;
}

@end
