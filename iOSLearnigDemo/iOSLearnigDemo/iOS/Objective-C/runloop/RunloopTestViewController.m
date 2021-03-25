//
//  RunloopTestViewController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/20.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "RunloopTestViewController.h"
#import "TestView.h"

@interface RunloopTestViewController ()

@end

@implementation RunloopTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testBlock];
//
//    [self addRunloopObserver];
//
//    [self testPerformSelect];
//    [self testGCDAfter];
//
//    [self testTimer];
//    [self testDisplayLink];
//
//    [self testTapGesture];
    
    [self testViewLayout];
    
    [self testRunloop];
}

#pragma mark - block

//__CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__
- (void)testBlock {
    CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopCommonModes, ^{
        NSLog(@"%s",__func__);
    });
}

#pragma mark - observer

- (void)addRunloopObserver {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, runloopCallback, nil);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
}

// __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__
void runloopCallback(CFRunLoopObserverRef observer,  CFRunLoopActivity activity, void *info) {
    NSLog(@"runloop observer :%lu \n",activity);
}

#pragma mark - perform selector

- (void)testPerformSelect {
    [self performSelector:@selector(performTest) withObject:nil afterDelay:1.f];
}

// __CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__
- (void)performTest {
    NSLog(@"%s",__func__);
}

#pragma mark - gcd after

// __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__
- (void)testGCDAfter {
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        NSLog(@"%s",__func__);
    });
}

#pragma mark - timer
    
//__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__
// CFRunloopTimer 记录了nextFireDate，callout=action
// 有UIScrollView滚动时，会注册一个timer，callout=_hideScrollIndicators
- (void)testTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%s",__FUNCTION__);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - display link
    
- (void)testDisplayLink {
    __weak typeof(self) weakSelf = self;
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(displayLink:)];
    [dl addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

// __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__
- (void)displayLink:(CADisplayLink *)dl {
    NSLog(@"%s",__func__);
}

#pragma mark - event
/// 1.???自己探究没发现UIApplicationEventQueue???
/// 2.GSEventReceiverMode没有注册__eventQueueSourceCallback，是不是不能响应事件

// source0事件
// 1.IOkit捕获到事件，包装成IOEvent对象，先由springBoard(桌面App)接收，基于source1(mach_msg)接收
// 2.springBoard基于mach_msg将事件转发给指定应用，基于应用注册的source1，触发__IOHIDEventSystemClientQueueCallback
// 3.IOEventCallback内部调用UIApplicationEventQueue()进行事件分发
// 4.UIApplicationEventQueue将事件包装成UIEvent，触发source0回调

//__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
}

- (void)testTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

// __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__
- (void)tap {
    NSLog(@"%s",__func__);
}

#pragma mark - runloop
/*
 UITrackingRunLoopMode,
 GSEventReceiveRunLoopMode,
 kCFRunLoopDefaultMode,
 kCFRunLoopCommonModes
 */
- (void)testRunloop {
    CFRunLoopRef ref = CFRunLoopGetCurrent();
    NSLog(@"runloop is: \n %@",ref);
    
    CFArrayRef arr = CFRunLoopCopyAllModes(ref);
    NSLog(@"all modes: \n %@",arr);
    
}

// _ZN2CAL14timer_callbackEP16__CFRunLoopTimerPv

#pragma mark - view layout

- (void)testViewLayout {
    TestView *view = [TestView new];
    view.frame = CGRectMake(0, 0, 100, 100);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    view.frame = CGRectMake(0, 100, 100, 100);
    view.backgroundColor = [UIColor yellowColor];
    view.layer.contents = [UIImage new];
}

@end
