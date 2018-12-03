//
//  CALayerTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/12/3.
//  Copyright © 2018 George_luofz. All rights reserved.
//

#import "CALayerTestViewController.h"

@interface CALayerTestViewController ()

@end

@implementation CALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = CGRectMake(100, 100, 100, 100);
    shadowLayer.backgroundColor = [UIColor blueColor].CGColor;
    shadowLayer.shadowOpacity = .5;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(5, 5); //右5，下5
    shadowLayer.shadowRadius = 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-25, -25, 150, 150) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(75, 75)]; //rect以shadowLayer得左上角为原点
    shadowLayer.shadowPath = path.CGPath; //阴影路径
    [self.view.layer addSublayer:shadowLayer];
}



@end
