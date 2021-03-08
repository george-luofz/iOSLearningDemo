//
//  YXTouchableView.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2019/8/20.
//  Copyright © 2019 George_luofz. All rights reserved.
//

#import "YXLiveRoomView.h"

@class YXTouchableView;
@protocol YXTouchableViewDelegate <NSObject>

- (void)touchableView:(YXTouchableView*)view didTouchMove:(NSSet<UITouch*>*)touches;
- (void)touchableView:(YXTouchableView*)view didTouchBegin:(NSSet<UITouch*>*)touches;
- (void)touchableView:(YXTouchableView*)view didTouchEnd:(NSSet<UITouch*>*)touches;
- (void)touchableView:(YXTouchableView*)view didTouchCancel:(NSSet<UITouch*>*)touches;

@end

@interface YXTouchableView : YXLiveRoomView

@end

