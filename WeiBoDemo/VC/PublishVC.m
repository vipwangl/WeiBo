//
//  PublishVC.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-25.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "PublishVC.h"

@interface PublishVC ()

@end

@implementation PublishVC

@synthesize textView;
@synthesize addPhotoButton = _addPhotoButton;
@synthesize photoImage = _photoImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPublishButtonClick:(id)sender {
    [hud show:YES];
    RequestModel *request = [[RequestModel alloc]init];
    request.deleage = self;
    if(_photoImage.image)
    {
        [request publishMessage:textView.text withPhoto:_photoImage.image];
    }
    else
    {
        [request publishMessage:textView.text];
    }
}

- (IBAction)onPhotoButtonClick:(id)sender {
    if(!_addPhotoButton.selected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"插入图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"系统相册",@"拍摄", nil];
        alert.delegate = self;
        [alert show];
    }
    else
    {
        _photoImage.image = nil;
        _addPhotoButton.selected = !_addPhotoButton.selected;
    }
    
}

-(void)didPublishMessageWithState:(kState)state
{
    if(state == kStateSeccess)
    {
        NSLog(@"发表成功");
        [hud hide:YES];
        [hud removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"发表失败");
        hud.labelText = @"发表失败";
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(.5);
        }];
        hud.labelText = nil;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self getPhotoFromLibrary];
    }
    else if(buttonIndex == 2)
    {
        [self getPhotoFromCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _photoImage.image = image;
    _addPhotoButton.selected = !_addPhotoButton.selected;
}



- (void)getPhotoFromLibrary
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)getPhotoFromCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"不支持拍照功能"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
@end
