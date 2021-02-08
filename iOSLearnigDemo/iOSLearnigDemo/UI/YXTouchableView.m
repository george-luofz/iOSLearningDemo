//
//  YXTouchableView.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2019/8/20.
//  Copyright © 2019 George_luofz. All rights reserved.
//

#import "YXTouchableView.h"
@interface YXTouchableView()

@property (nonatomic, weak) id<YXTouchableViewDelegate> delegate;

@end
@implementation YXTouchableView

-(instancetype)initWithDelegate:(id<YXTouchableViewDelegate>)delegate
{
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchableView:didTouchMove:)]) {
        [_delegate touchableView:self didTouchMove:touches];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchableView:didTouchBegin:)]) {
        [_delegate touchableView:self didTouchBegin:touches];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchableView:didTouchEnd:)]) {
        [_delegate touchableView:self didTouchEnd:touches];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchableView:didTouchCancel:)]) {
        [_delegate touchableView:self didTouchCancel:touches];
    }
}

@end
