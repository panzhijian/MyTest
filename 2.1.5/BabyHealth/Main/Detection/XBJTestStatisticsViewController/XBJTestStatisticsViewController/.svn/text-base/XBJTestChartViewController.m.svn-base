//
//  XBJTestChartViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/13.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestChartViewController.h"
#import "XBJChartLeftCell.h"
#import "XBJTestReportCell.h"
#import "XBJTimeRecordCell.h"
#import "XBJTestReportModel.h"
#import "XBJAppHelper.h"
#import "XBJNetWork.h"
@interface XBJTestChartViewController ()<ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@property (strong, nonatomic) XBJTestReportModel *currentModel;
@property (strong, nonatomic) NSArray *reportArray;

@property (weak, nonatomic) IBOutlet UIView *chartBg;
@property (weak, nonatomic) IBOutlet BubbleChartView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateTop;

@property (strong, nonatomic) NSArray *tableData;

@property (assign, nonatomic) float zoom;/**< 缩放倍数 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (assign, nonatomic) NSInteger openRow;


@end

@implementation XBJTestChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openRow=-1;
    
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"XBJChartLeftCell" bundle:nil] forCellReuseIdentifier:@"XBJChartLeftCell"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"XBJTestReportCell" bundle:nil] forCellReuseIdentifier:@"XBJTestReportCell"];
    [self.tableView2 registerNib:[UINib nibWithNibName:@"XBJTimeRecordCell" bundle:nil] forCellReuseIdentifier:@"XBJTimeRecordCell"];

    [self configureChartView];
}

- (void)configureChartView{
    _chartBg.hidden = YES;
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"暂无数据";
    
    _chartView.drawGridBackgroundEnabled = NO;//绘制网络背景格
    _chartView.dragEnabled = YES;
    //    [_chartView setDragOffsetX:0]; //**这个属性设置之后，图表可以沿着X轴拖动
//    _chartView.maxVisibleValueCount = 200;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    
    //    _chartView.autoScaleMinMaxEnabled = YES;
    
    ChartYAxis *yl = _chartView.leftAxis;
    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
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
    _chartBg.hidden = NO;
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
        if(model.collectTime.length>10){
            model.collectTime = [model.collectTime substringToIndex:10];
        }
        model.collectTime?[dates addObject:model.collectTime]:[dates addObject:@""];// 时间
        
        switch (self.chartType) {
            case TestChartViewTypeColor://颜色
            {
                UIColor *color = [XBJAppHelper chineseColorToColor:model.color];
                NSNumber *value = [XBJAppHelper chineseColorToNumber:model.color];
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeTrait://性状
            {
                NSNumber *value = [XBJAppHelper chineseTraitToValue:model.trait];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==160){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
                
            case TestChartViewTypeRedCell:
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.rbcResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeWhiteCell://白细胞
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.wbcResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeZFQ://脂肪球
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.zfqResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeBCL://寄生虫
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.bclResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeFOB://隐血试验
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.fobResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeAVA:
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.avaResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeRWM:
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.rwmResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeYEAST:
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.yeastResult];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            case TestChartViewTypeALL:
            {
                NSNumber *value = [XBJAppHelper britishNumberConversion:model.reportState];
                UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
                if(value.integerValue==40){
                    color = [UIColor colorWithRed:0.80 green:0.83 blue:0.76 alpha:1.0];
                }
                [yValues addObject:value];
                [colors addObject:color];
            }
                break;
            default:
                break;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.tableView1==tableView)
       {
           if(self.openRow==indexPath.row){
               self.openRow = -1;
           }else{
               self.openRow = indexPath.row;
           }
           //    NSArray *arr=@[indexPath];
           //
           //    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
           [self.tableView1 reloadData];
//           NSLog(@"%f",self.tableView.contentSize.height);
           
           self.tableviewHeight.constant=self.tableView1.contentSize.height;
           
       }
  
}
#pragma mark - tableView delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.tableView1) return 10;
    if(tableView==self.tableView2) return self.reportArray.count;

    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView==self.tableView) return 0.1;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.tableView1)
    {
        XBJTestReportCell *cell=(XBJTestReportCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        //    XBJTestReportCell *cell =(XBJTestReportCell *)[tableView cellForRowAtIndexPath:self.indexPath];
        
        if(indexPath.row==self.openRow){
            cell.open = YES;
            NSString *contentText;
            
            switch (indexPath.row) {
                case 0:{
                    contentText=@"正常颜色:\n 1)黄褐色。婴儿的便便呈现黄绿色或金黄色，随着宝宝消化能力的提升，便便颜色逐渐加深呈现黄褐色。\n异常颜色：\n 1)绿色：常见于小儿肠炎，或食用大量绿色蔬菜。此外，有些吃富含铁质配方奶的宝宝，排出的粪便会呈暗绿色。\n 2)白色、灰白色：常见于阻塞性黄疸。\n 3)红色便：常见于肛裂及痔疮等，或食用大量番茄、西瓜等\n 4)果酱色：常见于肠套叠，或食用大量巧克力等；\n 5)黑色（柏油色）：常见于上消化道出血。如果进食动物血、猪肝等含铁多的食物也可使粪便呈黑色，但一般为灰黑色无光泽，做隐血试验阴性可帮助鉴别。";
                    
                    
                    break;
                }
                case 1:{
                    contentText=@"正常形态:\n 1)成形软便。婴儿便便呈现糊状，随着宝宝肠道功能逐步成熟，便便逐步为成形软 \n异常形态：\n 1)泡沫样大便：常见于偏食淀粉或糖类食物过多时。\n 2)奇臭难闻大便：常见于偏食含蛋白质的食物过多时。\n 3)蛋花汤样大便：粘液性或脓血性便，常见于病毒性肠炎和致病性大肠杆菌性肠炎等。\n 4)豆腐渣样大便：常见于霉菌引起的肠炎。\n 5)粥样或水样稀便：见于急性肠炎、食物中毒等。\n 6)乳凝乳块便：见于婴儿消化不良、婴儿腹泻、脂肪或酪蛋白消化不全等。\n 7)球形硬便：见于便秘、偏食等。";
                    
                    break;
                }
                case 2:{
                    contentText=@"正常参考值:\n 1)未见（-）\n异常情况：\n 1)（+）的多少代表便便中红细胞的数量情况。红细胞的出现和增多，常见于下消化道炎症或出血。上消化道出血时，由于胃液的消化作用，红细胞已破坏，粪便中难见到，可配合隐血检测结果分析。";
                    
                    break;
                }
                case 3:{
                    contentText=@"正常参考值：\n 1)未见（-）或少许\n异常情况：\n 1)（+）的多少代表便便中白细胞的数量情况。白细胞数量与炎症轻重及部位有关。若是细菌感染，除了可见大便中含有脓性物质，会检测出较多白细胞或脓细胞，同时也可检测出红细胞。若是病毒感染，以稀水便为主，会检测出少许白、红细胞。";
                    
                    break;
                }
                case 4:{
                    contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示粪便中存在脂肪球。粪便脂肪检测可作为了解消化功能和胃肠道吸收功能的参考指标。宝宝消化不良、吸收能力减退时，便便中可能会检出脂肪球。";
                    
                    break;
                }
                case 5:{
                    contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。大多数肠道寄生虫感染与卫生条件、生活习惯、健康意识和家庭聚集性等因素有关。肠道寄生虫感染可能引起腹泻、腹痛、营养吸收不良等症状。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";
                    
                    break;
                }
                case 6:{
                    contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染寄生虫。虫卵容易漏检，如怀疑感染寄生虫，建议多次检查。肠道寄生虫种类较多，如检出，建议咨询正规医院专科医生，使用对应的驱虫药治疗。";
                    
                    break;
                }
                case 7:{
                    contentText=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示宝宝消化道出现少量出血现象。肠道隐性出血可能引起宝宝黑便、便血等症状。";
                    
                    break;
                }
                case 8:{
                    contentText=@"正常参考值：\n 1)未检出（-）\n异常情况：\n 1)检出（+）表示宝宝肠道感染霉菌。宝宝腹泻、红屁屁、大便豆渣样等，可能与霉菌感染相关。抗生素或消毒剂滥用、过于干净养育宝宝等可造成肠道菌群失调，就容易出现霉菌感染。";
                    
                    break;
                }
                case 9:{
                    contentText=@"正常参考值：\n 1)阴性（-）\n异常情况：\n 1)阳性（+）表示A群轮状病毒感染。轮状病毒引起的胃肠炎俗称“秋季腹泻”，发热、呕吐、便便成蛋花汤样，一般与轮状病毒感染相关。轮状病毒性胃肠炎对宝宝造成的危害就是呕吐及腹泻后的脱水，建议提供充足水分、适当添加电解质、服用益生菌。";
                    
                    break;
                }
                    
                default:
                    break;
            }
            return  [XBJTestReportCell rowheight:contentText];
        }else{
            cell.open = NO;
            return 35;
        }

    }else if (tableView==self.tableView2)
    {
        return 110;
    }else
    {
        return [XBJAppHelper rowHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
  
    }
    
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.tableView1){
        XBJTestReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTestReportCell"];
        
        if(indexPath.row==self.openRow){
            cell.open = YES;
        }else{
            cell.open = NO;
        }
        [cell setModel:self.currentModel andIndex:indexPath.row];
        
        return cell;
    }else if(tableView==self.tableView2){
        XBJTimeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTimeRecordCell"];
        cell.model = self.reportArray[indexPath.row];
        return cell;
    }else{
        
        XBJChartLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJChartLeftCell"];
        cell.titleLabel.text = self.tableData[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView==self.tableView1){
        
        self.codeLabel.text = [NSString stringWithFormat:@"样品编号：%@",_currentModel.sampleCode];
        self.reportTimeLabel.text = [NSString stringWithFormat:@"送样时间：%@",_currentModel.collectTime];
        return self.headView;
    }else if(tableView==self.tableView2){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        label.textColor = CELL_TXT_COLOR;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"   相关时间点记录";
        return label;
    }else{
        return nil;
    }
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

#pragma mark setMethod
- (void)setChartType:(TestChartViewType)chartType{
    _chartType = chartType;
    _stateLabel.hidden = NO;
    switch (chartType) {
        case TestChartViewTypeColor:
        {
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 10;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 360;
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:9];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:9];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:9 topCount:3];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
//            self.tableData = @[@"黑色",@"棕色",@"黄色",@"绿色",@"红色",@"灰色"];
            self.tableData = @[@"黑褐色",@"棕色",@"黄色",@"绿色",@"红色",@"灰白色"];

            [self.tableView reloadData];
            
        }
            break;
        case TestChartViewTypeTrait:
        {
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 8;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 280;
            yl.valueFormatter = [[NSNumberFormatter alloc] init];
            yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
            
            self.tableData = @[@"水样",@"很稀",@"粘稠",@"一般",@"较干",@"干硬"];
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1 topCount:5];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
            [self.tableView reloadData];
        }
            break;
        case TestChartViewTypeZFQ:
        case TestChartViewTypeYEAST:
        {
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 3;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 120;
            yl.valueFormatter = [[NSNumberFormatter alloc] init];
            yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
            
            self.tableData = @[@"检出",@"未检出"];
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1 topCount:2];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
            [self.tableView reloadData];
        }
            break;
        case TestChartViewTypeFOB:
        case TestChartViewTypeAVA:
        {
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 3;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 120;
            yl.valueFormatter = [[NSNumberFormatter alloc] init];
            yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
            
            self.tableData = @[@"阳性",@"阴性"];
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1 topCount:2];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
            [self.tableView reloadData];
        }
            break;
        case TestChartViewTypeALL:
        {
            _stateLabel.hidden = YES;
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 3;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 120;
            yl.valueFormatter = [[NSNumberFormatter alloc] init];
            yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
            
            self.tableData = @[@"异常",@"正常"];
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1 topCount:2];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
            [self.tableView reloadData];
        }
            break;
        default:
        {
            ChartYAxis *yl = _chartView.leftAxis;
            yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
            yl.forceLabelsEnabled = YES;
            yl.labelCount = 3;
            yl.axisMinValue = 0.0;
            yl.axisMaxValue = 120;
            yl.valueFormatter = [[NSNumberFormatter alloc] init];
            yl.valueFormatter.roundingMode = NSNumberFormatterRoundCeiling;
            
            self.tableData = @[@"查见",@"未见"];
            
            self.tableViewTop.constant = [XBJAppHelper topConstraintsWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.tableViewHeight.constant = [XBJAppHelper tableHeightWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1];
            self.stateTop.constant = [XBJAppHelper stateLabelTopWith:self.chartView.bounds.size.height Ycount:self.tableData.count+1 topCount:2];
            
            [self.view setNeedsUpdateConstraints];
            [self.view layoutIfNeeded];
            
            [self.tableView reloadData];

        }
            break;
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
