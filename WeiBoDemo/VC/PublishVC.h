//
//  PublishVC.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-25.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestModel.h"
#import "MBProgressHUD.h"

@interface PublishVC : UIViewController<RequestDeleage, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    MBProgressHUD * hud;
    __weak UIImageView * _photoImage;
    __weak UIButton * _addPhotoButton;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)onBackButtonClick:(id)sender;
- (IBAction)onPublishButtonClick:(id)sender;
- (IBAction)onPhotoButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;

@end
