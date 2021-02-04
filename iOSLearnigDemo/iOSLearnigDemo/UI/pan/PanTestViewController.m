//
//  PanTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2020/8/1.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "PanTestViewController.h"
#import "WBLPerformerStickerWidget.h"
#import "WBLEditableImageStickerWidget.h"
#import "WBLStickerModuleDefine.h"

@interface PanTestViewController ()
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) WBLEditableImageStickerWidget *stickerView;
@property (nonatomic, strong) WBLPerformerStickerWidget *stickerContainerView;
@end

@implementation PanTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.stickerContainerView];
    [self updateLayoutForOrientationChanged:NO];
    
    [self updateStickerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (WBLPerformerStickerWidget *)stickerContainerView {
    if (!_stickerContainerView) {
         _stickerContainerView = [WBLPerformerStickerWidget new];
    }
    return _stickerContainerView;
}

- (void)updateLayoutForOrientationChanged:(BOOL)isFullScreen {
    CGFloat viewWidth = kRealWidth;
    CGFloat viewHeight = kRealHeight;
    if (isFullScreen) {
        viewWidth = kRealHeight;
        viewHeight = kRealWidth;
    }
    self.stickerContainerView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.stickerContainerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.1];
    self.stickerContainerView.isFullScreen = isFullScreen;
}

#pragma mark - sticker

- (WBLEditableImageStickerWidget *)stickerView {
    if (!_stickerView) {
        _stickerView = [WBLEditableImageStickerWidget new];
        _stickerView.backgroundColor = [UIColor redColor];
        __weak typeof(self) weakSelf = self;
        _stickerView.pinFinishedCallback = ^(CGFloat totalScale) {
//            weakSelf.editModel.multiple = totalScale;
//            [weakSelf delaySendUpdateRequest:nil];
        };
        _stickerView.panStartCallback = ^(CGPoint point) {
            weakSelf.stickerContainerView.deleteView.hidden = NO;
        };
        
        _stickerView.panShouldHighlightDeleteCallback = ^(CGPoint point) {
            [weakSelf.stickerContainerView.deleteView highlightedForPointInside];
        };
        
        _stickerView.panShouldResetHighlightDeleteCallback = ^(CGPoint point) {
            [weakSelf.stickerContainerView.deleteView resetHightlight];
        };
        
        _stickerView.panShouldDeleteCallback = ^(CGPoint point) {
//            [weakSelf cellDeleteWithStickerModel:weakSelf.editModel.stickerModel];
            weakSelf.stickerContainerView.deleteView.hidden = YES;
        };
        
        _stickerView.panFinishedCallback = ^(CGPoint point) {
            weakSelf.stickerContainerView.deleteView.hidden = YES;
//            CGFloat x = point.x / weakSelf.stickerView.correctWidth , y = point.y / weakSelf.stickerView.correctHeight;
//            weakSelf.editModel.x_axis = x;
//            weakSelf.editModel.y_axis = y;
//            [weakSelf delaySendUpdateRequest:nil];
        };
    
        _stickerView.rotateFinishedCallback = ^(CGFloat rotate) {
//            weakSelf.editModel.rotation = rotate;
//            [weakSelf delaySendUpdateRequest:nil];
        };
    }
    return _stickerView;
}

- (void)updateStickerView {
    if (!self.stickerView.superview) {
        [self.stickerContainerView addSubview:self.stickerView];
    }
    self.stickerView.center = CGPointMake(100, 100);
    self.stickerView.bounds = CGRectMake(0, 0, 50, 50);
    self.stickerView.correctWidth = self.stickerContainerView.frame.size.width;
    self.stickerView.correctHeight = self.stickerContainerView.frame.size.height;
    self.stickerView.correctScale = 1.f;
    
    self.stickerView.dragRect = self.stickerContainerView.dragRect; ///赋值，删除区和拖拽区
    self.stickerView.deleteRect = self.stickerContainerView.deleteRect;
    self.stickerView.deleteSureRect = self.stickerContainerView.deleteSureRect;
    self.stickerView.dragAndDeleteRect = self.stickerContainerView.dragAndDeleteRect;
    
//    [self.stickerView updateWithEditModel:self.editModel];
    
}


@end
