//
//  StringConvertDate.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "StringConvertDate.h"

@implementation StringConvertDate

- (NSDate *)StringConvertDate:(NSString *)stringDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:stringDate];
}

@end
