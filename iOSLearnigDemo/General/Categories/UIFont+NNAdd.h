//
//  UIFont+NNAdd.h
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (NNAdd)
+ (instancetype)nn_sysRegularFontOfSize:(CGFloat)fontSize;
+ (instancetype)nn_sysMediumFontOfSize:(CGFloat)fontSize;
+ (instancetype)nn_sysBoldFontOfSize:(CGFloat)fontSize;
+ (instancetype)nn_sysSemiboldFontOfSize:(CGFloat)fontSize;
+ (instancetype)nn_sysHeavyFontOfSize:(CGFloat)fontSize;
+ (instancetype)nn_sysLightFontOfSize:(CGFloat)fontSize;
@end
