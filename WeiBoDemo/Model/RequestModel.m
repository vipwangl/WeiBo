//
//  RequestModel.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "RequestModel.h"
#import "AFNetworking.h"
#import "Global.h"
#import "DataModel.h"
#import "WeiBoObject.h"

@implementation RequestModel


- (void)getAccessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary * parameters = @{@"client_id": kAppKey,
                                 @"client_secret": kAppSecret,
                                 @"grant_type": @"authorization_code",
                                 @"code": code,
                                 @"redirect_uri": kRedirectURI};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:kAccessToken parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
        //            NSLog(@"JSON: %@", responseObject);
        NSDictionary * responDic = (NSDictionary *)responseObject;
        NSString * accessToken = [responDic objectForKey:@"access_token"];
        //            NSLog(@"%@",accessToken);
        
        if(self.deleage && [self.deleage respondsToSelector:@selector(didGetAccessToken:withState:)])
        {
            [self.deleage didGetAccessToken:accessToken withState:kStateSeccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(self.deleage && [self.deleage respondsToSelector:@selector(didGetAccessToken:withState:)])
        {
            [self.deleage didGetAccessToken:nil withState:kStateFail];
        }
    }];
}

- (void)getWeiBoContentWithPage:(int)page
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"access_token": [DataModel getDataWithKey:kAccToken], @"count": [NSNumber numberWithInt:20], @"page": [NSNumber numberWithInt:page]};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:kFirends parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *contentArr = [(NSDictionary *)responseObject objectForKey:@"statuses"];
        NSLog(@"%@",contentArr);
//        NSLog(@"%i",[contentArr count]);
        
        NSMutableArray * returnArray = [[NSMutableArray alloc]initWithCapacity:[contentArr count]];
        
        for(NSDictionary * dic in contentArr)
        {
            WeiBoObject * obj = [[WeiBoObject alloc]initWithDataDic:dic];
            [returnArray addObject:obj];
        }
        
        if(self.deleage && [self.deleage respondsToSelector:@selector(didGetWeiBoContent:withPage:withState:)])
        {
            [self.deleage didGetWeiBoContent:returnArray withPage:page withState:kStateSeccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(self.deleage && [self.deleage respondsToSelector:@selector(didGetWeiBoContent:withPage:withState:)])
        {
            [self.deleage didGetWeiBoContent:nil withPage:0 withState:kStateFail];
        }
    }];
}

- (void)publishMessage:(NSString *)message
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * parameters = @{@"access_token": [DataModel getDataWithKey:kAccToken], @"status": message};
    [manager POST:kUpdate parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        
        if(self.deleage && [self.deleage respondsToSelector:@selector(didPublishMessageWithState:)])
        {
            [self.deleage didPublishMessageWithState:kStateSeccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(self.deleage && [self.deleage respondsToSelector:@selector(didPublishMessageWithState:)])
        {
            [self.deleage didPublishMessageWithState:kStateFail];
        }
    }];
}

- (void)publishMessage:(NSString *)message withPhoto:(UIImage *)image
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * parameters = @{@"access_token": [DataModel getDataWithKey:kAccToken], @"status": message};
    
    
    [manager POST:kUpload parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"pic" fileName:@"pic" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(self.deleage && [self.deleage respondsToSelector:@selector(didPublishMessageWithState:)])
        {
            [self.deleage didPublishMessageWithState:kStateSeccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(self.deleage && [self.deleage respondsToSelector:@selector(didPublishMessageWithState:)])
        {
            [self.deleage didPublishMessageWithState:kStateFail];
        }
    }];

}

@end
