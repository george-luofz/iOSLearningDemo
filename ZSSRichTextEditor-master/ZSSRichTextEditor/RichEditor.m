//
//  RichEditor.m
//  ZSSRichTextEditor
//
//  Created by 罗富中 on 2018/9/5.
//  Copyright © 2018年 Zed Said Studio. All rights reserved.
//

#import "RichEditor.h"
#import <JavaScriptCore/JavaScriptCore.h>

#define isCorrectString(string)  ([string isKindOfClass:[NSString class]] && string.length) ? YES : NO
@interface RichEditor() <UIWebViewDelegate>
@property (nonatomic) NSURL *baseURL;
@property (nonatomic) BOOL receiveEditorDidChangeEvents;
@property (nonatomic) NSString *internalHTML;
@end
@implementation RichEditor

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _setupViews];
    }
    return self;
}

- (void)updateBackgoundImage:(UIImage *)image{
    if (!image) return;
    self.layer.contents = (__bridge id)image.CGImage;;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark - subviews
- (void)_setupViews{
    [self addSubview:self.editorView];
    [self _loadHtmlSources];
}


#pragma mark - html
- (void)_loadHtmlSources{
    NSString *html = nil;
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html"];
    html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];

    // load jQuery
    NSString *jqueryPath = [[NSBundle mainBundle] pathForResource:@"jQuery" ofType:@"js"];
    NSString *jqueryScript = [NSString stringWithContentsOfFile:jqueryPath encoding:NSUTF8StringEncoding error:nil];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- jQuery -->" withString:jqueryScript];
    // load JSBeauty
    NSString *JSBeautyPath = [[NSBundle mainBundle] pathForResource:@"JSBeautifier" ofType:@"js"];
    NSString *JSBeautyScript = [NSString stringWithContentsOfFile:JSBeautyPath encoding:NSUTF8StringEncoding error:nil];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- jsbeautifier -->" withString:JSBeautyScript];
    // load ZSSRichEditor
    NSString *ZSSRichEditorPath = [[NSBundle mainBundle] pathForResource:@"ZSSRichTextEditor" ofType:@"js"];
    NSString *ZSSRichEditorScript = [NSString stringWithContentsOfFile:ZSSRichEditorPath encoding:NSUTF8StringEncoding error:nil];
    html = [html stringByReplacingOccurrencesOfString:@"<!--editor-->" withString:ZSSRichEditorScript];
    
    [self.editorView loadHTMLString:html baseURL:self.baseURL];
}

#pragma mark - editorView API

- (void)setupPlaceHolder{
    if (!isCorrectString(self.placeHolder)) return;
    NSString *js = [NSString stringWithFormat:@"zss_editor.setPlaceholder(\"%@\");", self.placeHolder];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

- (NSString *)getContentHTML {
    NSString *html = [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.getHTML();"];
    html = [self removeQuotesFromHTML:html];
    html = [self tidyHTML:html];
    return html;
}

- (NSString *)getContent{
    return [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.getText();"];
}

- (void)updateHTML {
    
    NSString *html = self.internalHTML;
    NSString *cleanedHTML = [self removeQuotesFromHTML:html];
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.setHTML(\"%@\");", cleanedHTML];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (void)insertHTML:(NSString *)html{
    if (!isCorrectString(html)) return;
    NSString *cleanedHTML = [self removeQuotesFromHTML:html];
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertHTML(\"%@\");", cleanedHTML];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}
/// 键盘
- (void)focusTextEditor {
    NSString *js = [NSString stringWithFormat:@"zss_editor.focusEditor();"];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

- (void)blurTextEditor {
    NSString *js = [NSString stringWithFormat:@"zss_editor.blurEditor();"];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}
#pragma mark - edit
- (void)setFont:(NSString *)fontName{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.setFontFamily(\"%@\");", fontName];
    
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setFontSize:(CGFloat)fontSize{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.setFontSize(\"%.0lfpx\");", fontSize];
    
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setTextColor:(NSString *)textColor{
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    [self.editorView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"zss_editor.setTextColor(\"%@\");", textColor]];
}

- (void)setBold {
    NSString *trigger = @"zss_editor.setBold();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setItalic {
    NSString *trigger = @"zss_editor.setItalic();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignLeft {
    NSString *trigger = @"zss_editor.setJustifyLeft();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignCenter {
    NSString *trigger = @"zss_editor.setJustifyCenter();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignRight {
    NSString *trigger = @"zss_editor.setJustifyRight();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setUnorderedList {
    NSString *trigger = @"zss_editor.setUnorderedList();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setOrderedList {
    NSString *trigger = @"zss_editor.setOrderedList();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = [[request URL] absoluteString];
    //NSLog(@"web request");
    //NSLog(@"%@", urlString);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    } else if ([urlString rangeOfString:@"callback://0/"].location != NSNotFound) {
        
        // We recieved the callback
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"callback://0/" withString:@""];
//        [self updateToolBarWithButtonName:className];
        
    } else if ([urlString rangeOfString:@"debug://"].location != NSNotFound) {
        
        NSLog(@"Debug Found");
        
        // We recieved the callback
        NSString *debug = [urlString stringByReplacingOccurrencesOfString:@"debug://" withString:@""];
        debug = [debug stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
        NSLog(@"%@", debug);
        
    } else if ([urlString rangeOfString:@"scroll://"].location != NSNotFound) {
        
        NSInteger position = [[urlString stringByReplacingOccurrencesOfString:@"scroll://" withString:@""] integerValue];
        [self editorDidScrollWithPosition:position];
        
    }

    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (!self.internalHTML) {
        self.internalHTML = @"";
    }
    
    if(self.placeHolder) {
        [self setupPlaceHolder];
    }
    
    [self updateHTML];
    
//    if (self.customCSS) {
//        [self updateCSS];
//    }
    
    if (self.shouldShowKeyboard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self focusTextEditor];
        });
    }
    __weak typeof(self) weakSelf = self;
    JSContext *ctx = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    ctx[@"contentUpdateCallback"] = ^(JSValue *msg) {
        __strong typeof(self) strongSelf = weakSelf;
        if (_receiveEditorDidChangeEvents) {

            [strongSelf editorDidChangeWithText:[strongSelf getContent] andHTML:[strongSelf getContentHTML]];

        }
        [strongSelf checkForMentionOrHashtagInText:[strongSelf getContent]];
    };
    [ctx evaluateScript:@"document.getElementById('zss_editor_content').addEventListener('input', contentUpdateCallback, false);"];
    
}

#pragma mark - Mention & Hashtag Support Section

- (void)checkForMentionOrHashtagInText:(NSString *)text {
    
    if ([text containsString:@" "] && [text length] > 0) {
        
        NSString *lastWord = nil;
        NSString *matchedWord = nil;
        BOOL ContainsHashtag = NO;
        BOOL ContainsMention = NO;
        
        NSRange range = [text rangeOfString:@" " options:NSBackwardsSearch];
        lastWord = [text substringFromIndex:range.location];
        
        if (lastWord != nil) {
            
            //Check if last word typed starts with a #
            NSRegularExpression *hashtagRegex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:nil];
            NSArray *hashtagMatches = [hashtagRegex matchesInString:lastWord options:0 range:NSMakeRange(0, lastWord.length)];
            
            for (NSTextCheckingResult *match in hashtagMatches) {
                
                NSRange wordRange = [match rangeAtIndex:1];
                NSString *word = [lastWord substringWithRange:wordRange];
                matchedWord = word;
                ContainsHashtag = YES;
                
            }
            
            if (!ContainsHashtag) {
                
                //Check if last word typed starts with a @
                NSRegularExpression *mentionRegex = [NSRegularExpression regularExpressionWithPattern:@"@(\\w+)" options:0 error:nil];
                NSArray *mentionMatches = [mentionRegex matchesInString:lastWord options:0 range:NSMakeRange(0, lastWord.length)];
                
                for (NSTextCheckingResult *match in mentionMatches) {
                    
                    NSRange wordRange = [match rangeAtIndex:1];
                    NSString *word = [lastWord substringWithRange:wordRange];
                    matchedWord = word;
                    ContainsMention = YES;
                    
                }
                
            }
            
        }
        
        if (ContainsHashtag) {
            
            [self hashtagRecognizedWithWord:matchedWord];
            
        }
        
        if (ContainsMention) {
            
            [self mentionRecognizedWithWord:matchedWord];
            
        }
        
    }
    
}

#pragma mark - Callbacks

//Blank implementation
- (void)editorDidScrollWithPosition:(NSInteger)position {}

//Blank implementation
- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html  {}

//Blank implementation
- (void)hashtagRecognizedWithWord:(NSString *)word {}

//Blank implementation
- (void)mentionRecognizedWithWord:(NSString *)word {}

#pragma mark - utities
- (NSString *)removeQuotesFromHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    html = [html stringByReplacingOccurrencesOfString:@"“" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"”" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"\r"  withString:@"\\r"];
    html = [html stringByReplacingOccurrencesOfString:@"\n"  withString:@"\\n"];
    return html;
}

- (NSString *)tidyHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"<br />"];
    html = [html stringByReplacingOccurrencesOfString:@"<hr>" withString:@"<hr />"];
//    if (self.formatHTML) {
        html = [self.editorView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"style_html(\"%@\");", html]];
//    }
    return html;
}

#pragma mark - getters

- (UIWebView *)editorView{
    if (!_editorView) {
        _editorView = [[CustomWebView alloc] initWithFrame:self.bounds];
        _editorView.delegate = self;
        _editorView.keyboardDisplayRequiresUserAction = NO;
        _editorView.scalesPageToFit = YES;
        _editorView.dataDetectorTypes = UIDataDetectorTypeNone;
        _editorView.scrollView.bounces = NO;
        _editorView.backgroundColor = [UIColor clearColor];
        _editorView.opaque = NO;
        _editorView.hidesInputAccessoryView = YES;
    }
    return _editorView;
}

- (void)setOriginalContent:(NSString *)originalContent{
    _originalContent = originalContent;
    _internalHTML = [originalContent copy];
}
@end
