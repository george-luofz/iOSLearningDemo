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

//    self.nomalImgView.image = [UIImage imageNamed:@"YXMyAwardTopBackground1"];
//    self.fullscreenImgView.image = [UIImage imageNamed:@"YXMyAwardTopBackground1"];
//    self.nomalImgView.image = [UIImage imageNamed:@"11"];
//    self.fullscreenImgView.image = [UIImage imageNamed:@"11"];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(30, 300, 50, 20);
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIImage *originalImg = [UIImage imageNamed:@"123"];
    // resize
    UIImage *scaleImg = [originalImg resizableImageWithCapInsets:UIEdgeInsetsMake(30, 12, 30, 30) resizingMode:UIImageResizingModeStretch];
//    if (scaleImg){
//        imageView.image = scaleImg;
//    }
    imageView.image = [self scaleImageHorizontalAndRedrawToSize:imageView.frame.size image:originalImg];
    
    
    // blend
//    self.ivStar.image = [[UIImage imageNamed:@"image"] imageWithGradientTintColor:[UIColor blueColor]];
}

- (UIImage *)scaleImageHorizontalAndRedrawToSize:(CGSize)size image:(UIImage *)image{
    UIImage *scaleImg = [image resizableImageWithCapInsets:UIEdgeInsetsMake(29, 12, 30, 30) resizingMode:UIImageResizingModeStretch];
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(CGSizeMake(size.width * scale , size.height * scale));
    [scaleImg drawInRect:CGRectMake(0, 0, size.width * scale , size.height * scale)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // blendMode 参考：
    //https://onevcat.com/2013/04/using-blending-in-ios/
    return resultImg;
}

@end
