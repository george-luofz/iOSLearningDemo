//
//  RichEditorTestViewController.m
//  ZSSRichTextEditor
//
//  Created by 罗富中 on 2018/9/5.
//  Copyright © 2018年 Zed Said Studio. All rights reserved.
//

#import "RichEditorTestViewController.h"
#import "RichEditor.h"

@interface RichEditorTestViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic) RichEditor *richEditor;
@property (nonatomic) UIImagePickerController *imagePicker;
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
    [self setUpImagePicker];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"导出" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"插入图片" style:UIBarButtonItemStylePlain target:self action:@selector(importHTML)];
    self.navigationItem.rightBarButtonItems = @[item2, item1];
}

#pragma mark - View Will Appear Section
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //    [self.view resignFirstResponder];
    //Add observers for keyboard showing or hiding notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - View Will Disappear Section
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //    [self.view endEditing:YES];
    //Remove observers for keyboard showing or hiding notifications
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}



- (void)exportHTML{
    NSLog(@"%@",[self.richEditor getContent]);
}

- (void)importHTML{

    [self showPicker];

}

- (void)showPicker{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - Image Picker Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //Dismiss the Image Picker
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info{
    
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage]?:info[UIImagePickerControllerOriginalImage];
    
    //Scale the image
    CGSize targetSize = CGSizeMake(selectedImage.size.width * .5, selectedImage.size.height * .5);
    UIGraphicsBeginImageContext(targetSize);
    [selectedImage drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Compress the image, as it is going to be encoded rather than linked
    NSData *scaledImageData = UIImageJPEGRepresentation(scaledImage, .8);
    
    //Encode the image data as a base64 string
    NSString *imageBase64String = [scaledImageData base64EncodedStringWithOptions:0];
    
    //Decide if we have to insert or update
//    if (!self.imageBase64String) {
//        [self insertImageBase64String:imageBase64String alt:self.selectedImageAlt];
//    } else {
//        [self updateImageBase64String:imageBase64String alt:self.selectedImageAlt];
//    }
    
//    self.imageBase64String = imageBase64String;
    [self.richEditor insertImage:imageBase64String alt:nil];
    //Dismiss the Image Picker
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpImagePicker {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.allowsEditing = YES;
//    self.selectedImageScale = kDefaultScale; //by default scale to half the size
    
}


- (RichEditor *)richEditor{
    if (!_richEditor) {
        _richEditor = [[RichEditor alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    }
    return _richEditor;
}

@end
