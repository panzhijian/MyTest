//
//  XBJAppHelper.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QIAODBMangerEx.h"
#import "UsersModel.h"

@interface XBJAppHelper : NSObject

// 中->英
+ (NSString *)sinoBritishConversion:(NSString *)chinese;

// 英->中
+ (NSString *)britishSinoConversion:(NSString *)chinese;

// 英->颜色
+ (UIColor *)britishColorConversion:(NSString *)color;

// 性状->颜色
+ (UIColor *)traitColorConversion:(NSString *)trait;


// 英->NSNumber
+ (NSNumber *)britishNumberConversion:(NSString *)english;

/**
 *  中文颜色->Y轴值
 *
 *  @param chinese 中文颜色
 *
 *  @return Y轴 value
 */
+ (NSNumber *)chineseColorToNumber:(NSString *)chinese;

/**
 *  中文颜色->颜色
 *
 *  @param chinese 中文颜色
 *
 *  @return 颜色
 */
+ (UIColor *)chineseColorToColor:(NSString *)chinese;

+ (NSNumber *)chineseTraitToValue:(NSString *)chinese;

+ (float)topConstraintsWith:(float)H Ycount:(NSInteger)count;

+ (float)rowHeightWith:(float)H Ycount:(NSInteger)count;

+ (float)tableHeightWith:(float)H Ycount:(NSInteger)count;

+ (float)stateLabelTopWith:(float)H Ycount:(NSInteger)count topCount:(NSInteger)topCount;

+ (UIImage *)screenImageWithSize:(CGSize )imgSize;

+ (void)shareIn:(UIViewController *)vc shareText:(NSString *)text;

+ (UsersModel *)SQLUser;

@end
