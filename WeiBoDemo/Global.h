//
//  Global.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-22.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#ifndef WeiBoDemo_Global_h
#define WeiBoDemo_Global_h


#define kAppKey       @"3220216915"
#define kAppSecret    @"af42bedce91b2bf4037a88f466ed7787"
#define kRedirectURI  @"https://api.weibo.com/oauth2/default.html"

#define kAccToken  @"access_token"



//以下为API接口

//authorize接口
#define kAuthorize    [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code&display=mobile&state=authorize", kAppKey, kRedirectURI]

//access_token接口
#define kAccessToken   @"https://api.weibo.com/oauth2/access_token"

//firends_timeline接口，获取当前登录用户及其所关注用户的最新微博
#define kFirends       @"https://api.weibo.com/2/statuses/friends_timeline.json"

//statuses/update发表文本微博接口
#define kUpdate        @"https://api.weibo.com/2/statuses/update.json"

//statuses/upload发表带有图片的微博接口
#define kUpload        @"https://upload.api.weibo.com/2/statuses/upload.json"


#endif
