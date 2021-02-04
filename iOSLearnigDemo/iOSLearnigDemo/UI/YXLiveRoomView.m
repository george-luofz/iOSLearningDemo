//
//  YXLiveRoomView.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2019/8/16.
//  Copyright © 2019 George_luofz. All rights reserved.
//

#import "YXLiveRoomView.h"

@implementation YXLiveRoomView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.penetrate) {
        UIView *respondView = nil;
        if (self.subviews.count > 0) {
            NSInteger i = 0;
            for (i = self.subviews.count - 1 ; i >= 0 ; i--) {
                UIView *view = self.subviews[i];
                respondView = [view hitTest:[self convertPoint:point toView:view] withEvent:event];
                if (respondView) {
                    break;
                }
            }
        }
        return respondView;
        
    } else {
        UIView *view = [super hitTest:point withEvent:event];
        return view;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
}
@end
