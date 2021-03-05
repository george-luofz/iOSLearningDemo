//
//  MVVMTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MVVMTestViewController.h"
#import "MVVMTestViewModel.h"

@interface MVVMTestViewController ()
@property (nonatomic, strong) MVVMTestViewModel *viewModel;
@end

@implementation MVVMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[MVVMTestViewModel alloc] initWithViewController:self];
}

@end
