//
//  RichEditorTestViewController.m
//  ZSSRichTextEditor
//
//  Created by 罗富中 on 2018/9/5.
//  Copyright © 2018年 Zed Said Studio. All rights reserved.
//

#import "RichEditorTestViewController.h"
#import "RichEditor.h"

@interface RichEditorTestViewController ()
@property(nonatomic) RichEditor *richEditor;
@end

@implementation RichEditorTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.richEditor];
    
//    [self.richEditor updateBackgoundImage:[UIImage imageNamed:@"redpack_invite_bg"]];
    [self.richEditor setPlaceHolder:@"记录美好生活..."];
//    self.richEditor.originalContent = @"apppppppppppppp";
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"导出" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStylePlain target:self action:@selector(importHTML)];
    self.navigationItem.rightBarButtonItems = @[item2, item1];
}


- (void)exportHTML{
    NSLog(@"%@",[self.richEditor getContent]);
}

- (void)importHTML{
    
}

- (RichEditor *)richEditor{
    if (!_richEditor) {
        _richEditor = [[RichEditor alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    }
    return _richEditor;
}

@end
