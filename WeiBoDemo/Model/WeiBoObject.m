//
//  WeiBoObject.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "WeiBoObject.h"

@implementation WeiBoObject{
    NSString *_userName;
    NSString *_content;
    NSString *_imgUrl;
    NSString *_time;
    NSString *_avatar;
    NSString *_source;
    int _commentsCount;
    int _repostsCount;
    
    WeiBoObject *_retweetedObj;
}

@synthesize userName = _userName;
@synthesize content = _content;
@synthesize imgUrl = _imgUrl;
@synthesize time = _time;
@synthesize avatar = _avatar;
@synthesize source = _source;
@synthesize retweetedObj = _retweetedObj;

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.userName = [[dic objectForKey:@"user"]objectForKey:@"screen_name"];
        self.content = [dic objectForKey:@"text"];
        if([[dic allKeys] containsObject:@"bmiddle_pic"])
        {
            self.imgUrl = [dic objectForKey:@"bmiddle_pic"];
        }
        else
        {
            self.imgUrl = nil;
        }
        
        self.time = [self getTimeString:[dic objectForKey:@"created_at"]];
        self.avatar = [[dic objectForKey:@"user"]objectForKey:@"avatar_large"];
        self.source = [self getSource:[dic objectForKey:@"source"]];
        
        self.repostsCount = [[dic objectForKey:@"reposts_count"]intValue];
        self.commentsCount = [[dic objectForKey:@"comments_count"]intValue];
        
        if([[dic allKeys] containsObject:@"retweeted_status"])
        {
            _retweetedObj = [[WeiBoObject alloc]initWithDataDic:[dic objectForKey:@"retweeted_status"]];
        }
        else
        {
            self.retweetedObj = nil;
        }
    }
    return self;
}

//处理返回的时间格式
- (NSString *) getTimeString:(NSString *)string
{
    NSDateFormatter * inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate * inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter * outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString * str = [outputFormatter stringFromDate:inputDate];
    return str;
}

//处理来源
- (NSString *)getSource:(NSString *)string
{
    NSRange r1 = [string rangeOfString:@">"];
    NSString * s1 = [string substringFromIndex:r1.location + 1];
    NSRange r2 = [s1 rangeOfString:@"<"];
    NSString * s2 = [s1 substringToIndex:r2.location];
    return [NSString stringWithFormat:@"来自%@", s2];
}

@end
