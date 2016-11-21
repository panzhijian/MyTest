//
//  XBJDrugRecordModel.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/16.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJDrugRecordModel : NSObject

@property (copy, nonatomic) NSString *medicineId; /**<用药记录id*/
@property (copy, nonatomic) NSString *baby; /**<*/
@property (copy, nonatomic) NSString *createTime; /**<时间*/
@property (copy, nonatomic) NSString *remark; /**<描述*/
@property (copy, nonatomic) NSString *imgUrl; /**<*/
@property (strong, nonatomic) NSArray *imagePaths; /**<用药图片*/
@property (strong, nonatomic) NSArray *medicineInfos; /**<药品数组*/

@property (copy,nonatomic) NSString *babyAge;

@end
