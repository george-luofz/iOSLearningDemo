//
//  VSGroupSelectorHeader.h
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import <UIKit/UIKit.h>
@protocol VSGroupSelectorHeaderDelegate <NSObject>
- (void)clickAtIndex:(NSInteger)index titleStr:(NSString *)title;
@end

@class VSGroupSelector;
@interface VSGroupSelectorHeader : UIView
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, weak) id<VSGroupSelectorHeaderDelegate> delegate;
@property (nonatomic, weak) VSGroupSelector *groupSelector;

@property (nonatomic, strong) UIFont    *normalFont;
@property (nonatomic, strong) UIFont    *selectedFont;
@property (nonatomic, strong) UIColor   *normalColor;
@property (nonatomic, strong) UIColor   *selectedColor;

@property (nonatomic, assign) CGFloat   tagTopMagin;
@property (nonatomic, assign) CGFloat   tagHorizontalMargin;

@property (nonatomic, assign) BOOL      useConstantUnderLineWidth; //下划线长度是否固定，默认不固定
@property (nonatomic, assign) CGFloat   underLineWidth;
@property (nonatomic, assign) CGFloat   underLineHeight;
@property (nonatomic, strong) UIColor   *underLineColor;

@property (nonatomic, assign) CGFloat   selectedScale;      // 伸缩比例

@property (nonatomic, assign) NSInteger currentSelectIndex; //默认选择索引

- (instancetype)initWithSize:(CGSize)size;

/**
 设置相关属性后，配置视图
 */
- (void)setupSubViews;
/**
 从fromIndex滚动到toIndex
 */
- (void)scollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;
@end
