//
//  XBJShitRecordModel.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/15.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJShitRecordModel : NSObject

@property (copy, nonatomic) NSString *dungId;/**<便便记录id*/
@property (copy, nonatomic) NSString *baby;  /**<*/
@property (copy, nonatomic) NSString *createTime;/**<生长id时间*/
@property (copy, nonatomic) NSString *trait;/**<性状*/
@property (copy, nonatomic) NSString *color;/**<颜色*/
@property (copy, nonatomic) NSString *num;/**<次数*/

@property (copy, nonatomic) NSString *remark;/**<描述*/
@property (copy, nonatomic) NSString *imgUrl;/**<*/
@property (strong, nonatomic) NSArray *imagePaths;/**<图片数组*/

@property (copy,nonatomic) NSString *babyAge;

@end
