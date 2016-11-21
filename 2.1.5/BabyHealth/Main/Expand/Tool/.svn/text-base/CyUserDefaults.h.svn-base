//
//  CyUserDefaults.h
//  CyNews
//
//  Created by apple on 14/7/11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyUserDefaults : NSObject
/**
 *  取值
 *
 *  @param key 键
 *
 *  @return    值
 */
+ (id) valueForKey:(NSString *)key;

/**
 *  存
 *
 *  @param value 值
 *  @param key   键
 */
+ (void) saveValue:(id)value forkey:(NSString *)key;

/**
 *  是否第一次启动App
 *
 *  @return YES-是 NO-否
 */
+ (BOOL) isFirstUse;

/**
 *  是否登陆
 *
 *  @return YES-是 NO-否
 */
+ (BOOL) isLogin;

/**
 *  登陆成功
 *
 *  @param userInfo 用户信息
 */
+ (void) loginSuccess:(NSDictionary *)userInfo;

/**
 *  退出登陆 清除用户信息
 */
+ (void) clearnUserInfo;

@end
