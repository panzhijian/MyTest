//
//  NSString+FontSize.h
//  test
//
//  Created by xingzhi on 16/8/25.
//  Copyright © 2016年 xingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FontSize)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
