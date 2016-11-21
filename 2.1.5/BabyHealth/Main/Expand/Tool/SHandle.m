//
//  SHandle.m
//  BabyHealth
//
//  Created by lx on 16/9/21.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "SHandle.h"

@implementation SHandle
+(NSArray *)countAge:(NSDate *)babyDate aDate:(NSDate*)oneDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = nil;
    if (oneDate == nil) {
        oneDate = [NSDate date];
    }
        dateComponent = [calendar components:unitFlags fromDate:oneDate];

    //获取当前年/月/日
    NSInteger  thisYear = [dateComponent year];
    NSInteger  thisMonth= [dateComponent month];
    NSInteger  thisDay= [dateComponent day];
    
    
    NSDateComponents *dateBabyComponent = [calendar components:unitFlags fromDate:babyDate];
    //获取宝宝出生年/月/日
   NSInteger babyYear = [dateBabyComponent year];
   NSInteger babyMonth= [dateBabyComponent month];
   NSInteger babyDay= [dateBabyComponent day];
   NSInteger monthDays = 30;
    
    switch (babyMonth) {
        case 1:
            monthDays = 31;
            break;
        case 2:
            if((babyYear %4==0 && babyYear %100 !=0) || babyYear %400==0)
            {
                monthDays = 29;
            }
             monthDays = 28;
            break;
        case 3:
             monthDays = 31;
            break;
        case 4:
             monthDays = 30;
            break;
        case 5:
             monthDays = 31;
            break;
        case 6:
             monthDays = 30;
            break;
        case 7:
             monthDays = 31;
            break;
        case 8:
             monthDays = 31;
            break;
        case 9:
             monthDays = 30;
            break;
        case 10:
             monthDays = 31;
            break;
        case 11:
             monthDays = 30;
            break;
        case 12:
             monthDays = 31;
            break;
            
        default:
            break;
    }
    
    NSInteger years = 0;
    NSInteger months = 0;
    NSInteger days = 0;
    
        if (thisMonth >babyMonth)
        {
            years =thisYear - babyYear;
            months =thisMonth - babyMonth;
            days  = thisDay-babyDay;
            if (thisDay< babyDay) {
                months =thisMonth - babyMonth-1;
                days  = monthDays-babyDay+thisDay;
            }
        }
        else if (thisMonth ==babyMonth)
        {
            years =thisYear - babyYear;
            months =thisMonth - babyMonth;
            days  = thisDay-babyDay;
            if (thisDay< babyDay)
            {
                years = thisYear - babyYear -1;
                months= 11;
                days  = thisDay -babyDay + 31;
                //同年同月负年龄计算
                if (thisYear==babyYear) {
                    years = thisYear - babyYear;
                    months= thisMonth-babyMonth;
                    days  = thisDay -babyDay;
                }
            }
            
        }
        else if (thisMonth <babyMonth)
        {
            years=thisYear - babyYear -1;
            months =thisMonth - babyMonth +12;
            days  = thisDay - babyDay;
            if (thisDay< babyDay)
            {
                days = monthDays-babyDay+thisDay;
                
            }
            //同年不同月负年龄计算
             if (thisYear==babyYear) {
                 years=thisYear - babyYear;
                 months=thisMonth-babyMonth;
                 days=-(thisDay-babyDay);
                 if (thisDay> babyDay) {
                     months=-(babyMonth-thisMonth-1);
                     days=30-thisDay+babyDay;
                     if (months==0) {
                         days=-days;
                     }
                 }
             }
        }
    //不同年负年龄计算
    if (thisYear<babyYear) {
        NSArray * minusArr = [self countAge:oneDate aDate:babyDate];
        years =  - [minusArr[0] integerValue];
        months = [minusArr[1] integerValue];
        if (years==0) {
             months = -[minusArr[1] integerValue];
        }
        days= [minusArr[2] integerValue]-1;

    }
    
    NSNumber *y = [NSNumber numberWithInteger:years];
    NSNumber *m = [NSNumber numberWithInteger:months];
    NSNumber *d = [NSNumber numberWithInteger:days+1];
    
    NSArray * dateArr = [NSArray arrayWithObjects:y,m,d, nil];

    return dateArr;
}
@end
