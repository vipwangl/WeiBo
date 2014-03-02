//
//  RequestModel.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef enum{
    kStateSeccess,
    kStateFail,
}kState;


@protocol RequestDeleage <NSObject>

@optional
- (void)didGetAccessToken:(NSString *)accessToken withState:(kState)state;
- (void)didGetWeiBoContent:(NSArray *)contentArr withPage:(int)page withState:(kState)state;
- (void)didPublishMessageWithState:(kState)state;

@end

@interface RequestModel : NSObject


@property(nonatomic, weak)id<RequestDeleage>deleage;

- (void)getAccessTokenWithCode:(NSString *)code;
- (void)getWeiBoContentWithPage:(int)page;
- (void)publishMessage:(NSString *)message;
- (void)publishMessage:(NSString *)message withPhoto:(UIImage *)image;

@end
