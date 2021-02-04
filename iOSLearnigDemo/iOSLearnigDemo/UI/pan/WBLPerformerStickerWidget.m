//
//  WBLPerformerStickerWidget.m
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/27.
//  Copyright © 2020 景中杰. All rights reserved.
//

#import "WBLPerformerStickerWidget.h"
#import "WBLStickerModuleDefine.h"

static CGFloat kWBLPerformerStickerWidgetDeleteViewVheight = 113.f;  ///删除视图，竖屏高度
static CGFloat kWBLPerformerStickerWidgetDeleteViewHheight = 70.f;   ///删除视图，横屏高度
static CGFloat kWBLPerformerStickerWidgetBottomViewVheight = 271.f;  ///底部视图(目前是评论区和底部栏，不含安全区)，竖屏高度
static CGFloat kWBLPerformerStickerWidgetBottomViewHHeight = 43.f;   ///底部视图(目前是底部栏)，横屏高度
static CGFloat kWBLPerformerStickerWidgetLeftViewHWidth = 290.f;     ///底部视图，横屏高度

@interface WBLPerformerStickerWidget()
@property (nonatomic, strong) WBLPerformerStickerDeleteView *deleteView;
@property (nonatomic, assign) CGFloat totalScale; ///放大系数

@end

@implementation WBLPerformerStickerWidget

@synthesize dragRect = _dragRect;
@synthesize deleteRect = _deleteRect;
@synthesize deleteSureRect = _deleteSureRect;
@synthesize dragAndDeleteRect = _dragAndDeleteRect;

- (id)initWithData:(NSDictionary *)data {
    if (self = [super init]) {} return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.deleteView];
        [self.deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.deleteView.superview);
            make.height.mas_equalTo(113.f);
        }];
        [self updateLayoutForOrientaionChanged:NO];
    }
    return self;
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    
    [self updateLayoutForOrientaionChanged:isFullScreen];
}

- (void)updateLayoutForOrientaionChanged:(BOOL)isFullScreen {
    [self.deleteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(isFullScreen ? 70 : 113);
    }];
    
    [self updateRectsForOrientaionChanged:isFullScreen];
}

- (void)updateRectsForOrientaionChanged:(BOOL)isFullScreen {
//    BOOL isIphoneX = WBDeviceIsFullScreenIphone;
    CGFloat realHeight = kRealHeight;
    CGFloat realWidth = kRealWidth;
    
    if (!isFullScreen) {
        self.deleteRect = CGRectMake(0, 0, realWidth, kWBLPerformerStickerWidgetDeleteViewVheight);
        self.dragRect = CGRectMake(0, CGRectGetMaxY(self.deleteRect), realWidth, realHeight - (kWBLPerformerStickerWidgetBottomViewVheight + 0 + CGRectGetMaxY(self.deleteRect)));
        self.dragAndDeleteRect = CGRectMake(0, 0, realWidth, realHeight - (kWBLPerformerStickerWidgetBottomViewVheight + 0));
    } else {
        self.deleteRect = CGRectMake(0, 0, realHeight, kWBLPerformerStickerWidgetDeleteViewHheight);
        self.dragRect = CGRectMake(kWBLPerformerStickerWidgetLeftViewHWidth, CGRectGetMaxY(self.deleteRect), realHeight - kWBLPerformerStickerWidgetLeftViewHWidth, realWidth - (kWBLPerformerStickerWidgetBottomViewHHeight + CGRectGetMaxY(self.deleteRect)));
        self.dragAndDeleteRect = CGRectMake(kWBLPerformerStickerWidgetLeftViewHWidth, 0, realHeight - kWBLPerformerStickerWidgetLeftViewHWidth, realWidth - (kWBLPerformerStickerWidgetBottomViewHHeight));
    }
    self.deleteSureRect = [self.deleteView highlightedFrame];
    self.deleteSureRect = CGRectMake((self.deleteRect.size.width - self.deleteSureRect.size.width) / 2, (self.deleteRect.size.height - self.deleteSureRect.size.height) / 2, self.deleteSureRect.size.width, self.deleteSureRect.size.height);
    NSLog(@"wblive-富中: 删除区%@, 删除确认区%@, 拖拽区%@, 总区%@",NSStringFromCGRect(self.deleteRect), NSStringFromCGRect(self.deleteSureRect), NSStringFromCGRect(self.dragRect), NSStringFromCGRect(self.dragAndDeleteRect));
}

- (WBLPerformerStickerDeleteView *)deleteView {
    if (!_deleteView) {
        _deleteView = [WBLPerformerStickerDeleteView new];
        _deleteView.hidden = YES;
    }
    return _deleteView;
}


@end
