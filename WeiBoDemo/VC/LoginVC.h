//
//  ViewController.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-21.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestModel.h"
#import "MBProgressHUD.h"

@interface LoginVC : UIViewController<UIWebViewDelegate, RequestDeleage>
{
    UIWebView * _webView;
    MBProgressHUD * hub;
}

@property(nonatomic, strong)UIWebView * webView;

@end
