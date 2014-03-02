//
//  WeiBoObject.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiBoObject : NSObject

//用户名
@property(nonatomic, strong)NSString * userName;

//正文内容
@property(nonatomic, strong)NSString * content;

//图片url
@property(nonatomic, strong)NSString * imgUrl;

//发表时间
@property(nonatomic, strong)NSString * time;

//头像url
@property(nonatomic, strong)NSString * avatar;

//来自。。。
@property(nonatomic, strong)NSString * source;

//评论数
@property(nonatomic, assign)int commentsCount;

//转发数
@property(nonatomic, assign)int repostsCount;

//被转发的微博
@property(nonatomic, strong)WeiBoObject * retweetedObj;


- (id)initWithDataDic:(NSDictionary *)dic;

@end
