//
//  XBJNetWork.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJNetWork.h"
#import "LCNetworkConfig.h"
#import "XBJRequest.h"
#import "XBJUploadRequest.h"

#import "LCProcessFilter.h"
#import "LCRequestAccessory.h"
#import "MJExtension.h"

// models
#import "XBJTestReportModel.h"
#import "XBJReportDetailModel.h"
#import "XBJGrowRecordModel.h"
#import "XBJShitRecordModel.h"
#import "XBJDrugRecordModel.h"
#import "XBJDrugChartModel.h"
#import "XBJShitChartModel.h"
#import "XBJStandardModel.h"
@implementation XBJNetWork

+ (XBJNetWork *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        LCNetworkConfig *config = [LCNetworkConfig sharedInstance];
        config.mainBaseUrl = REQUEST_IP;
        //        config.mainBaseUrl = @"http://api.zdoz.net";
        //        LCProcessFilter *filter = [[LCProcessFilter alloc] init];
        //        config.processRule = filter;
    });
    return sharedInstance;
}

#pragma mark 成长记录
- (void)growStandardWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/standard.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
        
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *models = [XBJStandardModel objectArrayWithKeyValuesArray:data];
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

- (void)addGrowRecordWithBabyID:(NSString *)baby_id recordDate:(NSString *)date length:(NSString *)height weight:(NSString *)weight headSize:(NSString *)headSize remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block{
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/addGrowRecord.json?"];
    request.images = images.count?images:nil;
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"recordDate":date,
      @"length":height,
      @"bodyWeight":weight,
      @"headSize":headSize,
      @"remark":remark};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        
        sleep(1);
        
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil);
        }else{
            block(@0,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,error);
    }];
}

/**
 *  生长信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)growRecordsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/growRecords.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
//    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
//    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *models = [XBJGrowRecordModel objectArrayWithKeyValuesArray:data];
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

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
- (void)editGrowRecordWithBabyID:(NSString *)baby_id growId:(NSString *)growId recordDate:(NSString *)recordDate length:(NSString *)length bodyWeight:(NSString *)bodyWeight headSize:(NSString *)headSize remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/editGrowRecord.json?"];
    request.images = images.count?images:nil;
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"growId":growId,
      @"recordDate":recordDate,
      @"length":length,
      @"bodyWeight":bodyWeight,
      @"headSize":headSize,
      @"remark":remark,
      };
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        sleep(1);
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}

/**
 *  删除生长信息
 *
 *  @param baby_id 宝宝id
 *  @param growId  生长对象Id
 *  @param block   回调
 */
- (void)removeGrowRecordWithGrowId:(NSString *)growId block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/removeGrowRecord.json?"];
    request.requestArgument = @{@"growId":growId,};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}
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
- (void)addDungRecordWithBabyID:(NSString *)baby_id createTime:(NSString *)date trait:(NSString *)trait color:(NSString *)color remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block{
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/addDung.json?"];
    request.images = images.count?images:nil;
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"createTime":date,
      @"trait":trait,
      @"color":color,
      @"remark":remark};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        sleep(1);
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil);
        }else{
            block(@0,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,error);
    }];
}

/**
 *  便便统计信息获取（根据时间显示每天便便的颜色和性状）
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)dungStatisticWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/dungStatistic.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
    //    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    //    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *models = [XBJShitChartModel objectArrayWithKeyValuesArray:data];
            
            for(XBJShitChartModel *model in models){
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:model.dungInfo];

                model.dungInfo = array;
                
                for(int i=0; i<array.count; i++){
                    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:array[i]];
                    array[i] = dic1;
                    
                    NSString *color = dic1[@"trait"];
                    for(int j=i+1;j<array.count;j++){
                        NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithDictionary:array[j]];
                        NSString *color2 = dic2[@"trait"];
                        if([color2 isEqualToString:color]){
                            NSLog(@"哈哈哈哈");
                            [dic1 setObject:@"OTHER" forKey:@"dungColor"];
                            [dic2 setObject:@"OTHER" forKey:@"dungColor"];
                            NSInteger number1 = [dic1[@"number"] integerValue];
                            NSInteger number2 = [dic2[@"number"] integerValue];
                            [dic2 setObject:@(number1+number2) forKey:@"number"];
                            array[j] = dic2;
                            [array removeObject:dic1];
                        }
                    }
                }
            }
//            for(XBJShitChartModel *model in models){
//                NSMutableArray *array = (NSMutableArray *)model.dungInfo;
//                NSArray *arr = [[NSArray alloc] initWithArray:array];
//                BOOL have = NO;
//                NSDictionary *lastDic;
//                for(NSDictionary *dict in arr){
//                    if([dict[@"dungColor"] isEqualToString:@"OTHER"]){
//                        if(!have){
//                            have = YES;
//                            lastDic = dict;
//                        }else{
//                            [array removeObject:lastDic];
//                            lastDic = dict;
//
////                            have = NO;
//                        }
//                    }
//                }
//            }
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

/**
 *  便便信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)getDungsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getDungs.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
    //    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    //    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *models = [XBJShitRecordModel objectArrayWithKeyValuesArray:data];
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

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
- (void)editDungRecordWithBabyID:(NSString *)baby_id dungId:(NSString *)dungId createTime:(NSString *)createTime trait:(NSString *)trait color:(NSString *)color remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/editDung.json?"];
    request.images = images.count?images:nil;

    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"dungId":dungId,
      @"createTime":createTime,
      @"trait":trait,
      @"color":color,
      @"remark":remark,
      };
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        sleep(1);
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}

/**
 *  删除便便
 *
 *  @param growId  便便对象Id
 *  @param block   回调
 */
- (void)removeDungRecordWithDungId:(NSString *)dungId block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/removeDung.json?"];
    request.requestArgument = @{@"dungId":dungId,};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}
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
- (void)addDrugRecordWithBabyID:(NSString *)baby_id createTime:(NSString *)date drugs:(NSArray *)drugs remark:(NSString *)remark images:(NSArray *)images block:(void (^)(id result, NSError *error))block{
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/addMedicine.json?"];
    request.images = images.count?images:nil;
    NSString *jsonDrugs = [drugs JSONString];
    
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"createTime":date,
      @"medicineInfo":jsonDrugs,
      @"remark":remark};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        sleep(1);
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil);
        }else{
            block(@0,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,error);
    }];
}

/**
 *  用药统计信息获取（显示所有用药信息（日期和次数）
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)medicineStatisticWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getMedicineStatistic.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSArray *array = request.responseJSONObject;
        
        NSArray *models = [XBJDrugChartModel objectArrayWithKeyValuesArray:array];
        block(models,nil,nil);
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}
/**
 *  用药信息列表
 *
 *  @param baby_id id
 *  @param block   回调
 */
- (void)getMedicinesListWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getMedicines.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
    //    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    //    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSArray *array = request.responseJSONObject;
        
        NSArray *models = [XBJDrugRecordModel objectArrayWithKeyValuesArray:array];
        block(models,nil,nil);
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

/**
 *  编辑用药信息
 *
 */
- (void)editMedicineRecordWithBabyID:(NSString *)baby_id medicineId:(NSString *)medicineId createTime:(NSString *)createTime remark:(NSString *)remark drugs:(NSArray *)drugs images:(NSArray *)images block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/editMedicine.json?"];
    request.images = images.count?images:nil;

    NSString *jsonDrugs = [drugs JSONString];
    
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"medicineId":medicineId,
      @"createTime":createTime,
      @"medicineInfo":jsonDrugs,
      @"remark":remark,
      };
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        sleep(1);
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}

/**
 *  删除用药信息
 *
 *  @param growId  便便对象Id
 *  @param block   回调
 */
- (void)removeMedicineRecordWithMedicineId:(NSString *)medicineId block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/removeMedicine.json?"];
    request.requestArgument = @{@"medicineId":medicineId,};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            block(@0,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,nil,error);
    }];
}



- (void)uploadGrowRecordImgWithBabyID:(NSString *)baby_id block:(void (^)(id result, NSError *error))block{
    
}

#pragma mark 绑定

/**
 *  获取剩余次数
 *
 *  @param baby_id 宝宝id
 *  @param block   回调
 */
- (void)growRecordNumWithBabyID:(NSString *)baby_id block:(void (^)( id  result, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getBindRecordNum.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
    //    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    //    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *num = dic[@"data"] ;
            block(num,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        
        
        block(nil,error);
    }];
}

/**
 *  获取检测报告
 *
 *  @param baby_id 宝宝id
 *  @param block   回调
 */
- (void)getTestReportsWithBabyID:(NSString *)baby_id block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/testReports.json?"];
    request.requestArgument =
    @{@"babyId":baby_id};
    
//    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
//    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *array = [XBJTestReportModel objectArrayWithKeyValuesArray:data];
            NSMutableArray *models = [[NSMutableArray alloc] initWithArray:array];
            // 删除后台返回的未检测的`````报告
            NSEnumerator * enumerator = [models reverseObjectEnumerator];//逆序遍历
            models = [[NSMutableArray alloc] initWithArray:[enumerator allObjects]];
            for(NSInteger i = models.count-1;i >= 0;i--)
            {
                XBJTestReportModel *obj = [models objectAtIndex:i];
                
                if (!obj.reportState) {
                    [models removeObject:obj];
                }
            }
            
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

/**
 *  更新检测报告状态 已读
 *
 *  @param reportId 报告id
 *  @param block   回调
 */
- (void)updateTestReportsWithReportId:(NSString *)reportId block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/updateTestReportState.json?"];
    request.requestArgument =
    @{@"reportId":reportId};
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(nil,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}

/**
 *  获取检测报告图片列表
 *
 *  @param reportId 检测报告id
 *  @param block    回调
 */
- (void)getImagesByReportId:(NSString *)reportId block:(void (^)(id result, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getImagesByReportId.json?"];
    request.requestArgument =
    @{@"reportId":reportId};
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSArray *array = request.responseJSONObject;
        //        if(array.count){
        //        }else{
        //            block(nil,nil);
        //        }
        block(array,nil);
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,error);
    }];
}

/**
 *  获取检测报告关联的记录详情
 *
 *  @param baby_id  宝宝id
 *  @param dateTime 日期
 *  @param block    回调
 */
- (void)growRecordInfoWithBabyID:(NSString *)baby_id dateTime:(NSString *)dateTime block:(void (^)(id result, NSString *state, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/growRecordInfo.json?"];
    request.requestArgument =
    @{@"babyId":baby_id,@"dateTime":dateTime};
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            NSArray *data = dic[@"data"];
            NSArray *models = [XBJReportDetailModel objectArrayWithKeyValuesArray:data];
            
            block(models,nil,nil);
        }else{
            block(nil,ERROR_MESSAGE,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(nil,nil,error);
    }];
}


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
 *  @param date     关联成长记录的创建时间  默认是当前系统时间
 *  @param block    回调
 */
- (void)bindWithBabyID:(NSString *)baby_id sampleCode:(NSString *)code collectTime:(NSString *)time contactName:(NSString *)name mobile:(NSString *)mobile address:(NSString *)address color:(NSString *)color trait:(NSString *)trait block:(void (^)(id result,NSString *msg, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/addTestReport.json?"];

    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"sampleCode":code,
      @"collectTime":time,
      @"contactName":name,
      @"mobile":mobile,
      @"address":address,
      @"color":color,
      @"trait":trait,
      };
    
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request)
    {
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil,nil);
        }else{
            if(![dic[@"message"] isKindOfClass:[NSNull class]])
            {
                block(@0,dic[@"message"],nil);
            }
            else
            {
                block(@0,@"系统异常",nil);
            }
        }
    }
    failure:^(__kindof LCBaseRequest *request, NSError *error)
    {
        block(@0,nil,error);
    }];
    
    
    
//    
//    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/getMedicines.json?"];
//    request.requestArgument =
//    @{@"babyId":baby_id};
//    
//    //    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
//    //    [request addAccessory:accessory];
//    
//    [request startWithBlockSuccess:^(XBJRequest *request) {
//        NSArray *array = request.responseJSONObject;
//        
//        NSArray *models = [XBJDrugRecordModel objectArrayWithKeyValuesArray:array];
//        block(models,nil,nil);
//    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
//        block(nil,nil,error);
//    }];

}

/**
 *  搜索药品
 *
 *  @param drugName 药名部分字段
 *  @param block    回调
 */
- (void)getDrugListWithDrugName:(NSString *)drugName block:(void (^)(id result,NSString *msg, NSError *error))block{
    
    if(drugName.length == 0)
    {
        return;
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:drugName forKey:@"medicineName"];
    [manager GET:[NSString stringWithFormat:@"%@/searchMedicine.json",REQUEST_IP] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            block([responseObject objectForKey:@"data"],nil,nil);
        }
        else
        {
            block(nil,[responseObject objectForKey:@"message"],nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,nil,error);
    }];
}


/***********panzhijian***********/
#pragma mark 样品信息接口 

- (void)bindWithBabyID:(NSString *)baby_id sampleCode:(NSString *)code collectTime:(NSString *)time contactName:(NSString *)name mobile:(NSString *)mobile address:(NSString *)address color:(NSString *)color trait:(NSString *)trait  bindRemark:(NSString *)bindRemark images:(NSArray *)images  block:(void (^)(id result, NSError *error))block{
    XBJUploadRequest *request = [[XBJUploadRequest alloc] initWithUrl:@"/addTestReport.json?"];
    request.images = images.count?images:nil;
    
    request.requestArgument =
    @{@"baby.babyId":baby_id,
      @"sampleCode":code,
      @"collectTime":time,
      @"contactName":name,
      @"mobile":mobile,
      @"address":address,
      @"color":color,
      @"trait":trait,
      @"bindRemark":bindRemark,
      
      };
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"]){
            block(@1,nil);
        }else{
            block(@0,nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        block(@0,error);
    }];
}





#pragma mark 验证样品编码
//http://120.76.194.105/babyhealthtest/mobile/checkSampleCode.json?code=xxx&customerId=49

- (void)checkCode:(NSString *)code customerId:(NSString *)customerId block:(void (^)( NSNumber * result,NSString *message, NSError *error))block{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/checkSampleCode.json?"];
    request.requestArgument =
    @{@"code":code,
      @"customerId":customerId
      };
    LCRequestAccessory *accessory = [LCRequestAccessory sharedInstance];
    [request addAccessory:accessory];
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
     
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"])
        {
            block(dic[@"data"],dic[@"message"],nil);
        }else
        {
            block(@0,dic[@"message"],nil);
        }

    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        
        block(nil,nil,error);
    }];
}

-(void)getModiflyMobilePhoneCode:(NSString *)MobilePhoneCode block:(void (^)(NSNumber * result, NSString *message,NSError *error))block

{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/sendUpdateMobileSmsVerifCode.json?"];
    request.requestArgument =
    @{@"mobile":MobilePhoneCode
      };

    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"])
        {
            block(dic[@"data"],dic[@"message"],nil);
        }else
        {
            block(@0,dic[@"message"],nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        
        block(nil,nil,error);
    }];

}

-(void)ModiflyMobilePhone:(NSString *)MobilePhone customerId:(NSString *)customerId smsVerifCode:(NSString *)smsVerifCode block:(void (^)(NSNumber * result, NSString *message,NSError *error))block
{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/updateMobile.json?"];
    request.requestArgument =
    @{@"mobile":MobilePhone,
      @"customerId":customerId,
      @"smsVerifCode":smsVerifCode
      };
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"])
        {
            block(dic[@"data"],dic[@"message"],nil);
        }else
        {
            block(@0,dic[@"message"],nil);
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        
        block(nil,nil,error);
    }];
    
}

-(void)upLoadMobilePhone:(NSString *)mobileModel deviceSysVersion:(NSString *)deviceSysVersion appVersion:(NSString *)appVersion uuid:(NSString *)uuid customerId:(NSString *)customerId block:(void (^)(NSError *error))block
{
    XBJRequest *request = [[XBJRequest alloc] initWithUrl:@"/uploadMobileInfo.json?"];
    request.requestArgument =
    @{@"mobileModel":mobileModel,
      @"deviceSysVersion":deviceSysVersion,
      @"appVersion":appVersion,
      @"uuid":uuid,
      @"customerId":customerId
      };
    
    [request startWithBlockSuccess:^(XBJRequest *request) {
        
        NSDictionary *dic = request.responseJSONObject;
        NSString *state = dic[@"result"];
        if([state isEqualToString:@"SUCCESS"])
        {
            
            
        }else
        {
            
            
        }
        
    } failure:^(__kindof LCBaseRequest *request, NSError *error) {
        
        block(error);
    }];
}


@end
