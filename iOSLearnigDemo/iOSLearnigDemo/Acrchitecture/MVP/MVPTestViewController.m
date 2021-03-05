//
//  MVPTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//  controller瘦身

#import "MVPTestViewController.h"
#import "MVPTestPresenter.h"

@interface MVPTestViewController ()
@property (nonatomic, strong) MVPTestPresenter *presenter;
//@property (nonatomic, strong) MVPTestPresenter1 *presenter1;
//@property (nonatomic, strong) MVPTestPresenter2 *presenter2;
@end

@implementation MVPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presenter = [[MVPTestPresenter alloc] initWithViewController:self];
}

@end
