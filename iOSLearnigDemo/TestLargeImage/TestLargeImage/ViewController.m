//
//  ViewController.m
//  TestLargeImage
//
//  Created by 罗富中 on 2020/5/25.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"1:%.1lf",16545 / 10000.0);
    NSLog(@"2:%.1lf",floor(16545 / 10000.0));
    NSLog(@"3:%.1lf",floor((16545 * 10 / 10000.0) / 10));
}


@end
