//
//  YXLiveRoomSpendPanelTabSelector.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/11/4.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YXLiveRoomSpendPanelTabSelectorDelegate <NSObject>
@optional
- (void)clickAtIndex:(NSInteger)index titleStr:(NSString *)title;
@end

@interface YXLiveRoomSpendPanelTabSelector : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, weak) id<YXLiveRoomSpendPanelTabSelectorDelegate> delegate;
//@property (nonatomic, weak) VSGroupSelector *groupSelector;

@property (nonatomic, strong) UIFont    *normalFont;
@property (nonatomic, strong) UIFont    *selectedFont;
@property (nonatomic, strong) UIColor   *normalColor;
@property (nonatomic, strong) UIColor   *selectedColor;

@property (nonatomic, assign) CGFloat   tagTopMagin;
@property (nonatomic, assign) CGFloat   tagHorizontalMargin;
@property (nonatomic, assign) CGFloat   tagLeadingMagin; //最左边宽度

@property (nonatomic, assign) BOOL      useConstantUnderLineWidth; //下划线长度是否固定，默认不固定
@property (nonatomic, assign) CGFloat   underLineWidth;
@property (nonatomic, assign) CGFloat   underLineHeight;
@property (nonatomic, strong) UIColor   *underLineColor;
@property (nonatomic, assign) BOOL      disaleUnderLine;    //禁用下划线

@property (nonatomic, assign) CGFloat   selectedScale;      // 伸缩比例

@property (nonatomic, assign) NSInteger currentSelectIndex; //默认选择索引

//- (instancetype)initWithSize:(CGSize)size;

/**
 设置相关属性后，配置视图
 */
- (void)setupSubViews;
/**
 从fromIndex滚动到toIndex
 */
- (void)scollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;


@end

NS_ASSUME_NONNULL_END
