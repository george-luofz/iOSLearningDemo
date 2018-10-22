//
//  FZVideoSource.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/17.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "FZVideoSource.h"
@interface FZVideoSource() <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession  *session;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

@property (nonatomic, strong) dispatch_queue_t  videoQueue;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;


@end
@implementation FZVideoSource

- (instancetype)init{
    if (self = [super init]) {
        [self setupVideoCapture];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseCameraCapture) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeCameraCapture) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)setupVideoCapture{
    self.session;
}

- (void)startVideoCapture{
    [self.session startRunning];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES]; //阻止锁屏
}

- (void)stopVideoCapture{
    [self.session stopRunning];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)pauseCameraCapture{
    [self.session stopRunning];
}

- (void)resumeCameraCapture{
    [self.session startRunning];
}

#pragma mark - <AVBufferDelegate>

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CVPixelBufferRef pixelBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    if ([self.delegate respondsToSelector:@selector(videoSource:didOutputSampleBuffer:)]){
        [self.delegate videoSource:self didOutputSampleBuffer:pixelBufferRef];
    }
}

#pragma mark - getters
- (AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        // 设置摄像头分辨率
        if ([_session canSetSessionPreset:AVCaptureSessionPreset640x480]){
            _session.sessionPreset = AVCaptureSessionPreset640x480;
        }
        
        // 切换前置摄像头
        for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if (device.position == AVCaptureDevicePositionFront){
                self.videoDevice = device;
                break;
            }
        }
//        self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // 自动变焦
        if ([_videoDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
            if([self.videoDevice lockForConfiguration:nil]){
                _videoDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            }
        }
        
        // 输入
        self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.videoDevice error:nil];
        if ([self.session canAddInput:self.videoInput]){
            [self.session addInput:self.videoInput];
        }
        
        // 输出
        self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
//        NSDictionary *settings = @{kCVPixelBufferPixelFormatTypeKey: [NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange]};
        NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], kCVPixelBufferPixelFormatTypeKey, nil];
        self.videoOutput.videoSettings = settings;
        self.videoOutput.alwaysDiscardsLateVideoFrames = YES;
        
        // 设置代理回调队列
        _videoQueue = dispatch_queue_create("videoQueue", DISPATCH_QUEUE_SERIAL);
        [self.videoOutput setSampleBufferDelegate:self queue:_videoQueue];
        if ([self.session canAddOutput:_videoOutput]){
            [self.session addOutput:_videoOutput];
        }
        
        AVCaptureConnection *videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
        self.videoConnection = videoConnection;
        // 设置图像的输出方向
        self.videoConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
        
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)preLayer{
    if (!_preLayer) {
        _preLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _preLayer;
}
@end
