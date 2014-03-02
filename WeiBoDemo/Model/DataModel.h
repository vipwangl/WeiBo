//
//  DataModel.h
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

+ (void)setData:(NSString *)str withKey:(NSString *)key;
+ (NSString *)getDataWithKey:(NSString *)key;
+ (void)clearDataForKey:(NSString *)key;


@end
