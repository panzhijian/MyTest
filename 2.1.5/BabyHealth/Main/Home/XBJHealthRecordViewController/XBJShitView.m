//
//  XBJShitView.m
//  ChartDemo
//
//  Created by jxmac2 on 16/7/1.
//  Copyright © 2016年 jxmac2. All rights reserved.

#import "XBJShitView.h"
#import "XBJHealthRecordTableViewCell.h"
#import "XBJChartLeftCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XBJAppHelper.h"
#import "XBJShitRecordModel.h"
#import "XBJShitChartModel.h"

#define ITEM_COUNT 6
@implementation XBJShitView

- (void)requestData{
    [self requestDungStatisticData];
    [self requestDungsData];
}

- (void)requestDungStatisticData{

    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    [[XBJNetWork sharedInstance] dungStatisticWithBabyID:babyId block:^(NSArray *result, NSString *msg, NSError *error) {
        if(error){
            if(self.toastBlock) self.toastBlock(error.description);
        }else{
            if(result.count){
                self.chartArray = result;
                [self setChartData];
            }else{
                if(self.toastBlock) self.toastBlock(msg);
            }
        }
    }];
}

- (void)requestDungsData{
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    [[XBJNetWork sharedInstance] getDungsWithBabyID:babyId block:^(NSArray *result, NSString *msg, NSError *error) {
        if(error){
            if(self.toastBlock) self.toastBlock(error.description);
        }else{
            if(result.count){
                self.dataArray = [[NSMutableArray alloc] initWithArray:result];
                [self setlatelyLabelText];
                [self.tableView1 reloadData];
            }else{
                if(self.toastBlock) self.toastBlock(msg);
            }
        }
    }];
}

- (void)configureView{
    [_tableView1 registerNib:[UINib nibWithNibName:@"XBJHealthRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJHealthRecordTableViewCell"];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    
    [self configureChartView];
}

- (void)configureChartView{
//    _chartView.delegate = self;
//    
//    _chartView.descriptionText = @"";
//    _chartView.noDataTextDescription = @"";
//    
//    _chartView.drawGridBackgroundEnabled = NO;
//    _chartView.dragEnabled = YES;
//    _chartView.data.highlightEnabled = YES;
//
//    [_chartView setScaleEnabled:NO];
//    _chartView.pinchZoomEnabled = NO;
//    
//    ChartYAxis *yl = _chartView.leftAxis;
//    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
//    yl.forceLabelsEnabled = YES;
//    yl.labelCount = 8;
//    yl.axisMinValue = 0.0;
//    yl.axisMaxValue = 280;
//    yl.valueFormatter = [[NSNumberFormatter alloc] init];
//    yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
//    
//    ChartXAxis *xl = _chartView.xAxis;
//    xl.labelPosition = XAxisLabelPositionBottom;
//    xl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
//    
//    _chartView.legend.enabled = NO;//关闭
//    _chartView.rightAxis.enabled = NO;//隐藏右边坐标轴
//    _chartView.xAxisRenderer.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x坐标在底部
//
//    self.bottomLabel.adjustsFontSizeToFitWidth = YES;
//    
//    [self setNeedsUpdateConstraints];
//    [self layoutIfNeeded];
    _chartView.delegate = self;
    
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    _chartView.backgroundColor = ChartBG_COLOR;
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"";
    _chartView.pinchZoomEnabled = NO;
    _chartView.doubleTapToZoomEnabled = NO;
    _chartView.scaleYEnabled = NO;
    [_chartView animateWithXAxisDuration:2.5 easingOption:ChartEasingOptionEaseInOutQuart];
    
    _chartView.leftAxis.gridColor = ChartLine_COLOR;
    _chartView.leftAxis.axisLineColor = ChartLine_COLOR;
    _chartView.leftAxis.axisLineWidth = 0.5;
    _chartView.leftAxis.gridLineWidth = 0.5;
    _chartView.xAxis.axisLineWidth = 0.5;
    _chartView.xAxis.gridLineWidth = 0.5;
    _chartView.xAxis.gridColor = ChartLine_COLOR;
    _chartView.xAxis.axisLineColor = ChartLine_COLOR;
    
    _chartView.maxVisibleValueCount = 60;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.spaceBetweenLabels = 2.0;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:9.f];
    leftAxis.labelCount = 1;
    leftAxis.labelTextColor = ChartLine_COLOR;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 1;
    leftAxis.valueFormatter.negativeSuffix = @" 次";
    leftAxis.valueFormatter.positiveSuffix = @" 次";
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinValue = 0.0; // this replaces startAtZero = YES
    _chartView.rightAxis.enabled = NO;//隐藏右边坐标轴
    
    _chartView.legend.position = ChartLegendPositionBelowChartLeft;
    _chartView.legend.form = ChartLegendFormSquare;
    _chartView.legend.formSize = 9.0;
    _chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    _chartView.legend.xEntrySpace = 4.0;
    _chartView.legend.enabled = NO;
//begin 2016.10.27 时攀 双击放大或缩小Chart
    UITapGestureRecognizer * doubleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTwo)];
    [doubleTap setNumberOfTapsRequired:2];
    [_chartView addGestureRecognizer:doubleTap];
}

-(void)tapTwo
{
    self.isBig=!self.isBig;
    [self chartChangeSize];
    self.block(self.isBig);
   
}
-(void)chartChangeSize
{
    if (self.isBig) {
        self.chartBackHeight.constant=self.frame.size.height;
        self.chartBottomToTableView.constant=0;
    }
    else
    {
        self.chartBackHeight.constant=250;
        self.chartBottomToTableView.constant=10;
    }
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}
//end 2016.10.27 时攀 双击放大或缩小Chart
- (void)setlatelyLabelText{
    XBJShitRecordModel *lastmodel = self.dataArray.firstObject;
    self.latelyLabel.hidden = NO;
    if(!lastmodel){
        self.latelyLabel.hidden = YES;
        return ;
    }
    
    NSString *trait = [XBJAppHelper britishSinoConversion:lastmodel.trait];
    NSString *color = [XBJAppHelper britishSinoConversion:lastmodel.color];
    _latelyLabel.text = [NSString stringWithFormat:@"最近便便记录：%@ %@",trait,color];
}

- (void)setChartData
{
    float zoom = self.chartArray.count/5.0>1?self.chartArray.count/5.0:1;
    if(!self.zoom){
        self.zoom = zoom;
        [_chartView zoom:zoom scaleY:1.0 x:0 y:0];
    }
    _chartView.data = [self generateBarData];
}

- (BarChartData *)generateBarData
{

    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    NSMutableArray *colors = [[NSMutableArray alloc] init];
    NSMutableArray *numArr = [NSMutableArray new];

    for(int index=0; index<self.chartArray.count;index++)
    {
        XBJShitChartModel *model = self.chartArray[index];
        NSString *date;
        if(model.dateTime.length>9){
            date = [model.dateTime substringWithRange:NSMakeRange(5,5)];
        }
        NSString *xValue = date;
        [xVals addObject:xValue];
        
        float num = 0;
        for(NSDictionary *dic in model.dungInfo){
            if(![dic isKindOfClass:[NSDictionary class]]){
                break;
            }
//            float yValue = [XBJAppHelper britishNumberConversion:dic[@"trait"]].floatValue;
            num +=[dic[@"number"] floatValue];            
//            UIColor *color = [XBJAppHelper britishColorConversion:dic[@"dungColor"]];
//            [colors addObject:color];
        }
        [numArr addObject:[NSNumber numberWithFloat:num]];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:num xIndex:index]];

    }

    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];

    BarChartDataSet *set = [[BarChartDataSet alloc] initWithYVals:yVals label:@"D"];
    [set setColor:[UIColor whiteColor]];
    [set setDrawValuesEnabled:YES];
    set.barSpace = 0.55;
    [set setDrawValuesEnabled:YES];
    set.valueFormatter =[[NSNumberFormatter alloc] init];
    [dataSets addObject:set];
    
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 floatValue] > [obj2 floatValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *array = [numArr sortedArrayUsingComparator:cmptr];
    NSString *maxStr = [array lastObject];
    _chartView.leftAxis.labelCount = [maxStr integerValue];

    return data;
}


#pragma mark - tableView delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = [tableView fd_heightForCellWithIdentifier:@"XBJHealthRecordTableViewCell" cacheByIndexPath:indexPath configuration:^(XBJHealthRecordTableViewCell * cell) {
        [cell setShitModel:self.dataArray[indexPath.row]];
    }];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJHealthRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJHealthRecordTableViewCell"];
    cell.index = indexPath.row;
    __weak __typeof__(self) weakSelf = self;
    [cell setEdit_block:^(NSInteger index){
        [weakSelf showEditViewWith:index];
    }];
    
    [cell setShitModel:self.dataArray[indexPath.row]];
    //begin  2016-9.28 时攀 放大图片展示设置回调
    [cell setZoom_block:^(UIImage * img)
     {
         __strong __typeof__(weakSelf) strongSelf = weakSelf;
         strongSelf.zoomView.RecordImgZoomView.image = img;
         [strongSelf.zoomView showWithBlock:nil];
     }];    
    return cell;
}
-(XBJZoomImgView *)zoomView
{
    if (!_zoomView) {
        float width = SCREEN_WIDTH - 60;
        float height = SCREEN_HEIGHT-160;
        _zoomView = [[[UINib nibWithNibName:@"XBJZoomImgView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _zoomView.frame = CGRectMake(0, 0, width, height);
    }
    return _zoomView;
}
//end  2016-9.28 时攀 放大图片展示设置回调
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
    XBJShitChartModel *chartModel = self.chartArray[entry.xIndex];
    NSIndexPath *indexPath;
    NSEnumerator * enumerator = [self.dataArray objectEnumerator];
    XBJShitRecordModel *obj;
    while (obj = [enumerator nextObject]) {
        
        NSLog(@"%@",obj.createTime);
        NSLog(@"%@",chartModel.dateTime);
        NSString *date = [obj.createTime substringToIndex:10];
        if ([date isEqualToString:chartModel.dateTime]) {
            NSInteger index = [self.dataArray indexOfObject:obj];
            indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            break;
        }
    }
    if(indexPath){
        [self.tableView1 scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:entry.xIndex inSection:0];
//    [self.tableView2 scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    //与原始图的比例系数
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g",_chartView.scaleX, _chartView.scaleY);
    //    CGFloat zoomY = _chartView.leftAxis.axisMaxValue/6-5;
    //    if (_chartView.scaleX>self.zoom||_chartView.scaleY>zoomY) {
    if (_chartView.scaleX>self.zoom) {
        //            if (_lastX==0) {
        //                _lastX=scaleX;
        //            }
        //0.9和0.7是自己调到的回退系数,1/lastx系数有偏差,效果不对
        [_chartView resetViewPortOffsets];
        [_chartView zoom:0.9 scaleY:scaleY x:0 y:0];
    }
    //        if (_chartView.scaleY>zoomY) {
    //            [_chartView resetViewPortOffsets];
    //            [_chartView zoom:scaleX scaleY:0.7 x:0 y:0];
    //        }
    //        //        self.lastY = scaleY;
    //        //        self.lastX = scaleX;
    //        return;
    //    }
    //    self.lastX = scaleX;
    //    self.lastY = scaleY;
    
}
//拖拽图表时的代理方法

//- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
//    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
//}
//end  2016.10.8 时攀  添加代理方法

- (void)showEditViewWith:(NSInteger )index{
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        NSLog(@"animation complete");
    };
    [self.editView showWithBlock:completeBlock];
    
    __weak __typeof__(self) weakSelf = self;
    
    [self.editView setEdit_block:^(){
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        XBJShitRecordModel *model = strongSelf.dataArray[index];
        
        if(strongSelf.editBlock) strongSelf.editBlock(model);
    }];
    
    
    [self.editView setDelete_block:^(){
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        
        XBJShitRecordModel *model = strongSelf.dataArray[index];
        [[XBJNetWork sharedInstance] removeDungRecordWithDungId:model.dungId block:^(NSNumber *code, NSString *msg, NSError *error) {
            if(error){
                if(strongSelf.toastBlock) strongSelf.toastBlock(error.description);
            }else{
                if(code.integerValue==1){
                    [strongSelf.dataArray removeObjectAtIndex:index];
                    
                    [strongSelf requestDungStatisticData];//重新请求 刷新图
                    [strongSelf.tableView1 reloadData];
                }else{
                    if(strongSelf.toastBlock) strongSelf.toastBlock(msg);
                }
            }
        }];
        
    }];
    
}


@end
