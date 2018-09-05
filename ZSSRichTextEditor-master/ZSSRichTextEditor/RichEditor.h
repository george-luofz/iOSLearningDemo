//
//  RichEditor.h
//  ZSSRichTextEditor
//
//  Created by 罗富中 on 2018/9/5.
//  Copyright © 2018年 Zed Said Studio. All rights reserved.
//
// 1. 指定大小
// 2. 区域内包含这么多功能

#import <UIKit/UIKit.h>
#import "CustomWebView.h"

@interface RichEditor : UIView
@property (nonatomic) UIWebView *editorView;
@property (nonatomic, getter=isEditing) BOOL editing;
@property (nonatomic) BOOL shouldShowKeyboard;

@property (nonatomic) UIEdgeInsets webViewEdgeInset;

/// 原始内容
@property (nonatomic) NSString *originalContent;
/// 占位字符
@property (nonatomic) NSString *placeHolder;

/// 背景图
- (void)updateBackgoundImage:(UIImage *)image;

/// 获取格式化html
- (NSString *)getContentHTML;
/// 获取完整html
- (NSString *)getContent;

/// 键盘聚焦
- (void)focusTextEditor;
/// 移除键盘焦点
- (void)blurTextEditor ;
#pragma mark - edit
/// 颜色
- (void)setTextColor:(NSString *)textColor;

/// 更新字体
- (void)setFont:(NSString *)fontName;
/// 字体大小
- (void)setFontSize:(CGFloat)fontSize;
/// 字体
- (void)setBold;
- (void)setItalic;

/// 对齐
- (void)alignLeft;
- (void)alignCenter;
- (void)alignRight;

/// 项目符号
/// .....
- (void)setUnorderedList;
/// 1.2.3.4
- (void)setOrderedList;

/// 插入图片
- (void)insertImage:(NSString *)base64ImageString;
@end
