//
//  ContentVC.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestModel.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface ContentVC : UITableViewController<RequestDeleage, MJRefreshBaseViewDelegate>
{
    NSMutableArray * _dataArray;
    MBProgressHUD * hub;
    MJRefreshFooterView * _footer;
    MJRefreshHeaderView * _header;
    
    RequestModel * _request;
    int _currentPage;
}
- (IBAction)onLoginoutButtonClick:(id)sender;
- (IBAction)onPublishButtonClick:(id)sender;

@end
