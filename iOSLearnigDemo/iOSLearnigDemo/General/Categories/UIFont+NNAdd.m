//
//  UIFont+NNAdd.m
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "UIFont+NNAdd.h"

@implementation UIFont (NNAdd)
+ (instancetype)nn_sysRegularFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (instancetype)nn_sysMediumFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (instancetype)nn_sysBoldFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
    } else {
        return [UIFont boldSystemFontOfSize:fontSize];
    }
}

+ (instancetype)nn_sysSemiboldFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (instancetype)nn_sysHeavyFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightHeavy];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+ (instancetype)nn_sysLightFontOfSize:(CGFloat)fontSize {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}
@end
