//
//  ViewController.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-21.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "LoginVC.h"
#import "Global.h"
#import "RequestModel.h"
#import "DataModel.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    self.webView.delegate = self;
    [self.view addSubview:_webView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    NSLog([DataModel getDataWithKey:kAccToken]);
    if([DataModel getDataWithKey:kAccToken])
    {
        [self performSegueWithIdentifier:@"ToContentVC" sender:self];
    }
    else
    {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kAuthorize]];
        [_webView loadRequest:request];
        if(!hub)
            hub = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hub];
        [hub show:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    [hub hide:YES];
    NSURL * url = [request URL];
    NSString * urlStr = [url absoluteString];
    
    if([urlStr hasPrefix:kRedirectURI])
    {
        NSArray * strArr = [urlStr componentsSeparatedByString:@"code="];
        NSString * codeStr = [strArr lastObject];
//        NSLog(codeStr);
        
        RequestModel * request = [[RequestModel alloc]init];
        request.deleage = self;
        [request getAccessTokenWithCode:codeStr];
        [hub show:YES];
    }
    return YES;
}

- (void)didGetAccessToken:(NSString *)accessToken withState:(kState)state
{
    if(state == kStateSeccess)
    {
        [DataModel setData:accessToken withKey:kAccToken];
        [hub hide:YES];
        [self performSegueWithIdentifier:@"ToContentVC" sender:self];
    }
    else
    {
        
    }
}

@end




//359672270@qq.com
