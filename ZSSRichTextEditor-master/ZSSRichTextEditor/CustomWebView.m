//
//  CustomWebView.m
//  ZSSRichTextEditor
//
//  Created by 罗富中 on 2018/8/10.
//  Copyright © 2018年 Zed Said Studio. All rights reserved.
//

#import "CustomWebView.h"

@implementation CustomWebView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 全代码时入口
        [self addMenu];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // xib时入口
    [self addMenu];
}

- (void)addMenu
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyT:)];
    
//    UIMenuItem *menuItemNote = [[UIMenuItem alloc] initWithTitle:@"笔记" action:@selector(noteT:)];
    
//    UIMenuItem *menuItemSearch = [[UIMenuItem alloc] initWithTitle:@"搜索" action:@selector(searchT:)];
//
//    UIMenuItem *menuItemShare = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(shareT:)];
    
    NSArray *mArray = [NSArray arrayWithObjects:menuItemCopy,nil];
    [menuController setMenuItems:mArray];
    
    [menuController update];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(copyT:) || action == @selector(noteT:) || action == @selector(searchT:) || action == @selector(shareT:))
    {
        return YES;
    }
    
    return NO;
}

-(void)copyT:(id)sender
{
    // 获取文本
    NSString* copytext = [self stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    NSLog(@"复制：%@",copytext);
}

-(void)noteT:(id)sender
{
    NSLog(@"笔记");
}

-(void)searchT:(id)sender
{
    NSLog(@"搜索");
}

-(void)shareT:(id)sender
{
    NSLog(@"分享");
}

@end
