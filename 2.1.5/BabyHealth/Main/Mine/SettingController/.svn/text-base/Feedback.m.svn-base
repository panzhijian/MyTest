//
//  Feedback.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "Feedback.h"
#import "UsersModel.h"

@implementation Feedback

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = BG_COLOR;
    self.title = @"意见反馈";
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.updateText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(16), AUTO_MATE_WIDTH(710), AUTO_MATE_HEIGHT(68))];
    self.updateText.backgroundColor = BG_COLOR;
    self.updateText.layer.cornerRadius = 5.0f;
    [bgView addSubview:self.updateText];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(0,0,AUTO_MATE_WIDTH(100),AUTO_MATE_HEIGHT(30));
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
}

#pragma mark -- sendBtnClick
- (void)sendBtnClick
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在反馈";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *model = [[qiao selectAllFromTable] lastObject];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:model.customerId forKey:@"customer.customerId"];
    [dict setObject:self.updateText.text forKey:@"content"];
    
    [session GET:POST_SAVE_OPINION parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            [self.navigationController.view makeToast:@"反馈成功!感谢您的意见和建议!"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        [hud hideAnimated:YES];
    }];
    
    
}

@end
