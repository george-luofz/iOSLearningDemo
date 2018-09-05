//
//  VSBeautyGroupSelector.h
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import <UIKit/UIKit.h>
@class VSBeautyGroupSelector;
@protocol VSBeautyGroupSelectorDelegate <NSObject>
- (void)vsBeautyGroupSelector:(VSBeautyGroupSelector *)selector selectLevel:(NSUInteger)level;
@end

@interface VSBeautyGroupSelector : UIView
@property (nonatomic, weak) id<VSBeautyGroupSelectorDelegate> delegate;

@property (nonatomic, strong) UIColor    *normalBgColor;
@property (nonatomic, strong) UIColor    *selectedBgColor;
@property (nonatomic, strong) UIColor    *normalTextColor;
@property (nonatomic, strong) UIColor    *selectedTextColor;

@property (nonatomic, strong) UIColor    *borderColor;      //边框颜色
@property (nonatomic, assign) CGFloat    horizontalMargin;  //水平间距
@property (nonatomic, assign) CGFloat    leftMagin;         //左间距
@property (nonatomic, strong) UIFont     *normalFont;       //正常字体
@property (nonatomic, strong) UIFont     *selectedFont;     //选择字体

@property (nonatomic, assign) NSUInteger levelCount;        //可选等级,0 1 2 3 4 5
@property (nonatomic, assign) NSUInteger currentLevel;      //当选选择等级

- (instancetype)initWithSize:(CGSize)size;

@end
