//
//  CyUserDefaults.m
//  CyNews
//
//  Created by apple on 14/7/11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CyUserDefaults.h"

static NSString* isFirstUse = @"isFirstUse";
static NSString* user_name  = @"user_name";
static NSString* user_info  = @"user_info";

@implementation CyUserDefaults

+ (id) valueForKey:(NSString *)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    return [userDefaultes valueForKey:key];
}

+ (void) saveValue:(id)value forkey:(NSString *)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:value forKey:key];
    [userDefaultes synchronize];
}

+ (BOOL) isFirstUse
{
    NSString *isFirst = [[self class] valueForKey:isFirstUse];
    if(!isFirst)
    {
        [[self class] saveValue:@"!firstUse" forkey:isFirstUse];
        return YES;
    }
    return NO;
}

+ (BOOL) isLogin
{
    NSString *username = [[self class] valueForKey:user_name];
    if(username)
    {
        return YES;
    }
    return NO;
}

+ (void) loginSuccess:(NSDictionary *)userInfo
{
    [[self class] saveValue:userInfo forkey:user_info];
    [[self class] saveValue:[userInfo valueForKey:user_name] forkey:user_name];
    // 可能需要将userInfo 每个键值 都保存
}

+ (void)clearnUserInfo
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes removeObjectForKey:user_info];
    [userDefaultes removeObjectForKey:user_name];
    
    [userDefaultes synchronize];
}

@end
