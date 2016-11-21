//
//  XBJGrowRecordModel.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/15.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJGrowRecordModel : NSObject

@property (copy, nonatomic) NSString *growId;/**<生长id*/
@property (copy, nonatomic) NSString *recordDate;/**<时间*/
@property (copy, nonatomic) NSString *remark;/**<描述*/
@property (copy, nonatomic) NSString *imgUrl;/**<*/
@property (copy, nonatomic) NSString *baby;  /**<*/
@property (copy, nonatomic) NSString *testReports;/**<*/
@property (strong, nonatomic) NSArray  *imagePaths;/**<图片数组*/

@property (copy, nonatomic) NSString *bodyWeight;/**<体重*/
@property (copy, nonatomic) NSString *headSize;/**< 头围 */
@property (copy, nonatomic) NSString *length;/**< 身高 */

@property (copy,nonatomic) NSString *babyAge; 

@end
