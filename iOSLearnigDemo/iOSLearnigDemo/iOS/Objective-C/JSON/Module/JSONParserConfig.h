//
//  JSONParserConfig.h
//  iOSLearnigDemo
//
//  Created by luofuzhong on 2021/9/25.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONParserConfig : NSObject
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *keyColor;

@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, strong) UIColor *numValueColor;
@property (nonatomic, strong) UIColor *boolValueColor;
@end

NS_ASSUME_NONNULL_END
