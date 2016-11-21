//
//  SampleModel.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleModel : NSObject

@property(nonatomic,strong)NSNumber *ID;
///详细地址
@property(nonatomic,strong)NSString *address;
///区
@property(nonatomic,strong)NSString *area;

@property(nonatomic,strong)NSString *baby;
///寄生虫卵
@property(nonatomic,assign)NSInteger bcl;
///寄生虫卵备注
@property(nonatomic,strong)NSString *bclRemark;
///寄生虫卵结果 正常 异常
@property(nonatomic,strong)NSString *bclResult;
///市
@property(nonatomic,strong)NSString *city;
///采样时间
@property(nonatomic,strong)NSDate *collectTime;
///颜色
@property(nonatomic,strong)NSString *color;
///颜色备注
@property(nonatomic,strong)NSString *colorRemark;

@property(nonatomic,strong)NSString *colorResult;
///取样联系人
@property(nonatomic,strong)NSString *contactName;
///隐血试验
@property(nonatomic,assign)NSInteger fob;
///隐血备注
@property(nonatomic,strong)NSString *fobRemark;
///隐血试验结果 正常 异常
@property(nonatomic,strong)NSString *fobResult;
///联系电话
@property(nonatomic,assign)NSInteger mobile;
///省
@property(nonatomic,strong)NSString *province;
///镜下红细胞
@property(nonatomic,assign)NSInteger rbc;
///镜下红细胞备注
@property(nonatomic,strong)NSString *rbcRemark;
///红细胞结果 正常 异常
@property(nonatomic,strong)NSString *rbcResult;
///报告解释说明
@property(nonatomic,strong)NSString *remark;
///报告ID
@property(nonatomic,assign)NSInteger reportId;
///报告进度
@property(nonatomic,strong)NSString *reportSchedule;
///报告状态 异常 正常
@property(nonatomic,strong)NSString *reportState;
///出检测报告时间
@property(nonatomic,strong)NSDate *reportTime;
///样品编号
@property(nonatomic,strong)NSString *sampleCode;
///性状
@property(nonatomic,strong)NSString *trait;
///性状备注
@property(nonatomic,strong)NSString *traitRemark;
///性状结果 正常 异常
@property(nonatomic,strong)NSString *traitResult;
///镜下白细胞
@property(nonatomic,assign)NSInteger wbc;
///镜下白细胞备注
@property(nonatomic,strong)NSString *wbcRemark;
///镜下白细胞结果 正常 异常
@property(nonatomic,strong)NSString *wbcResult;
///脂肪球
@property(nonatomic,assign)NSInteger zfq;
///脂肪球备注
@property(nonatomic,strong)NSString *zfqRemark;
///脂肪球结果 正常 异常
@property(nonatomic,strong)NSString *zfqResult;

@end
