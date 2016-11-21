//
//  NSString+Extension.m
//  BabyHealth
//
//  Created by USER on 16/10/19.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "NSString+IMBExtension.h"

@implementation NSString (IMBExtension)
- (BOOL)isPhoneNum
{
 
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    
    
    NSLog(@"%ld",self.length);
    if (self.length<11) {
        return 0;
        
    }

    
    return [self match:@"^1[3578]\\d{9}$"];
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
}
- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

@end
