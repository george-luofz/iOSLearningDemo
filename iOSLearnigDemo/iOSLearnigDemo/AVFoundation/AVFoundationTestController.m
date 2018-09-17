//
//  AVFoundationTestController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/17.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "AVFoundationTestController.h"
#import "FZVideoSource.h"

@interface AVFoundationTestController () <FZVideoSourceDelegate>
@property (nonatomic, strong) FZVideoSource *videoSource;
@end

@implementation AVFoundationTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.videoSource.preLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.videoSource.preLayer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.videoSource startVideoCapture];
    });
    
}

- (void)videoSource:(FZVideoSource *)source didOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer{
//    NSLog(@"buffer:@",pixelBuffer);
    NSLog(@"%s",__func__);
}

#pragma mark - getters
- (FZVideoSource *)videoSource{
    if (!_videoSource) {
        _videoSource = [[FZVideoSource alloc] init];
        _videoSource.delegate = self;
    }
    return _videoSource;
}
@end
