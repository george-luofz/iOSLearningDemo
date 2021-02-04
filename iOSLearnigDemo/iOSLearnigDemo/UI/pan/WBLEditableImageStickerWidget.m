//
//  WBLEditableImageStickerWidget.m
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/31.
//  Copyright © 2020 景中杰. All rights reserved.
//

#import "WBLEditableImageStickerWidget.h"
#import "WBLStickerModuleDefine.h"

@interface WBLEditableImageStickerWidget()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat totalScale; ///总放大系数
@property (nonatomic, assign) CGFloat totalRotation; ///总旋转弧度数
@end
@implementation WBLEditableImageStickerWidget

@synthesize correctWidth = _correctWidth;
@synthesize correctScale = _correctScale;
@synthesize correctHeight = _correctHeight;

@synthesize dragRect = _dragRect;
@synthesize deleteRect = _deleteRect;
@synthesize deleteSureRect = _deleteSureRect;
@synthesize dragAndDeleteRect = _dragAndDeleteRect;

- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.totalScale = 1;
        [self addGestures];
    }
    return self;
}
//
//- (void)updateLayoutForOrientaionChanged {
//    CGFloat correctWidth = self.correctWidth;
//    CGFloat correctHeight = self.correctHeight;
//
//    WBLImageStickerEditModel *editModel = self.editModel;
//    self.center = CGPointMake(correctWidth * editModel.x_axis, correctHeight * editModel.y_axis);
//    self.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(editModel.rotation / kPerDegreeForPi), CGAffineTransformMakeScale(editModel.multiple, editModel.multiple));
//}


#pragma mark - gesture

- (void)addGestures {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:panGestureRecognizer];
    
//    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinAction:)];
//    pinchGestureRecognizer.delegate = self;
//    [self addGestureRecognizer:pinchGestureRecognizer];
//
//    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationAction:)];
//    rotation.delegate = self;
//    [self addGestureRecognizer:rotation];
}

/// 缩放
- (void)handlePinAction:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    UIView *view = pinchGestureRecognizer.view;
    CGFloat scale = pinchGestureRecognizer.scale;
    
    //放大情况
    if(scale > 1.0){
        if(self.totalScale > kWBLImageStickerScaleMaxValue) return;
    }
    //缩小情况
    if (scale < 1.0) {
        if (self.totalScale < kWBLImageStickerScaleMinValue) return;
    }
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
        self.totalScale *= scale;
    }
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.pinFinishedCallback) {
            NSLog(@"wblive-贴纸: 缩放%.6lf",self.totalScale);
            self.pinFinishedCallback(self.totalScale);
        }
    }
}

/// 旋转
- (void)handleRotationAction:(UIRotationGestureRecognizer *)rotation {
    
    UIImageView *imageView = (UIImageView *)rotation.view;
    //旋转视图
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
    
    NSLog(@"wblive-贴纸: 当前旋转角度%.6lf",rotation.rotation);
    self.totalRotation += rotation.rotation * kPerDegreeForPi;
    NSLog(@"wblive-贴纸: 计算旋转角度%.6lf",self.totalRotation);
    if(rotation.state == UIGestureRecognizerStateEnded) {
        if (self.rotateFinishedCallback) {
            NSLog(@"wblive-贴纸: 旋转%.6lf",self.totalRotation);
            self.rotateFinishedCallback(self.totalRotation);
        }
    }
    
    //将旋转量归为单位值
    rotation.rotation = 0;
}

/// 拖拽
- (void)handlePanAction:(UIPanGestureRecognizer *)sender {
    NSLog(@"wblive-贴纸：拖拽1%@",NSStringFromCGPoint([sender translationInView:sender.view]));
    CGPoint point = [sender translationInView:[sender.view superview]];
    NSLog(@"wblive-贴纸：拖拽2%@",NSStringFromCGPoint(point));
    CGFloat senderHalfViewWidth = sender.view.frame.size.width / 2;
    CGFloat senderHalfViewHeight = sender.view.frame.size.height / 2;
    
    NSLog(@"wblive-贴纸：拖拽3%@",NSStringFromCGPoint(sender.view.center));
    CGPoint viewCenter = CGPointMake(sender.view.center.x + point.x, sender.view.center.y + point.y);
    NSLog(@"wblive-贴纸：拖拽4%@",NSStringFromCGPoint(viewCenter));
    /// 拖拽过程中，监测中心是否超出
    if (sender.state != UIGestureRecognizerStateEnded) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            if (self.panStartCallback) {
                NSLog(@"wblive-贴纸：拖拽开始%@",NSStringFromCGPoint(point));
                self.panStartCallback(point);
            }
        }
        /// 左、右、下超出不让滑动，上超出也不让滑
        if (viewCenter.x < CGRectGetMinX(self.dragAndDeleteRect) ||
            viewCenter.x > CGRectGetMaxX(self.dragAndDeleteRect) ||
            viewCenter.y > CGRectGetMaxY(self.dragAndDeleteRect) ||
            viewCenter.y < CGRectGetMinY(self.dragAndDeleteRect)) {
            NSLog(@"wblive-贴纸：拖拽超出上下左右边界 %@",NSStringFromCGPoint(point));
            [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
            return;
        }
        /// 上超出，监测删除区
        BOOL shouldHeightLight = NO;
        if (viewCenter.y >= CGRectGetMinY(self.deleteRect) &&
            viewCenter.y <= CGRectGetMaxY(self.deleteRect)) {
            NSLog(@"wblive-贴纸：拖拽删除区滑动 %@",NSStringFromCGPoint(point));
            if (CGRectContainsPoint(self.deleteSureRect, viewCenter)) {
                shouldHeightLight = YES;
                NSLog(@"wblive-贴纸：拖拽删除高亮 %@",NSStringFromCGPoint(point));
                [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
                if (self.panShouldHighlightDeleteCallback) { ///需要高亮删除显示
                    self.panShouldHighlightDeleteCallback(point);
                }
            }
        }
        if (!shouldHeightLight) {///不需要高亮删除显示
            if (self.panShouldResetHighlightDeleteCallback) {
                self.panShouldResetHighlightDeleteCallback(point);
            }
        }
        /// 正常滑动
        NSLog(@"wblive-贴纸：正常滑动 %@",NSStringFromCGPoint(point));
        sender.view.center = viewCenter;
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
    } else { // 拖拽结束
        /// 监测是否要删除，是否归位
        if (viewCenter.y > CGRectGetMinY(self.deleteRect) &&
            viewCenter.y < CGRectGetMaxY(self.deleteRect)) {
            if (CGRectContainsPoint(self.deleteSureRect, viewCenter)) {
                NSLog(@"wblive-贴纸：拖拽确认删除 %@",NSStringFromCGPoint(point));
                [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
                if (self.panShouldDeleteCallback) { ///需要删除
                    self.panShouldDeleteCallback(point);
                    return;
                }
            }
        }
        /// 超出屏幕归位
        /// 上
        if (viewCenter.y - CGRectGetMaxY(self.deleteRect) <= 0) {
            viewCenter.y = CGRectGetMaxY(self.deleteRect) ;
            NSLog(@"wblive-贴纸：拖拽上方超出%@",NSStringFromCGPoint(point));
        }
//        else if (CGRectGetMaxY(self.dragRect) - viewCenter.y <= senderHalfViewHeight) { /// 下
//            NSLog(@"wblive-贴纸：拖拽下方超出%@",NSStringFromCGPoint(point));
//            viewCenter.y = CGRectGetMaxY(self.dragRect) - senderHalfViewHeight;
//        }
        
        /// 左
//        if ((viewCenter.x - CGRectGetMinX(self.dragRect)) <= senderHalfViewWidth) {
//            NSLog(@"wblive-贴纸：拖拽左方超出%@",NSStringFromCGPoint(point));
//            viewCenter.x = CGRectGetMinX(self.dragRect) + senderHalfViewWidth;
//        } else if (CGRectGetMaxX(self.dragRect) - viewCenter.x <= senderHalfViewWidth) { /// 右
//            NSLog(@"wblive-贴纸：拖拽右方超出%@",NSStringFromCGPoint(point));
//            viewCenter.x = CGRectGetMaxX(self.dragRect) - senderHalfViewWidth;
//        }
        
        [UIView animateWithDuration:.25 animations:^{
            sender.view.center = viewCenter;
        }];
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
        if (self.panFinishedCallback) {
            NSLog(@"wblive-贴纸：拖拽结束%@",NSStringFromCGPoint(viewCenter));
            self.panFinishedCallback(viewCenter);
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}


@end
