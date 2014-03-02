//
//  ContentCell.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

@synthesize userNameLabel = _userNameLabel;
@synthesize contentLabel = _contentLabel;
@synthesize avatar = _avatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 40, 40)];
        
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 5, 300, 40)];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 3, 100, 40)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 40, 240, 50)];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        _image = [[ClickImage alloc]init];
        _image.canClick = YES;
        _image.contentMode = UIViewContentModeScaleAspectFill;
        _image.clipsToBounds = YES;
        
        _retwitterUserNameLabel = [[UILabel alloc]init];
        _retwitterUserNameLabel.font = [UIFont systemFontOfSize:14];
        
        _retwitterContentLabel = [[UILabel alloc]init];
        _retwitterContentLabel.font = [UIFont systemFontOfSize:14];
        _retwitterContentLabel.numberOfLines = 0;
        _retwitterContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        _retwitterImage = [[ClickImage alloc]init];
        _retwitterImage.canClick = YES;
        _retwitterImage.contentMode = UIViewContentModeScaleAspectFill;
        _retwitterImage.clipsToBounds = YES;
        
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.font = [UIFont systemFontOfSize:14];
        
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        
        
        [self.contentView addSubview:_avatar];
        [self.contentView addSubview:_userNameLabel];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_contentLabel];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_retwitterUserNameLabel];
        [self.contentView addSubview:_retwitterContentLabel];
        [self.contentView addSubview:_retwitterImage];
        [self.contentView addSubview:_sourceLabel];
        [self.contentView addSubview:_commentLabel];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
