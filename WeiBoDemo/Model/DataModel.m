//
//  DataModel.m
//  WeiBoDemo
//
//  Created by Mr Wang on 14-2-23.
//  Copyright (c) 2014年 Mama. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+ (void)setData:(NSString *)str withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getDataWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)clearDataForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
