//
//  GrowView.m
//  ChartDemo
//
//  Created by jxmac2 on 16/6/30.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import "XBJGrowView.h"
#import "XBJHealthRecordTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XBJGrowRecordModel.h"
#import "XBJStandardModel.h"

@implementation XBJGrowView

- (void)requestData{
    [self.heightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.weightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.headBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.heightBtn setTitleColor:ChartLine_COLOR forState:UIControlStateNormal];
    [self.weightBtn setTitleColor:ChartLine_COLOR forState:UIControlStateNormal];
    [self.headBtn setTitleColor:ChartLine_COLOR forState:UIControlStateNormal];
    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    [[XBJNetWork sharedInstance] growStandardWithBabyID:babyId block:^(NSArray *result, NSString *msg, NSError *error) {
        if(error){
            if(self.toastBlock) self.toastBlock(error.description);
        }else{
            if(result.count){
                [self configureData:result];
                [self setData];
                // 从首页点击cell 进入界面
                if(self.s_index!=0&&self.s_index<result.count){
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.s_index inSection:0];
                    [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
            }else{
                if(self.toastBlock) self.toastBlock(msg);
            }
        }
    }];
    
    [[XBJNetWork sharedInstance] growRecordsWithBabyID:babyId block:^(NSArray *result, NSString *msg, NSError *error) {
        if(error){
            if(self.toastBlock) self.toastBlock(error.description);
        }else{
            if(result.count){
                self.dataArray = [[NSMutableArray alloc] initWithArray:result];
                [self.tableview reloadData];
            }else{
                if(self.toastBlock) self.toastBlock(msg);
            }
        }
    }];
}

- (void)configureData:(NSArray *)data{
    self.heightArray = [NSMutableArray new];
    self.weightArray = [NSMutableArray new];
    self.headSzArray = [NSMutableArray new];

    for(XBJStandardModel *model in data){
        if(model.type.integerValue==0){
            [self.heightArray addObject:model];
        }else if(model.type.integerValue==1){
            [self.weightArray addObject:model];
        }else{
            [self.headSzArray addObject:model];
        }
    }
    
    
    NSLog(@"升高%ld 体重%ld 头围%ld",self.heightArray.count,self.weightArray.count,self.headSzArray.count);
    
    
}

- (void)configureView{
    [self configureChartView];
    [_tableview registerNib:[UINib nibWithNibName:@"XBJHealthRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"XBJHealthRecordTableViewCell"];
    _tableview.delegate = self;
    _tableview.dataSource = self;
}

- (void)configureChartView{
    _chartView.backgroundColor = ChartBG_COLOR;
    _chartView.delegate = self;
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"";
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.xAxisRenderer.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x坐标在底部
    
    _chartView.rightAxis.enabled = NO;//隐藏右边坐标轴
    _chartView.leftAxis.gridColor = ChartLine_COLOR;
    _chartView.leftAxis.axisLineColor = ChartLine_COLOR;
    _chartView.leftAxis.axisLineWidth = 0.5;
    _chartView.leftAxis.gridLineWidth = 0.5;
    _chartView.xAxis.axisLineWidth = 0.5;
    _chartView.xAxis.gridLineWidth = 0.5;
    _chartView.xAxis.gridColor = ChartLine_COLOR;
    _chartView.xAxis.axisLineColor = ChartLine_COLOR;
    
    
    _chartView.xAxis.labelTextColor = [UIColor whiteColor];
    
    //设置下角 图例;铭文
    _chartView.legend.position = ChartLegendPositionBelowChartLeft;
    _chartView.legend.form = ChartLegendFormLine;
    _chartView.legend.formSize = 9.0;
    _chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    _chartView.legend.xEntrySpace = 4.0;
    _chartView.legend.enabled = NO;//关闭
    
//    _chartView.drawMarkers=YES;
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9.f];
    leftAxis.labelTextColor = ChartLine_COLOR;
    leftAxis.forceLabelsEnabled = YES;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.positiveSuffix = @" cm";
    leftAxis.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
//    yl.axisMaxValue;

// 2016.10.27 时攀 双击放大或缩小Chart
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
- (XBJStandardModel *)latelyModel{
    NSEnumerator * enumerator = [self.chartArray reverseObjectEnumerator];
    XBJStandardModel *obj;
    while (obj = [enumerator nextObject]) {
        
        if(obj.value.integerValue!=0 && obj.enable.integerValue != 1){

            return obj;
        }
    }
    return nil;
}

- (void)setData
{

    XBJStandardModel *lately;
    
    if(self.type == XBJGrowHeight){
        self.chartArray = self.heightArray;
        lately= [self latelyModel];
        self.latelyLabel.text = [NSString stringWithFormat:@"最近身高记录：%.2fcm",[lately.value floatValue]?[lately.value floatValue]:0];
    }else if(self.type == XBJGrowWeight){
        self.chartArray = self.weightArray;
        lately= [self latelyModel];
        
        self.latelyLabel.text = [NSString stringWithFormat:@"最近体重记录：%.2fkg",[lately.value floatValue]?[lately.value floatValue]:0];
    }else{
        self.chartArray = self.headSzArray;
        lately= [self latelyModel];
        self.latelyLabel.text = [NSString stringWithFormat:@"最近头围记录：%.2fcm",[lately.value floatValue]?[lately.value floatValue]:0];
    }
    self.latelyLabel.hidden = NO;
    if(!lately){
        self.latelyLabel.hidden = YES;
        return ;
    }

    float zoom = self.chartArray.count/3.0>1?self.chartArray.count/3.0:1;
    if(!self.zoom){
        self.zoom = zoom;
        [_chartView zoom:zoom scaleY:1.0 x:0 y:0];
    }
   _chartView.doubleTapToZoomEnabled=NO;
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];

    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals5 = [[NSMutableArray alloc] init];

    for(int i=0; i<self.chartArray.count;i++)
    {
        XBJStandardModel *model = self.chartArray[i];
        
        NSString *xValue = [NSString stringWithFormat:@"%@个月",model.month];
        [xVals addObject:xValue];
        
        float yValue;
        float yValue1;
        float yValue2;
        float yValue3;
        float yValue4;
        float yValue5;

            yValue = [model.value floatValue];
            yValue1 = [model.median floatValue];
            yValue2 = [model.poneSd floatValue];
            yValue3 = [model.ptwoSd floatValue];
            yValue4 = [model.noneSd floatValue];
            yValue5 = [model.ntwoSd floatValue];

        if(yValue != 0)
        {
            [yVals addObject:[[ChartDataEntry alloc] initWithValue:yValue xIndex:i]];
        }
        [yVals1 addObject:[[ChartDataEntry alloc] initWithValue:yValue1 xIndex:i]];
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:yValue2 xIndex:i]];
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:yValue3 xIndex:i]];
        [yVals4 addObject:[[ChartDataEntry alloc] initWithValue:yValue4 xIndex:i]];
        [yVals5 addObject:[[ChartDataEntry alloc] initWithValue:yValue5 xIndex:i]];
    }
    
    LineChartDataSet *set = nil;
    LineChartDataSet *set1 = nil;
    LineChartDataSet *set2 = nil;
    LineChartDataSet *set3 = nil;
    LineChartDataSet *set4 = nil;
    LineChartDataSet *set5 = nil;

    if (_chartView.data.dataSetCount > 0)
    {
        _chartView.data.xValsObjc = xVals;
        
//            NSArray *yValues = @[yVals,yVals1,yVals2,yVals3,yVals4,yVals5];
        NSArray *yValues = @[yVals,yVals1,yVals3,yVals5];
            for(int i=0;i<yValues.count;i++){
                LineChartDataSet *dataSet = self.sets[i];
                NSArray *yV = yValues[i];
                dataSet.yVals = yV;
            }
            _chartView.data.dataSets = self.sets;
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set = [[LineChartDataSet alloc] initWithYVals:yVals label:@""];
        set1 = [[LineChartDataSet alloc] initWithYVals:yVals1 label:@""];
        set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@""];
        set3 = [[LineChartDataSet alloc] initWithYVals:yVals3 label:@""];
        set4 = [[LineChartDataSet alloc] initWithYVals:yVals4 label:@""];
        set5 = [[LineChartDataSet alloc] initWithYVals:yVals5 label:@""];

//        self.sets = @[set,set1,set2,set3,set4,set5];
         self.sets = @[set,set1,set3,set5];
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];

        for(int i=0; i<self.sets.count;i++){
            LineChartDataSet *dataSet = self.sets[i];

            [dataSet setCircleColor:UIColor.blackColor];
            dataSet.lineWidth = 1.0;
            dataSet.circleRadius = 1.5;
            dataSet.drawCircleHoleEnabled = NO;
            dataSet.valueFont = [UIFont systemFontOfSize:9.f];
            dataSet.drawValuesEnabled = NO;// 不显示数字
            dataSet.drawCirclesEnabled = NO;
            
            
      //梯度颜色变化
//            NSArray *gradientColors;
//            if (i!=0) {
//                if (0<i&&i<3) {
//                    gradientColors = @[
//                                       (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor
//                                       ];
//                }
//                else
//                {
//                    gradientColors = @[
//                                       (id)[ChartColorTemplates colorFromString:@"#ffffffff"].CGColor,
//                                       
//                                       ];
//                }
//                
//                CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
//                
//                dataSet.fillAlpha = 0.5f;
//                dataSet.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
//                dataSet.drawFilledEnabled = YES;
//                CGGradientRelease(gradient);
//            }
            
            
            [dataSets addObject:dataSet];
            if(i!=0){
                [dataSet setColor:ChartLine_COLOR];
//                dataSet.lineDashLengths = @[@5.f, @10.f];
//                dataSet.highlightLineDashLengths = @[@5.f, @50.f];

            }else{
                [dataSet setColor:UIColor.whiteColor];
                dataSet.lineWidth = 4.0;
            }
            
        }
         
        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
        _chartView.data = data;
        
    }
    
    
    
}
//begin  2016.10.8 时攀  添加代理方法
//捏合放大或缩小图表时的代理方法

- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    //与原始图的比例系数
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g",_chartView.scaleX, _chartView.scaleY);
    CGFloat zoomY = _chartView.leftAxis.axisMaxValue/6-5;
    if (_chartView.scaleX>self.zoom||_chartView.scaleY>zoomY) {
        if (_chartView.scaleX>self.zoom) {
//            if (_lastX==0) {
//                _lastX=scaleX;
//            }
            //0.9和0.7是自己调到的回退系数,1/lastx系数有偏差,效果不对
            [_chartView resetViewPortOffsets];
            [_chartView zoom:0.9 scaleY:scaleY x:0 y:0];
        }
        if (_chartView.scaleY>zoomY) {
            [_chartView resetViewPortOffsets];
            [_chartView zoom:scaleX scaleY:0.7 x:0 y:0];
        }
//        self.lastY = scaleY;
//        self.lastX = scaleX;
        return;
    }
//    self.lastX = scaleX;
//    self.lastY = scaleY;
 
}
//拖拽图表时的代理方法

//- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
//    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
//}
//end  2016.10.8 时攀  添加代理方法
- (IBAction)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    for(UIView *view in self.chartBackView.subviews){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)view;
            button.selected = NO;

        }
    }
    btn.selected = YES;


    float centerConstant = 0;
    float width = btn.bounds.size.width;
    if(btn.tag==10){
        centerConstant = 0;
        self.type = XBJGrowHeight;
          _chartView.leftAxis.valueFormatter.positiveSuffix = @" cm";
        _chartView.leftAxis.axisMinValue = 10;
        _chartView.leftAxis.axisMaxValue = 120;
    }else if(btn.tag==11){
        centerConstant = width;
        self.type = XBJGrowWeight;
        _chartView.leftAxis.valueFormatter.positiveSuffix = @" kg";
        _chartView.leftAxis.axisMinValue = 0;
        _chartView.leftAxis.axisMaxValue = 60;
        
    }else{
        centerConstant = 2 *width;
        _chartView.leftAxis.valueFormatter.positiveSuffix = @" cm";
        _chartView.leftAxis.axisMinValue = 10;
        _chartView.leftAxis.axisMaxValue = 70;
        self.type = XBJGrowHeadSize;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.lineCenterConstraint.constant = centerConstant;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }];
    [self setData];
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
        if(self.type == XBJGrowHeight){
            [cell setGrowModel:self.dataArray[indexPath.row]];
        }
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
    
    [cell setGrowModel:self.dataArray[indexPath.row]];
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
//end 2016-9.28 时攀 放大图片展示设置回调
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
    XBJStandardModel *standardModel = self.chartArray[entry.xIndex];
    
    UsersModel *user = [XBJAppHelper SQLUser];
    id babyBirthday = user.babyBirthday;
    if(!babyBirthday) return;
    
    // 根据生日计算月份
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1;
    if([babyBirthday isKindOfClass:[NSString class]]){
        date1 = [dateFormatter dateFromString:babyBirthday];
    }else{
        date1 = babyBirthday;
    }
   
    for(XBJGrowRecordModel *model in self.dataArray){
        NSString *dateString = model.recordDate;
        NSDate *date2 = [dateFormatter dateFromString:dateString];
        NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
        int days = ((int)time)/(3600*24);
        if(days/30 == standardModel.month.integerValue){
            
            NSInteger index = [self.dataArray indexOfObject:model];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
- (void)showEditViewWith:(NSInteger )index{
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        NSLog(@"animation complete");
    };
    [self.editView showWithBlock:completeBlock];
    
        __weak __typeof__(self) weakSelf = self;

        [self.editView setEdit_block:^(){
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            XBJGrowRecordModel *model = strongSelf.dataArray[index];

            if(strongSelf.editBlock) strongSelf.editBlock(model);
        }];
    
        [self.editView setDelete_block:^(){
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            
            XBJGrowRecordModel *model = strongSelf.dataArray[index];
            [[XBJNetWork sharedInstance] removeGrowRecordWithGrowId:model.growId block:^(NSNumber *code, NSString *msg, NSError *error) {
                if(error){
                    if(strongSelf.toastBlock) strongSelf.toastBlock(error.description);
                }else{
                    if(code.integerValue==1){
                        [strongSelf.dataArray removeObjectAtIndex:index];
                        [strongSelf setData];
                        [strongSelf.tableview reloadData];
                    }else{
                        if(strongSelf.toastBlock) strongSelf.toastBlock(msg);
                    }
                }
            }];
            
        }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
