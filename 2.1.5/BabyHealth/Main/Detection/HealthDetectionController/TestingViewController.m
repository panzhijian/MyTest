//
//  TestingViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "TestingViewController.h"
#import "XBJTestUnbound.h"
#import "XBJBoundView.h"
#import "XBJBindViewController.h"
#import "XBJReportViewController.h"
#import "XBJStatisticsViewController.h"
#import "XBJNetWork.h"
#import "CyUserDefaults.h"
#import "XBJTestReportModel.h"

@interface TestingViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong) XBJBoundView *boundView;
@property (nonatomic,strong) XBJTestUnbound *unboundView;

@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) NSInteger totoalNumber;

@end

@implementation TestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"健康检测";
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9294 blue:0.9412 alpha:1.0];
    [self.view addSubview:scrollView];
    
    _boundView = [[[UINib nibWithNibName:@"XBJBoundView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    _boundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    __weak TestingViewController *weakSelf = self;
    [_boundView setBindBlock:^(){

        if(self.number==1){
            NSString *msg = [NSString stringWithFormat:@"检测次数仅剩下%d次，拨打0755-36307818再次购买？",(int)weakSelf.number];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:weakSelf cancelButtonTitle:@"绑定" otherButtonTitles:@"拨号", nil];
            [alert show];
        }else
        {
            XBJBindViewController *vc = [XBJBindViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    [_boundView setReportBlock:^(){
        XBJReportViewController *vc = [XBJReportViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [_boundView setCensusBlock:^(){
        XBJStatisticsViewController *vc = [XBJStatisticsViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [_boundView setCallBlock:^(){
        [weakSelf showActionSheet];
    }];
    [scrollView addSubview:_boundView];
    
    _unboundView = [[[UINib nibWithNibName:@"XBJTestUnbound" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    _unboundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 668);
    _unboundView.backgroundColor = [UIColor colorWithRed:0.9569 green:0.9294 blue:0.9412 alpha:1.0];

    [_unboundView setBlock:^(){
        XBJBindViewController *vc = [XBJBindViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [_unboundView setCallBlock:^(){
        [weakSelf showActionSheet];
    }];
    [scrollView addSubview:_unboundView];
    
    
//   self.number=12;
//    //初始化
//    self.boundView.numberLabel.text = [NSString stringWithFormat:@"剩余检测次数%d/12",(int)self.number];
//    self.boundView.widthConstraint.constant = (self.number/self.totoalNumber)*(SCREEN_WIDTH-30);
//    [self.boundView setNeedsUpdateConstraints];
//    [self.boundView layoutIfNeeded];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.unboundView.hidden = YES;
    self.boundView.testImageView.hidden = YES;

    [self.tabBarController setSelectedIndex:1];
    
    NSString *babyId = [XBJAppHelper SQLUser].babyId;
    if(!babyId.length)
    {
        self.unboundView.hidden = NO;
        return;
    }
    else
    {
        self.unboundView.hidden = YES;
    }
    
    [[XBJNetWork sharedInstance] growRecordNumWithBabyID:babyId block:^(id result, NSError *error) {
        
        if (error) {
                        self.unboundView.hidden = NO;

  
           return ;
        }else
        {
                self.unboundView.hidden = YES;
            self.number=[[result firstObject] integerValue];
            self.totoalNumber=[[result lastObject] integerValue];
            
            self.boundView.numberLabel.text = [NSString stringWithFormat:@"剩余检测次数%d/%ld",(int)self.number,self.totoalNumber];
            CGFloat num2=(CGFloat)self.totoalNumber;
            self.boundView.widthConstraint.constant = (self.number/num2)*(SCREEN_WIDTH-30);
            [self.boundView setNeedsUpdateConstraints];
            [self.boundView layoutIfNeeded];
        }

    }];

    [[XBJNetWork sharedInstance] getTestReportsWithBabyID:babyId block:^(NSArray *result,NSString *msg, NSError *error) {
        if(error){
//            self.unboundView.hidden = YES;
        }else{
            if(result.count){
//                self.unboundView.hidden = YES;
                for(XBJTestReportModel *model in result){
                    if([model.readEnable boolValue]){
                        self.boundView.testImageView.hidden = NO;
                        break;
                    }
                    else
                    {
                       self.boundView.testImageView.hidden = YES;
                    }
                }
            }else{
//                self.unboundView.hidden = NO;
            }
        }
    }];
}

- (void)showActionSheet{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打电话" otherButtonTitles:@"复制QQ", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@",@"0755-36307818"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    }else if(buttonIndex==1){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"338622234";
        [self showToastWith:@"已复制QQ到剪切板"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(buttonIndex==0 && self.number==1){
        XBJBindViewController *vc = [XBJBindViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(buttonIndex==1){
        NSString *phoneString = [NSString stringWithFormat:@"tel://%@",@"0755-36307818"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
