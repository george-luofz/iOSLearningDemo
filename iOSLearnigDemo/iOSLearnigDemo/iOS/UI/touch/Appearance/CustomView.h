//
//  CustomView.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/20.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView <UIAppearance>
@property (nonatomic, strong) UIColor *bgColor UI_APPEARANCE_SELECTOR;
@end

NS_ASSUME_NONNULL_END
