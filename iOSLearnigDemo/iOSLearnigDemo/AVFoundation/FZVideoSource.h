//
//  FZVideoSource.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/9/17.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class FZVideoSource;
@protocol FZVideoSourceDelegate <NSObject>

- (void)videoSource:(FZVideoSource *)source didOutputSampleBuffer:(CVPixelBufferRef)pixelBuffer;

@end

@interface FZVideoSource : NSObject
@property (nonatomic, weak) id<FZVideoSourceDelegate> delegate;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preLayer;

- (void)startVideoCapture;
- (void)stopVideoCapture;
@end
