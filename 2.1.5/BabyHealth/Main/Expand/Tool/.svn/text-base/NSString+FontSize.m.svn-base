//
//  NSString+FontSize.m
//  test
//
//  Created by xingzhi on 16/8/25.
//  Copyright © 2016年 xingzhi. All rights reserved.
//

#import "NSString+FontSize.h"

@implementation NSString (FontSize)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
