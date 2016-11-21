//
//  XBJTestStatisticsViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/10.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestStatisticsViewController.h"
#import "XBJTestReportCell.h"
#import "XBJTimeRecordCell.h"
#import "XBJNetWork.h"

@interface XBJTestStatisticsViewController ()<ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet BubbleChartView *chartView;

@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@property (strong, nonatomic) XBJTestReportModel *currentModel;
@property (strong, nonatomic) NSArray *reportArray;

@property (assign, nonatomic) float zoom;/**< 缩放倍数 */

@end

@implementation XBJTestStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView1 registerNib:[UINib nibWithNibName:@"XBJTestReportCell" bundle:nil] forCellReuseIdentifier:@"XBJTestReportCell"];
    [self.tableView2 registerNib:[UINib nibWithNibName:@"XBJTimeRecordCell" bundle:nil] forCellReuseIdentifier:@"XBJTimeRecordCell"];
    [self configureChartView];
}

- (void)configureChartView{
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"";
    
    _chartView.drawGridBackgroundEnabled = NO;//绘制网络背景格
    _chartView.dragEnabled = YES;
    //    [_chartView setDragOffsetX:0]; //**这个属性设置之后，图表可以沿着X轴拖动
    //    _chartView.maxVisibleValueCount = 200;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    
    ChartYAxis *yl = _chartView.leftAxis;
    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    yl.labelCount = 3;
    //    yl.spaceTop = 0.3;
    //    yl.spaceBottom = 0.3;
    yl.axisMinValue = 0.0; // this replaces startAtZero = YES
    
    ChartXAxis *xl = _chartView.xAxis;
    xl.labelPosition = XAxisLabelPositionBottom;
    xl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    
    _chartView.legend.enabled = NO;//关闭
    _chartView.rightAxis.enabled = NO;//隐藏右边坐标轴
    _chartView.xAxisRenderer.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x坐标在底部
}

- (void)setChartData
{
    if(self.dataArray.count==0) return;
    
    float zoom = self.dataArray.count/3.0>1?self.dataArray.count/3.0:1;
    if(!self.zoom){
        self.zoom = zoom;
        [_chartView zoom:zoom scaleY:1.0 x:0 y:0];
    }
    _chartView.data = [self generateBubbleData];
}

- (BubbleChartData *)generateBubbleData
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    NSMutableArray *yValues = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for(XBJTestReportModel *model in self.dataArray){
        model.reportTime?[dates addObject:model.reportTime]:[dates addObject:@"字段为空"];// 时间
        if([model.reportState isEqualToString:@"NORMAL"]){
            [yValues addObject:@100];
            [colors addObject:[UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0]];
        }else{
            [yValues addObject:@200];
            [colors addObject:[UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0]];
        }
    }
    
    
    
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int index = 0; index < yValues.count; index++)
    {
        
        [yVals addObject:[[BubbleChartDataEntry alloc] initWithXIndex:index value:[yValues[index] floatValue] size:0.3/self.zoom]];
    }
    
    BubbleChartDataSet *set = [[BubbleChartDataSet alloc] initWithYVals:yVals label:@"D"];
    [set setColors:colors];
    [set setDrawValuesEnabled:NO];
    [set setNormalizeSizeEnabled:NO];//不使用默认大小？
    [dataSets addObject:set];
    
    BubbleChartData *data = [[BubbleChartData alloc] initWithXVals:dates dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    [data setHighlightCircleWidth: 1.5];
    [data setValueTextColor:UIColor.whiteColor];
    [data setHighlightEnabled:YES];
    
    return data;
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
    self.currentModel = self.dataArray[entry.xIndex];
    [self.tableView1 reloadData];
    self.tableView1.hidden = NO;
    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    if(!self.currentModel.reportTime.length) return;
    
    [[XBJNetWork sharedInstance] growRecordInfoWithBabyID:babyId dateTime:self.currentModel.reportTime block:^(NSArray *array,NSString *msg, NSError *error) {
        if(error){
            [self showToastWith:error.description];
        }else{
            if(array.count){
                self.reportArray = array;
                [self.tableView2 reloadData];
                self.tableView2.hidden = NO;
            }else{
                [self showToastWith:msg];
            }
        }
    }];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - tableView delegate/dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.tableView1) return 10;
    return self.reportArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView==self.tableView1) return 44;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.tableView1) return 35;
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.tableView1){
        XBJTestReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTestReportCell"];
        [cell setModel:self.currentModel andIndex:indexPath.row];
        
        return cell;
    }else{
        XBJTimeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTimeRecordCell"];
        cell.model = self.reportArray[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==self.tableView1){
        return self.headView;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        label.textColor = CELL_TXT_COLOR;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"   相关时间点记录";
        return label;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
