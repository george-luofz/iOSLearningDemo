//
//  HtmlToPdfViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/10.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "HtmlToPdfViewController.h"
#import "BNHtmlPdfKit.h"

#import <PDFKit/PDFKit.h>

@interface HtmlToPdfViewController ()
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic) BNHtmlPdfKit *pdfKit;
@end

@implementation HtmlToPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"htmlToPdf test";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:webView];
    self.webView = webView;
    
    [self _test];
}

- (void)_test{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"test.pdf"];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
    
    __weak typeof(self) weakSelf = self;
    BNHtmlPdfKit *pdfKit = [BNHtmlPdfKit saveUrlAsPdf:[NSURL fileURLWithPath:htmlPath] toFile:filePath pageSize:BNPageSizeA4 success:^(NSString *pdfFileName) {
       NSLog(@"Done with name: %@",pdfFileName);
       [weakSelf _showFinishedPdf:pdfFileName];
    } failure:^(NSError *err) {
        NSLog(@"Failure with error: %@",err);
    }];
    self.pdfKit = pdfKit;
}

- (void)_showFinishedPdf:(NSString *)pdfPath{
    if(pdfPath == nil) return;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:pdfPath];
        if(data){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:pdfPath].URLByDeletingLastPathComponent];
            });
        }
    });
}
@end
