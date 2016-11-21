//
//  NSString+Date.m
//  ACE
//
//  Created by jackman on 2/25/14.
//  Copyright (c) 2014 JackMan. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
// NSString+Date.m
/*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
[dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];

NSDate *date = [dateFormatter dateFromString:stringDate ];
[dateFormatter release];*/
+ (NSDateFormatter*)stringDateFormatter
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return formatter;
}

+ (NSDateFormatter*)stringDateFormatter:(NSString *)formart
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:formart];
    return formatter;
}

+ (NSDate*)stringDateFromString:(NSString*)string
{
    return [[NSString stringDateFormatter] dateFromString:string];
}

+ (NSString*)stringDateFromDate:(NSDate*)date
{
    return [[NSString stringDateFormatter] stringFromDate:date];
}



+ (NSDate*)stringDateFromString:(NSString*)string withFormat:(NSString *)dateFormat {
    return [[NSString stringDateFormatter:dateFormat] dateFromString:string];
}

+ (NSString*)stringDateFromDate:(NSDate*)date withFormat:(NSString *)dateFormat {
    return [[NSString stringDateFormatter: dateFormat] stringFromDate:date];
}


//// Usage (#import "NSString+Date.h")
//NSString* string = [NSString stringDateFromDate:[NSDate date]];
//NSDate* date = [NSString stringDateFromString:string];
@end
