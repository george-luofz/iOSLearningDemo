//
//  WBLEditableImageStickerWidget.h
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/31.
//  Copyright © 2020 景中杰. All rights reserved.
//

#import "WBLStickerEditAreaLayoutProtocol.h"
#import "WBLStickerLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBLEditableImageStickerWidget : UIImageView <WBLStickerLayoutProtocol,WBLStickerEditAreaLayoutProtocol>

@property (nonatomic, copy) void (^pinFinishedCallback)(CGFloat totalScale);
@property (nonatomic, copy) void (^rotateFinishedCallback)(CGFloat rotate);
@property (nonatomic, copy) void (^panStartCallback)(CGPoint point);
@property (nonatomic, copy) void (^panFinishedCallback)(CGPoint point);
@property (nonatomic, copy) void (^panShouldHighlightDeleteCallback)(CGPoint point);
@property (nonatomic, copy) void (^panShouldResetHighlightDeleteCallback)(CGPoint point);
@property (nonatomic, copy) void (^panShouldDeleteCallback)(CGPoint point);

- (void)updateLayoutForOrientaionChanged;

//- (void)updateWithEditModel:(WBLImageStickerEditModel *)editModel;

@end

NS_ASSUME_NONNULL_END
