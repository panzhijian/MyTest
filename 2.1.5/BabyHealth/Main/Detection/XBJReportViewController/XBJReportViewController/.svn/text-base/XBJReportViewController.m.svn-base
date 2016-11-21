//
//  XBJReportViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJReportViewController.h"
#import "WMPageConst.h"
#import "XBJStatisticsViewController.h"

#import "NSString+Date.h"


#import "XBJTestReportViewController.h"
#import "UIViewController+SetupNavigationItem.h"
#import "XBJNetWork.h"
#import "XBJTestReportModel.h"

@interface XBJReportViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation XBJReportViewController

//- (instancetype)init{
//    self = [super init];
//    if(self){
//        [self initViewControllers];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.title = @"检测报告";
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addLeftBarButtonWithTitle:nil color:nil normal:@"zuojiantou" highLight:@"zuojiantou" action:@selector(goBack) target:self];
    [self addRightBarButtonWithTitle:nil color:nil normal:@"chart" highLight:@"chart" action:@selector(chartAction) target:self];
//    [self addRightBarButtonWithTitle:nil color:nil normal:@"info" highLight:@"info" action:@selector(infoAction) target:self];
    [self addRightBarButtonWithTitle:nil color:nil normal:@"share" highLight:@"share" action:@selector(shareAction) target:self];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9373 blue:0.9490 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeSubVc:) name:WMControllerDidFullyDisplayedNotification object:nil];
    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length) return;
    
    [[XBJNetWork sharedInstance] getTestReportsWithBabyID:babyId block:^(NSArray *result,NSString *msg, NSError *error) {
        if(error){
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.5
                                             position:CSToastPositionCenter];
        }else{
            if(result.count){
                self.dataArray = result;
                [self initViewControllers];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"检测数据还未出具，请耐心等待。如有疑问请拨打0755-36307818进行咨询" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initViewControllers{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i++) {
        XBJTestReportModel *model = self.dataArray[i];
        
        if(model.reportTime.length>9){
            model.reportTime = [model.reportTime substringWithRange:NSMakeRange(5, 5)];
        }

        NSString *timerStr = @"";
        
        if(model.collectTime)
        {
            NSString* timeStr = [NSString stringWithFormat:@"%@",model.collectTime];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
            timeZone = [NSTimeZone systemTimeZone];
            [formatter setTimeZone:timeZone];
            NSDate *userDate = [formatter dateFromString:timeStr];
            timerStr = [NSString stringDateFromDate:userDate withFormat:SHORT_DATE_TIME_FORMAT_2];
        }
        
        NSString *title = timerStr?timerStr:@"";
        [viewControllers addObject:[XBJTestReportViewController class]];
        [titles addObject:title];
    }
    self.viewControllerClasses = viewControllers;
    self.titles = titles;
    self.pageAnimatable = YES;
    self.menuItemWidth = 65;
    self.postNotification = YES;
    self.bounces = YES;
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleSizeNormal = 12;
    self.titleSizeSelected = 14;
    self.titleColorSelected = TXT_RED_COLOR;
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        XBJTestReportModel *model = self.dataArray[i];
        if (model.sampleCode && [model.sampleCode isEqualToString:self.sampleCode]) {
            self.selectIndex = i;
            break;
        }
    }
    
    /*
     self.menuHeight = 44;
     self.menuViewStyle = WMMenuViewStyleLine;
     self.titleSizeSelected = 15;
     self.showOnNavigationBar = YES;
     self.menuBGColor = [UIColor clearColor];
     */
    [self reloadData];
}

#pragma mark NotificationCenter
- (void)didChangeSubVc:(id)sender{
    
    XBJTestReportViewController *vc = (XBJTestReportViewController *)self.currentViewController;
    XBJTestReportModel *model = self.dataArray[self.selectIndex];
    vc.model = model;
    
    if(model.reportId && [model.readEnable boolValue]){
        
        [[XBJNetWork sharedInstance] updateTestReportsWithReportId:model.reportId block:^(id result, NSString *msg, NSError *error) {}];
    }
}

#pragma mark Button Action
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chartAction{
    NSLog(@"chartAction 检测统计界面");
    XBJStatisticsViewController *vc = [XBJStatisticsViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)infoAction{
//    XBJTestReportViewController *vc = (XBJTestReportViewController *)self.currentViewController;
//    [vc showDepictPopView];
//}

- (void)shareAction{
    NSLog(@"shareAction");
    [XBJAppHelper shareIn:self shareText:@"你好，检测报告"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
