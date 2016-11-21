//
//  XBJTestStatisticsViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJStatisticsViewController.h"
#import "WMPageConst.h"

#import "XBJTestStatisticsViewController.h"
#import "XBJTestChartViewController.h"

#import "UIViewController+SetupNavigationItem.h"

#import "XBJNetWork.h"
#import "XBJTestReportModel.h"

@interface XBJStatisticsViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation XBJStatisticsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.title = @"检测统计";
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addLeftBarButtonWithTitle:nil color:nil normal:@"zuojiantou" highLight:@"zuojiantou" action:@selector(goBack) target:self];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeSubVc:) name:WMControllerDidFullyDisplayedNotification object:nil];
    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    [[XBJNetWork sharedInstance] getTestReportsWithBabyID:babyId block:^(NSArray *result,NSString *msg, NSError *error) {
        if(error){
            [self.navigationController.view makeToast:error.description
                                             duration:1.5
                                             position:CSToastPositionCenter];
        }else{
            if([result count] > 0){
                self.dataArray = result;
                [self initViewControllers];
            }else{
//                [self.navigationController.view makeToast:msg
//                                                 duration:1.5
//                                                 position:CSToastPositionCenter];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"检测数据还未出具，请耐心等待。如有疑问请拨打0755-36307818进行咨询" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }];
}

- (void)initViewControllers{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    //begin 时攀 报告指标更换
    NSArray *titles = @[@"全部",@"红细胞/rbc",@"白细胞/wbc",@"脂肪球/fat",@"寄生虫/jsc",@"隐血试验/qx",@"虫卵/cl",@"霉菌/mj",@"A群轮状病毒抗原/rv"];
    NSMutableArray *ietmWidths = [NSMutableArray new];
    for (int i = 0; i < titles.count; i++) {
//        if(i==0){
//            [viewControllers addObject:[XBJTestStatisticsViewController class]];
//        }else{
            [viewControllers addObject:[XBJTestChartViewController class]];
//        }
        NSString *title = titles[i];
        CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [ietmWidths addObject:@(size.width+20)];
    }
    self.viewControllerClasses = viewControllers;
    self.titles = titles;
    self.pageAnimatable = YES;
    self.itemsWidths = ietmWidths;
    self.postNotification = YES;
    self.bounces = YES;
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuHeight = 40;
    self.titleSizeNormal = 15;
    self.titleSizeSelected = 15;
    self.titleColorNormal = CELL_TXT_COLOR;
    self.titleColorSelected = TXT_RED_COLOR;
    self.itemMargin = 10;
    
    [self reloadData];
}

#pragma mark NotificationCenter
- (void)didChangeSubVc:(id)sender{
    
    switch (self.selectIndex) {
        case 0:
        {
//            XBJTestStatisticsViewController *vc = (XBJTestStatisticsViewController *)self.currentViewController;
//            vc.dataArray = self.dataArray;
//            [vc setChartData];
            
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeALL;
            [vc setChartData];
        
        }
            break;
//        case 1:
//        {
//            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
//            vc.dataArray = self.dataArray;
//            vc.chartType = TestChartViewTypeColor;
//            [vc setChartData];
//        }
//            break;
//        case 2:
//        {
//            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
//            vc.dataArray = self.dataArray;
//            vc.chartType = TestChartViewTypeTrait;
//            [vc setChartData];
//        }
//            break;
        case 1:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeRedCell;
            [vc setChartData];
        }
            break;
        case 2:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeWhiteCell;
            [vc setChartData];
        }
            break;
        case 3:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeZFQ;
            [vc setChartData];
        }
            break;
        case 4:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeBCL;
            [vc setChartData];
        }
            break;
        case 5:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeFOB;
            [vc setChartData];
        }
            break;
        case 6:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeRWM;
            [vc setChartData];
        }
            break;
        case 7:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeYEAST;
            [vc setChartData];
        }
            break;
        case 8:
        {
            XBJTestChartViewController *vc = (XBJTestChartViewController *)self.currentViewController;
            vc.dataArray = self.dataArray;
            vc.chartType = TestChartViewTypeAVA;
            [vc setChartData];
        }
            break;
        
        default:
            break;
    }

}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
