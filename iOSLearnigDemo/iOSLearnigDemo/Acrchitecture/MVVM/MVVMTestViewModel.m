//
//  MVVMTestViewModel.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/5.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "MVVMTestViewModel.h"
#import "MVVMTestView.h"
#import "NSObject+FBKVOController.h"
@interface MVVMTestViewModel()
@property (nonatomic, strong) MVVMTestView *testView;
@property (nonatomic, copy) NSString *name;
@end

@implementation MVVMTestViewModel

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        // 视图
        MVVMTestView *testView = [[MVVMTestView alloc] init];
        [viewController.view addSubview:testView];
        self.testView = testView;
        
        // bind
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:@"MVVMTestViewModel"];
        __weak typeof(self) weakSelf = self;
        // 安全kvo，不需要手动移除；block支持
//        [self.KVOController observe:self keyPath:@"name" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//            weakSelf.testView.textLabel.text = @"luo";
//        }];
        
        // 数据
        [self loadRequest:^(id data) {
            weakSelf.name = data[@"text"];
        }];
    }
    return self;
}

- (void)loadRequest:(void(^)(id))sucBlock {
    sleep(1);
    if (sucBlock) {
        sucBlock(@{@"text" : @"luo"});
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (change[NSKeyValueChangeNewKey]) {
        self.testView.textLabel.text = @"luo";
    }
}

- (void)dealloc {
    
}

@end
