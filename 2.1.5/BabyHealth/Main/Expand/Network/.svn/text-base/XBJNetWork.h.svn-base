//
//  XBJNetWork.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJNetWork : NSObject

+ (XBJNetWork *)sharedInstance;


#pragma mark 便便

/**
 *  添加便便记录
 *
 *  @param baby_id  id
 *  @param date     时间
 *  @param trait    性状
 *  @param color    颜色
 *  @param remark   描述
 *  @param block    回调
 */
- (void)addDungRecordWithBabyID:(NSString *)baby_id createTime:(NSString *)date trait:(NSString *)trait color:(NSString *)color remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block;

/**
 *  便便统计信息获取（根据时间显示每天便便的颜色和性状）
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)dungStatisticWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  便便信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)getDungsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  编辑便便信息
 *
 *  @param baby_id    宝宝id
 *  @param growId     便便记录Id
 *  @param recordDate 日期
 *  @param trait      性状
 *  @param color      颜色
 *  @param remark     备注
 *  @param block      回调
 */
- (void)editDungRecordWithBabyID:(NSString *)baby_id dungId:(NSString *)dungId createTime:(NSString *)createTime trait:(NSString *)trait color:(NSString *)color remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block;
/**
 *  删除便便
 *
 *  @param growId  便便对象Id
 *  @param block   回调
 */
- (void)removeDungRecordWithDungId:(NSString *)dungId block:(void (^)(id result,NSString *msg, NSError *error))block;


#pragma mark 用药记录
/**
 *  添加用药记录
 *
 *  @param baby_id id
 *  @param date    时间
 *  @param drugs   药品数组
 *  @param remark  描述
 *  @param images  图片数组
 *  @param block   <#block description#>
 */
- (void)addDrugRecordWithBabyID:(NSString *)baby_id createTime:(NSString *)date drugs:(NSArray *)drugs remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block;

/**
 *  用药统计信息获取（显示所有用药信息（日期和次数）
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)medicineStatisticWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  用药信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)getMedicinesListWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  编辑用药信息
 *
 */
- (void)editMedicineRecordWithBabyID:(NSString *)baby_id medicineId:(NSString *)medicineId createTime:(NSString *)createTime remark:(NSString *)remark drugs:(NSArray *)drugs images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  删除用药信息
 *
 *  @param growId  便便对象Id
 *  @param block   回调
 */
- (void)removeMedicineRecordWithMedicineId:(NSString *)medicineId block:(void (^)(id result,NSString *msg, NSError *error))block;


/**
 *  上传成长记录图片
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)uploadGrowRecordImgWithBabyID:(NSString *)baby_id block:(void (^)(id result, NSError *error))block;

#pragma mark 健康记录

- (void)growStandardWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;
/**
 *  添加成长记录
 *
 *  @param baby_id  id
 *  @param date     时间
 *  @param height   身高
 *  @param weight   体重
 *  @param headSize 头围
 *  @param remark   描述
 *  @param block    回调
 */
- (void)addGrowRecordWithBabyID:(NSString *)baby_id recordDate:(NSString *)date length:(NSString *)height weight:(NSString *)weight headSize:(NSString *)headSize remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block;

/**
 *  生长信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)growRecordsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  编辑生长信息
 *
 *  @param baby_id    宝宝id
 *  @param growId     生长对象Id
 *  @param recordDate 日期
 *  @param length     身高
 *  @param bodyWeight 体重
 *  @param headSize   头围
 *  @param remark     备注
 *  @param block      回调
 */
- (void)editGrowRecordWithBabyID:(NSString *)baby_id growId:(NSString *)growId recordDate:(NSString *)recordDate length:(NSString *)length bodyWeight:(NSString *)bodyWeight headSize:(NSString *)headSize remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  删除生长信息
 *
 *  @param baby_id 宝宝id
 *  @param growId  生长对象Id
 *  @param block   回调
 */
- (void)removeGrowRecordWithGrowId:(NSString *)growId block:(void (^)(id result,NSString *msg, NSError *error))block;

#pragma mark 绑定

/**
 *  获取剩余次数
 *
 *  @param baby_id 宝宝id
 *  @param block   回调
 */
- (void)growRecordNumWithBabyID:(NSString *)baby_id block:(void (^)(id result, NSError *error))block;

/**
 *  获取检测报告
 *
 *  @param baby_id 宝宝id
 *  @param block   回调
 */
- (void)getTestReportsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  更新检测报告状态 已读
 *
 *  @param reportId 报告id
 *  @param block   回调
 */
- (void)updateTestReportsWithReportId:(NSString *)reportId block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  获取检测报告图片列表
 *
 *  @param reportId 检测报告id
 *  @param block    回调
 */
- (void)getImagesByReportId:(NSString *)reportId block:(void (^)(id result, NSError *error))block;

/**
 *  获取检测报告关联的记录详情
 *
 *  @param baby_id  宝宝id
 *  @param dateTime 日期
 *  @param block    回调
 */
- (void)growRecordInfoWithBabyID:(NSString *)baby_id dateTime:(NSString *)dateTime block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  绑定送样
 *
 *  @param baby_id  宝宝id
 *  @param code     样品编号
 *  @param time     时间
 *  @param name     联系人
 *  @param mobile   联系电话
 *  @param province 省
 *  @param city     市
 *  @param area     区
 *  @param address  详细地址
 *  @param color    颜色
 *  @param trait    性状
 *  @param date     关联成长记录的创建时间
 *  @param block    回调
 */
- (void)bindWithBabyID:(NSString *)baby_id sampleCode:(NSString *)code collectTime:(NSString *)time contactName:(NSString *)name mobile:(NSString *)mobile address:(NSString *)address color:(NSString *)color trait:(NSString *)trait block:(void (^)(id result,NSString *msg, NSError *error))block;

/**
 *  搜索药品
 *
 *  @param drugName 药名部分字段
 *  @param block    回调
 */
- (void)getDrugListWithDrugName:(NSString *)drugName block:(void (^)(id result,NSString *msg, NSError *error))block;



/***********panzhijian***********/
#pragma mark 样品信息接口
- (void)bindWithBabyID:(NSString *)baby_id sampleCode:(NSString *)code collectTime:(NSString *)time contactName:(NSString *)name mobile:(NSString *)mobile address:(NSString *)address color:(NSString *)color trait:(NSString *)trait  bindRemark:(NSString *)bindRemark images:(NSArray *)images  block:(void (^)(id result, NSError *error))block;

#pragma mark 验证样品编码
- (void)checkCode:(NSString *)code customerId:(NSString *)customerId block:(void (^)(NSNumber * result, NSString *message,NSError *error))block;

#pragma mark 修改手机号获取验证码
-(void)getModiflyMobilePhoneCode:(NSString *)MobilePhoneCode block:(void (^)(NSNumber * result, NSString *message,NSError *error))block;

#pragma mark 修改手机号

-(void)ModiflyMobilePhone:(NSString *)MobilePhone customerId:(NSString *)customerId smsVerifCode:(NSString *)smsVerifCode block:(void (^)(NSNumber * result, NSString *message,NSError *error))block;
#pragma mark 上传设备信息  版本
-(void)upLoadMobilePhone:(NSString *)mobileModel deviceSysVersion:(NSString *)deviceSysVersion appVersion:(NSString *)appVersion uuid:(NSString *)uuid customerId:(NSString *)customerId block:(void (^)(NSError *error))block;

@end
