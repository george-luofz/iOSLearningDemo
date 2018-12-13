//
//  YXLiveRoomFreeGiftAnimationManager.h
//  粒子效果测试
//
//  Created by 罗富中 on 2018/11/22.
//  Copyright © 2018 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXLiveRoomFreeGiftAnimationManager : UIView
@property (nonatomic, assign) NSUInteger maxAnimationViews; ///最大创建动画数默认5个
@property (nonatomic, assign) NSTimeInterval animationRepeatDuration; // 动画得间隔

- (void)stopAnimation;

- (void)startAnimationWithCount:(NSUInteger)count; 
@end

NS_ASSUME_NONNULL_END
