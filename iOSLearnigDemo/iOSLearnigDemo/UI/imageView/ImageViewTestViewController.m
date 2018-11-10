//
//  ImageViewTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/10/30.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ImageViewTestViewController.h"

@interface ImageViewTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *nomalImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fullscreenImgView;

@end

@implementation ImageViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *img = [UIImage imageNamed:@"theImage"];
    // 四个数值对应图片中距离上、左、下、右边界的不拉伸部分的范围宽度
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(35, 35, 35, 35) resizingMode:UIImageResizingModeStretch];

    self.nomalImgView.image = [UIImage imageNamed:@"YXMyAwardTopBackground1"];
    self.fullscreenImgView.image = [UIImage imageNamed:@"YXMyAwardTopBackground1"];
//    self.nomalImgView.image = [UIImage imageNamed:@"11"];
//    self.fullscreenImgView.image = [UIImage imageNamed:@"11"];
    
    
}


@end
