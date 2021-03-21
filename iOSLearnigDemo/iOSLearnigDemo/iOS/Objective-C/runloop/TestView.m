//
//  TestView.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/21.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "TestView.h"
// 先从initWithFrame探究
@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"%s",__func__);
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    NSLog(@"%s",__func__);
    [super setFrame:frame];
    
}

/*
 _afterCACommitHandler
    CA::Transaction::commit()
        CA::Context::commit_transaction
            CA::Layer::layout_and_display_if_needed
                CA::Layer::layout_if_needed
                    [CALayer layoutSublayers]
*/
- (void)layoutSubviews {
    NSLog(@"%s",__func__);
    [super layoutSubviews];
    
}

/*
 [UIView initWithFrame:]
    UIViewCommonInitWithFrame
        [TestView setNeedsDisplay]
 */
- (void)setNeedsDisplay {
    NSLog(@"%s 1",__func__);
    [super setNeedsDisplay];
    NSLog(@"%s 2",__func__);
}

- (void)displayLayer:(CALayer *)layer {
    NSLog(@"%s",__func__);
}

- (void)setNeedsLayout {
    NSLog(@"%s 1",__func__);
    [super setNeedsLayout];
    NSLog(@"%s 2",__func__);
}

- (void)layoutIfNeeded {
    NSLog(@"%s 1",__func__);
    [super layoutIfNeeded];
    NSLog(@"%s 2",__func__);
}

- (void)setNeedsUpdateConstraints {
    NSLog(@"%s",__func__);
    [super setNeedsUpdateConstraints];
}

- (void)updateConstraintsIfNeeded {
    NSLog(@"%s",__func__);
    [super updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    NSLog(@"%s",__func__);
    [super updateConstraints];
}


- (void)drawRect:(CGRect)rect {
    NSLog(@"%s 1",__func__);
    [super drawRect:rect];
    NSLog(@"%s 2",__func__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"%s",__func__);
}

- (void)didMoveToSuperview {
    NSLog(@"%s",__func__);
}

@end
