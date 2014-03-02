//
//  ContentVC.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "ContentVC.h"
#import "DataModel.h"
#import "Global.h"
#import "AFNetworking.h"
#import "WeiBoObject.h"
#import "ContentCell.h"
#import "UIImageView+WebCache.h"

@interface ContentVC ()

@end

@implementation ContentVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    _dataArray = [NSMutableArray array];
    _header = [[MJRefreshHeaderView alloc]init];
    _header.delegate = self;
    _header.scrollView = self.tableView;
    
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
    
    hub = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hub];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    _request = [[RequestModel alloc]init];
    _request.deleage = self;
    [hub show:YES];
    [_request getWeiBoContentWithPage:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MJRefrenshDeleage

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

    
    if(refreshView == _header)
    {
        _currentPage = 1;
    }
    else
    {
        _currentPage ++;
    }
    [_request getWeiBoContentWithPage:_currentPage];
}

#pragma mark - RequestDelegate

- (void)didGetWeiBoContent:(NSArray *)contentArr withPage:(int)page withState:(kState)state
{
    if(state == kStateSeccess)
    {
        [hub hide:YES];
        [_footer endRefreshing];
        [_header endRefreshing];
        if(page == 1)
        {
            
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:contentArr];
        for(WeiBoObject * obj in _dataArray)
        {
            NSLog(@"**********************************");
            NSLog(@"time:%@",obj.time);
            NSLog(@"userName:%@",obj.userName);
            NSLog(@"content:%@",obj.content);
            NSLog(@"imageUrl:%@",obj.imgUrl);
            NSLog(@"avatar:%@",obj.avatar);
            NSLog(@"source:%@",obj.source);
            if(obj.retweetedObj)
            {
                NSLog(@"----转发微博");
                NSLog(@"----time:%@",obj.retweetedObj.time);
                NSLog(@"----userName:%@",obj.retweetedObj.userName);
                NSLog(@"----content:%@",obj.retweetedObj.content);
                NSLog(@"----imageUrl:%@",obj.retweetedObj.imgUrl);
    //            NSLog(@"----avatar:%@",obj.retweetedObj.avatar);
                NSLog(@"----source:%@",obj.retweetedObj.source);
            }
        }
        [self.tableView reloadData];
    }
    else
    {

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataArray count];
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    WeiBoObject * obj = [_dataArray objectAtIndex:indexPath.row];
    cell.userNameLabel.text = obj.userName;
    
    cell.timeLabel.text = obj.time;
    
    cell.contentLabel.text = obj.content;
    
    cell.contentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, [self getContentHeight:obj withWidth:240]);
    CGFloat h = cell.contentLabel.frame.origin.y + cell.contentLabel.frame.size.height;
//    cell.contentLabel.backgroundColor = [UIColor grayColor];
    
    [cell.avatar setImageWithURL:[NSURL URLWithString:obj.avatar] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    if(obj.imgUrl)
    {
        cell.image.hidden = NO;
        cell.image.frame = CGRectMake(cell.contentLabel.frame.origin.x, h + 10, 150, 150);
        h += cell.image.frame.size.height;
        
        [cell.image setImageWithURL:[NSURL URLWithString:obj.imgUrl] placeholderImage:[UIImage imageNamed:@"thumb_pic"]];
    }
    else
    {
        cell.image.hidden = YES;
    }
    
    if(obj.retweetedObj)
    {
        cell.retwitterContentLabel.hidden = NO;
        cell.retwitterUserNameLabel.hidden = NO;
        cell.retwitterUserNameLabel.text = [NSString stringWithFormat:@"转发:@%@",obj.retweetedObj.userName];
        cell.retwitterUserNameLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x, h,200,30);
        h += cell.retwitterUserNameLabel.frame.size.height;
        
        cell.retwitterContentLabel.text = obj.retweetedObj.content;
        cell.retwitterContentLabel.frame = CGRectMake(cell.contentLabel.frame.origin.x + 30, h, 200, [self getContentHeight:obj.retweetedObj withWidth:200]);
        h += cell.retwitterContentLabel.frame.size.height;
    }
    else
    {
        cell.retwitterContentLabel.hidden = YES;
        cell.retwitterUserNameLabel.hidden = YES;
    }
    
    if(obj.retweetedObj.imgUrl)
    {
        cell.retwitterImage.hidden = NO;
        cell.retwitterImage.frame = CGRectMake(cell.retwitterContentLabel.frame.origin.x, h, 150, 150);
        h += cell.retwitterImage.frame.size.height;
        [cell.retwitterImage setImageWithURL:[NSURL URLWithString:obj.retweetedObj.imgUrl] placeholderImage:[UIImage imageNamed:@"thumb_pic"]];
    }
    else
    {
        cell.retwitterImage.hidden = YES;
    }
    
    cell.sourceLabel.text = obj.source;
    cell.sourceLabel.frame = CGRectMake(cell.avatar.frame.origin.x + 20, h + 10, 200, 30);
    
    cell.commentLabel.text = [NSString stringWithFormat:@"转发:%i 评论:%i",obj.repostsCount, obj.commentsCount];
    cell.commentLabel.frame = CGRectMake(cell.sourceLabel.frame.origin.x + 170, cell.sourceLabel.frame.origin.y, 150, 30);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 70;
    
    WeiBoObject * obj = [_dataArray objectAtIndex:indexPath.row];
    
    
    height += [self getContentHeight:obj withWidth:240];
    
    if(obj.imgUrl)
    {
        height += 150;
    }
    
    if(obj.retweetedObj)
    {
        height += [self getContentHeight:obj.retweetedObj withWidth:200] + 20;
        if(obj.retweetedObj.imgUrl)
        {
            height += 150;
        }
    }
    
    return height + 30;
}

- (CGFloat)getContentHeight:(WeiBoObject *)obj withWidth:(CGFloat)width
{
    CGSize size = CGSizeMake(width, 1000);
    NSDictionary * tDic = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    CGSize actualSize = [obj.content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tDic context:nil].size;
    return actualSize.height;
}



- (IBAction)onLoginoutButtonClick:(id)sender {
    [DataModel clearDataForKey:kAccToken];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPublishButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"ToPublishVC" sender:self];
}
@end
