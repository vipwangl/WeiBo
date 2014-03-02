//
//  ContentCell.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoObject.h"
#import "ClickImage.h"

@interface ContentCell : UITableViewCell
{
    UILabel * _userNameLabel;
    UILabel * _contentLabel;
    UIImageView * _avatar;
    UILabel * _sourceLabel;
    UILabel * _timeLabel;
    ClickImage * _image;
    UILabel * _commentLabel;
    
    UILabel * _retwitterUserNameLabel;
    UILabel * _retwitterContentLabel;
    ClickImage * _retwitterImage;
}

@property(nonatomic, strong)UILabel * userNameLabel;
@property(nonatomic, strong)UILabel * contentLabel;
@property(nonatomic, strong)UIImageView * avatar;
@property(nonatomic, strong)UILabel * sourceLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)ClickImage * image;
@property(nonatomic, strong)UILabel * commentLabel;

@property(nonatomic, strong)UILabel * retwitterUserNameLabel;
@property(nonatomic, strong)UILabel * retwitterContentLabel;
@property(nonatomic, strong)ClickImage * retwitterImage;



@end
