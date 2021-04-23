//
//  CTDisplayView.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/4/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    // 1.绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2.坐标转换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 3.创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 4.创建绘制内容
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World!"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, NULL);
    
    // 5.绘制
//    CTFrameDraw(frame, context);
    
    // 5.1绘制CTLine
    CFArrayRef array = CTFrameGetLines(frame);
    CFIndex count = CFArrayGetCount(array);
    for (int i = 0 ;i < count;i++) {
        CTLineRef line = CFArrayGetValueAtIndex(array, i);
//        CTLineDraw(line, context);
        
        // 获取CTRun
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CTRunRef run = CFArrayGetValueAtIndex(runs, 0);
        CTRunGetAttributes(run);
//        CFRelease(line);
    }
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
