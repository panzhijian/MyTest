//
//  GrowView.h
//  ChartDemo
//
//  Created by jxmac2 on 16/6/30.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import "XBJRecordView.h"
#import "XBJZoomImgView.h"

typedef NS_ENUM(NSInteger, XBJGrowStyle) {
    XBJGrowHeight,
    XBJGrowWeight,
    XBJGrowHeadSize
};

typedef void(^addBtnHideBlock)(BOOL);

@interface XBJGrowView :XBJRecordView <ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *latelyLabel;
@property (weak, nonatomic) IBOutlet UIView *chartBackView;

@property (weak, nonatomic) IBOutlet LineChartView *chartView;//线表

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *weightArray;
@property (nonatomic, strong) NSMutableArray *headSzArray;
@property (weak, nonatomic) IBOutlet UIButton *heightBtn;
@property (weak, nonatomic) IBOutlet UIButton *weightBtn;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (nonatomic, strong) NSMutableArray *chartArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartBottomToTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartBackHeight;
@property (nonatomic,assign)BOOL isBig;//放大状态

@property (assign, nonatomic) XBJGrowStyle type;

@property (nonatomic, strong) NSArray *sets;

@property (nonatomic,assign) NSInteger s_index; // 需要滚动的行数
@property (nonatomic, strong) XBJZoomImgView * zoomView;

@property (nonatomic,assign)CGFloat lastX;
@property (nonatomic,assign)CGFloat lastY;

@property(nonatomic,copy)addBtnHideBlock block;
-(void)chartChangeSize;

@end
