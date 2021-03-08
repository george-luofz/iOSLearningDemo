//
//  WBLPerformerStickerWidget.h
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/27.
//  Copyright © 2020 景中杰. All rights reserved.
//  主播端贴纸容器widget，全屏大小

#import "WBLPerformerStickerDeleteView.h"
#import "WBLStickerEditAreaLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBLPerformerStickerWidget : UIView <WBLStickerEditAreaLayoutProtocol>
@property (nonatomic, strong, readonly) WBLPerformerStickerDeleteView *deleteView;
@property (nonatomic, assign) BOOL isFullScreen;

@end

NS_ASSUME_NONNULL_END
