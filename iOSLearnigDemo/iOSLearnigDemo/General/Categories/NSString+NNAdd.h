//
//  NSString+NNAdd.h
//  NuanNuanDiaryProject
//
//  Created by 罗富中 on 2018/8/5.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NNAdd)

- (NSString *)nn_md5;
- (NSString *)nn_fileMD5;
- (NSString *)nn_encodeString;

- (CGSize)nn_textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)nn_textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)nn_CommentSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size WithLineSpace:(CGFloat)lineSpace;

- (NSString *)clipFitStringForLabel:(CGSize)labelSize font:(UIFont *)font;
- (NSString *)clipFitStringForLabel2:(CGSize)labelSize font:(UIFont *)font;
@end
