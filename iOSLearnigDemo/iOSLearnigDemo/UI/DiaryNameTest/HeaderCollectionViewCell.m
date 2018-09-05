//
//  HeaderCollectionViewCell.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "HeaderCollectionViewCell.h"

@implementation HeaderCollectionViewCell

- (void)setSelectedState:(BOOL)selectedState{
    _selectedState = selectedState;
    // TODO:
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.backgroundColor = [UIColor colorWithWhite:arc4random()%255 / 255.0 alpha:1.0f];
    }
    return self;
}
@end
