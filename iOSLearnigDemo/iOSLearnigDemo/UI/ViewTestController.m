//
//  ViewTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/3.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ViewTestController.h"
#import "ParentView.h"
#import "childView.h"

@interface ViewTestController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ParentView *pView = [[ParentView alloc] initWithFrame:CGRectMake(0, 64, 100, 50)];
    [self.view addSubview:pView];
    pView.backgroundColor = [UIColor blueColor];
    
    childView *cView = [[childView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    cView.backgroundColor = [UIColor grayColor];
    [pView addSubview:cView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 140, 30, 30);
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [btn addGestureRecognizer:tap];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"%s",__func__);
    [super touchesCancelled:touches withEvent:event];
}
- (void)tap{
    NSLog(@"%s",__func__);
}

- (void)btnClick{
    NSLog(@"%s",__func__);
}

@end
