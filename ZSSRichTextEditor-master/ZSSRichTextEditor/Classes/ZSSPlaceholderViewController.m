//
//  ZSSPlaceholderViewController.m
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 8/14/14.
//  Copyright (c) 2014 Zed Said Studio. All rights reserved.
//

#import "ZSSPlaceholderViewController.h"
#import <CoreText/CoreText.h>

@interface ZSSPlaceholderViewController ()
@property (nonatomic,strong) UILabel *label;
@end

@implementation ZSSPlaceholderViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Placeholder";
    
    self.placeholder = @"Please tap to start editing";
    
    self.alwaysShowToolbar = YES;
    
//    NSString *html = @"<p>Example showing just a few toolbar buttons.</p>";
//    [self setHTML:html];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"redpack_invite_bg"].CGImage;
    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"hello world";
//    label.backgroundColor = [UIColor redColor];
//    label.textColor = [UIColor blackColor];
//    label.frame = CGRectMake(0, 150, 200, 30);
//    label.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:label];
//    self.label = label;
////
////    [self _test];
//    UIFont *font = [UIFont fontWithName:@"Courier New, Courier, monospace" size:15];
//    label.font = font;
    
    NSArray *familyNames = [UIFont familyNames];
    for (int i = 0 ;i < familyNames.count;i++){
        NSLog(@"familyName :%@ \n",familyNames[i]);
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"after invoked");
//        [self setSelectWithFontName:@"Courier New, Courier, monospace"];
//    });
//    [self _test];
}

// 测试，下载字体到沙盒，使用webView加载字体

- (void)_test{
    [self _downloadFont];
}

- (void)_downloadFont{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fonts.gstatic.com/s/kiranghaerang/v4/E21-_dn_gvvIjhYON1lpIU4-bcqv.ttf"]];
    //http://fonts.gstatic.com/s/kiranghaerang/v4/E21-_dn_gvvIjhYON1lpIU4-bcqv.ttf
    //http://fonts.gstatic.com/s/titanone/v5/mFTzWbsGxbbS_J5cQcjykw.ttf //TiTan One
    //http://fonts.gstatic.com/s/abeezee/v11/esDR31xSG-6AGleN6tI.ttf
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"download error");
            return ;
        }
        [weakSelf _loadFontWithUrl:location];
    }];
    [downloadTask resume];
}

- (void)_loadFontWithUrl:(NSURL *)url{
    if(url == nil) return;
    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data){
            CFErrorRef error;
            CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef) data);
            CGFontRef font = CGFontCreateWithDataProvider(provider);
            
            if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                NSLog(@"Failed to load font: %@", errorDescription);
                CFRelease(errorDescription);
                return;
            }
            NSLog(@"font regeister success");
            NSLog(@"font name:%@,name2:%@",CGFontCopyPostScriptName(font),CGFontCopyFullName(font));
            UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:(__bridge NSString *)CGFontCopyPostScriptName(font) size:15];
            UIFont *fontObj = [UIFont fontWithDescriptor:fontDescriptor size:fontDescriptor.pointSize];
            if(fontObj){
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 系统label使用
//                    weakSelf.label.font = fontObj;
                    // webView 使用
                    [weakSelf setSelectWithFontName:(__bridge NSString *)CGFontCopyPostScriptName(font)];
                });
            }
            
        }
//    });
}
@end
