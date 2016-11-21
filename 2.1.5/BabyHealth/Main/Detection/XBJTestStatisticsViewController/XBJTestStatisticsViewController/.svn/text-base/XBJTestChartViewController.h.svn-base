//
//  XBJTestChartViewController.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/13.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"


typedef NS_ENUM(NSInteger, TestChartViewType)
{
    TestChartViewTypeColor       = 0,      //1   1   1
    TestChartViewTypeTrait       = 1,
    TestChartViewTypeRedCell     = 2, //红细胞
    TestChartViewTypeWhiteCell   = 3, //白细胞
    TestChartViewTypeZFQ         = 4, //脂肪球
    TestChartViewTypeBCL         = 5, //寄生虫
    TestChartViewTypeFOB         = 6, //隐血试验
    TestChartViewTypeRWM         = 7, //蛔虫卵
    TestChartViewTypeYEAST       = 8, //酵母样菌
    TestChartViewTypeAVA         = 9, //a群轮状病毒
    TestChartViewTypeALL         = 10, //全部
};

@interface XBJTestChartViewController : XBJBaseViewController

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) TestChartViewType chartType;

- (void)setChartData;

@end
