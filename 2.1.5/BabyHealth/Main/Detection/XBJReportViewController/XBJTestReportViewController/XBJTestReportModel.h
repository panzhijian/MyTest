//
//  XBJTestReportModel.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/13.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJTestReportModel : NSObject

@property (copy, nonatomic) NSString *reportId; /**< 报告ID */
@property (copy, nonatomic) NSString *sampleCode; /**< 样品编号 */
@property (copy, nonatomic) NSString *collectTime; /**< 采集时间格式：yyyy-MM-dd */
@property (copy, nonatomic) NSString *contactName; /**< 取样联系人 */
@property (copy, nonatomic) NSString *mobile; /**< 联系电话 */
@property (copy, nonatomic) NSString *province; /**< <#(注释)#> */
@property (copy, nonatomic) NSString *city; /**< <#(注释)#> */
@property (copy, nonatomic) NSString *area; /**< <#(注释)#> */
@property (copy, nonatomic) NSString *address; /**< <#(注释)#> */
@property (copy, nonatomic) NSString *reportState; /**< 报告结论 正常、异常 */
@property (copy, nonatomic) NSString *reportSchedule; /**< 报告进度 */
@property (copy, nonatomic) NSString *color; /**< 颜色 */
@property (copy, nonatomic) NSString *trait; /**< 性状 */
@property (copy, nonatomic) NSString *traitResult; /**< 性状结果：正常、异常 */
@property (copy, nonatomic) NSString *rbc; /**< 镜下红细胞 */
@property (copy, nonatomic) NSString *rbcResult; /**< 红细胞结果：正常、异常 */
@property (copy, nonatomic) NSString *wbc; /**< 镜下白细胞 */
@property (copy, nonatomic) NSString *wbcResult; /**< 白细胞结果：正常、异常 */
@property (copy, nonatomic) NSString *zfq; /**< 脂肪球 */
@property (copy, nonatomic) NSString *zfqResult; /**<  脂肪球结果：正常、异常  */
@property (copy, nonatomic) NSString *bcl; /**< 寄生虫卵 */
@property (copy, nonatomic) NSString *bclResult; /**< 寄生虫卵结果：正常、异常 */
@property (copy, nonatomic) NSString *fob; /**< 隐血试验 */
@property (copy, nonatomic) NSString *fobResult; /**< 隐血试验结果：正常、异常 */
@property (copy, nonatomic) NSString *colorRemark; /**< 颜色备注 */
@property (copy, nonatomic) NSString *traitRemark; /**< 性状备注 */
@property (copy, nonatomic) NSString *rbcRemark; /**< 镜下红细胞备注 */
@property (copy, nonatomic) NSString *wbcRemark; /**< 镜下白细胞备注 */
@property (copy, nonatomic) NSString *zfqRemark; /**< 脂肪球备注 */
@property (copy, nonatomic) NSString *bclRemark; /**< 寄生虫卵备注 */
@property (copy, nonatomic) NSString *fobRemark; /**< 隐血试验备注 */
@property (copy, nonatomic) NSString *remark; /**< 报告解释说明 */

@property (copy, nonatomic) NSString *rwm; /**< 蛔虫卵 */
@property (copy, nonatomic) NSString *rwmResult; /**< 蛔虫卵结果 */
@property (copy, nonatomic) NSString *rwmRemark; /**< 蛔虫卵说明 */

@property (copy, nonatomic) NSString *yeast; /**< 酵母菌 */
@property (copy, nonatomic) NSString *yeastResult; /**< 酵母菌结果 */
@property (copy, nonatomic) NSString *yeastRemark; /**< 酵母菌说明 */

@property (copy, nonatomic) NSString *ava; /**< A群轮状病毒 */
@property (copy, nonatomic) NSString *avaResult; /**< A群轮状病毒结果 */
@property (copy, nonatomic) NSString *avaRemark; /**< A群轮状病毒说明 */

@property (copy, nonatomic) NSString *reportTime; /**< 出检测报告时间 格式yyyy-MM-dd */

@property (copy, nonatomic) NSString *readEnable; /**< 0未读 1已读 */

@property (copy,nonatomic) NSString *babyAge;

@end
