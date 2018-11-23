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

@interface YXLiveRoomFreeGiftAnimationViewHandler()
@property (nonatomic, strong) CALayer *containerLayer;
@property (nonatomic, strong) NSMutableArray<YXLiveRoomFreeGiftAnimationView *> *animationViews;
@end

@implementation YXLiveRoomFreeGiftAnimationViewHandler

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.animationLifeTime = KYXLiveRoomAnimationLifeTime;
        self.maxAnimationViews = KYXLiveRoomMaxAnimationViews;
        [self.layer addSublayer:self.containerLayer];
    }
    return self;
}

- (void)startAnimation{
    YXLiveRoomFreeGiftAnimationView *animationView = [self _findAnimationView];
    [animationView startAnimation];
    return;
    if (!animationView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationLifeTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           YXLiveRoomFreeGiftAnimationView *animationView = [self _findAnimationView];
            if (animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusReady ||animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusEnded){
                [animationView startAnimation];
                NSLog(@"after animationView count:%ld",self.animationViews.count);
            }
        });
    } else {
        [animationView startAnimation];
        NSLog(@"animationView count:%ld",self.animationViews.count);
    }
    
}

- (void)stopAnimation{
    for (YXLiveRoomFreeGiftAnimationView *animationView in self.animationViews) {
        if (animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusStart ||animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusPlaying){
            [animationView stopAnimation];
        }
    }
}

#pragma mark - private

- (YXLiveRoomFreeGiftAnimationView *)_findAnimationView{
//    for (YXLiveRoomFreeGiftAnimationView *animationView in self.animationViews) {
//        if (animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusEnded || animationView.animationStatus == YXLiveRoomFreeGiftAnimationStatusReady) {
//            return animationView;
//        }
//    }
//    if (self.animationViews.count >= KYXLiveRoomMaxAnimationViews){
//        return nil;
//    }
    YXLiveRoomFreeGiftAnimationView *animationView = [[YXLiveRoomFreeGiftAnimationView alloc] init];
    animationView.animationSuperLayer = self.containerLayer;
    animationView.animationLifeTime = self.animationLifeTime;
//    [self.animationViews addObject:animationView];
    return animationView;
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

- (NSMutableArray *)animationViews{
    if (!_animationViews){
        _animationViews = [NSMutableArray array];
    }
    return _animationViews;
}

@end
