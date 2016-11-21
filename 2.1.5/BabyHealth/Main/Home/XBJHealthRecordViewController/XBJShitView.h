//
//  XBJShitView.h
//  ChartDemo
//
//  Created by jxmac2 on 16/7/1.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import "XBJRecordView.h"
#import "XBJZoomImgView.h"

typedef void(^addBtnHideBlock)(BOOL);
@interface XBJShitView : XBJRecordView <ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *latelyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet BarChartView *chartView;

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartBottomToTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartBackHeight;
@property (nonatomic,assign)BOOL isBig;//放大状态
@property (strong, nonatomic) NSArray *tableData;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *chartArray;
@property (nonatomic, strong) XBJZoomImgView * zoomView;

@property(nonatomic,copy)addBtnHideBlock block;
-(void)chartChangeSize;
@end
