//
//  WBLPerformerStickerDeleteView.h
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/27.
//  Copyright © 2020 景中杰. All rights reserved.
//  主播端贴纸删除视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBLPerformerStickerDeleteView : UIView

- (BOOL)chargePointCurrentInside:(CGPoint)point;

- (void)highlightedForPointInside;
- (void)resetHightlight;

- (CGRect)highlightedFrame;

@end

NS_ASSUME_NONNULL_END
