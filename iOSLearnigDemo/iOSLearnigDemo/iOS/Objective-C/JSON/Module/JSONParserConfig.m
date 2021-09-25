//
//  JSONParserConfig.m
//  iOSLearnigDemo
//
//  Created by luofuzhong on 2021/9/25.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "JSONParserConfig.h"

@implementation JSONParserConfig

- (instancetype)init {
    if (self = [super init]) {
        _font = [UIFont systemFontOfSize:12];
        
        _keyColor = _colorWithRGB(134, 48, 139);
        _valueColor = _colorWithRGB(108, 185, 100);
        
        _numValueColor = _colorWithRGB(83, 168, 221);
        _boolValueColor = _colorWithRGB(234, 136, 131);
    }
    return self;
}

UIColor *_colorWithRGB(NSInteger r, NSInteger g , NSInteger b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.f blue:b/255.f alpha:1.f];
}
@end
