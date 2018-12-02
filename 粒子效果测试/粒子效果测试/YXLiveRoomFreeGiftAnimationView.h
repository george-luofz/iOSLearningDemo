//
//  YXLiveRoomFreeGiftAnimationView.h
//  粒子效果测试
//
//  Created by 罗富中 on 2018/11/22.
//  Copyright © 2018 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, YXLiveRoomFreeGiftAnimationStatus) {
    YXLiveRoomFreeGiftAnimationStatusReady       = 0,
    YXLiveRoomFreeGiftAnimationStatusStart       = 1,
    YXLiveRoomFreeGiftAnimationStatusPlaying     = 2,
    YXLiveRoomFreeGiftAnimationStatusEnded       = 3
};

@interface YXLiveRoomFreeGiftAnimationView : UIView

@property (nonatomic, assign) YXLiveRoomFreeGiftAnimationStatus animationStatus;
@property (nonatomic, weak) CALayer *animationSuperLayer;
@property (nonatomic, assign) NSTimeInterval animationLifeTime;

- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
