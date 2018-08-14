//
//  NSString+NNAdd.m
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "NSString+NNAdd.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (NNAdd)

- (NSString *)nn_md5 {
    if (!self || self.length == 0) {
        return nil;
    }
    return [[self dataUsingEncoding:NSUTF8StringEncoding] nn_md5];
}

- (NSString*)nn_fileMD5
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:self];
    if( handle== nil ) return @""; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength:256];
        //        CHUNK_SIZE
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    [handle closeFile];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

- (NSString *)nn_encodeString {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}

- (CGSize)nn_textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self nn_textSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}


- (CGSize)nn_textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //        option = NSStringDrawingUsesLineFragmentOrigin;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        //        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        //        paraStyle.lineSpacing = UILABEL_LINE_SPACE;
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

- (CGSize)nn_CommentSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size WithLineSpace:(CGFloat)lineSpace {
    CGSize textSize = CGSizeZero;
    NSMutableParagraphStyle *paraStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paraStyle.lineSpacing = lineSpace;
    NSDictionary *attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle};
    NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize rect = [self boundingRectWithSize:size
                                     options:option
                                  attributes:attributes
                                     context:nil].size;
    
    textSize = CGSizeMake(ceil(rect.width), ceil(rect.height));
    
    return textSize;
}

@end
