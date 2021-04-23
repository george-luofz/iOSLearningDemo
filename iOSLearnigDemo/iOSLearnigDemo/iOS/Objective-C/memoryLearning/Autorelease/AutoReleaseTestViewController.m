//
//  AutoReleaseTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/9.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "AutoReleaseTestViewController.h"
#import "AutoReleaseObj.h"

extern void _objc_autoreleasePoolPrint(void);

@interface AutoReleaseTestViewController ()

@end

@implementation AutoReleaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__func__);
    
    AutoReleaseObj *obj = [[[AutoReleaseObj alloc] init] autorelease];
    
    @autoreleasepool {
        AutoReleaseObj *obj = [[[AutoReleaseObj alloc] init] autorelease];
        
        @autoreleasepool {
            AutoReleaseObj *obj1 = [[[AutoReleaseObj alloc] init] autorelease];
            
            @autoreleasepool {
                AutoReleaseObj *obj2 = [[[AutoReleaseObj alloc] init] autorelease];
            }
            NSLog(@"pool2 pop");
            _objc_autoreleasePoolPrint();
        }
        NSLog(@"pool1 pop");
        _objc_autoreleasePoolPrint();
    }
    NSLog(@"pool0 pop");
    _objc_autoreleasePoolPrint();
    
    
//    NSLog(@"%@",[NSRunLoop mainRunLoop]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}


@end
