//
//  ModifyPasswordViewController.m
//  BabyHealth
//
//  Created by xingzhi on 16/8/31.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()<UITextFieldDelegate>

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";

    self.firstpassword = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.firstpassword.placeholder = @"当前密码";
    self.firstpassword.delegate = self;
    self.firstpassword.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.firstpassword.secureTextEntry = YES;
    [self.view addSubview:self.firstpassword];
    
    self.firstLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(248), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.firstLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.firstLine];
    
    
    self.secondPassword= [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(353), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.secondPassword.placeholder = @"新密码";
    self.secondPassword.delegate = self;
    self.secondPassword.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.secondPassword.rightViewMode = UITextFieldViewModeAlways;
    self.secondPassword.secureTextEntry = YES;
    [self.view addSubview:self.secondPassword];

    
    self.secondLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(363), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.secondLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.secondLine];
    
    
    self.againPassword = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(464), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.againPassword.placeholder = @"确认新密码";
    self.againPassword.delegate = self;
    self.againPassword.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.againPassword.rightViewMode = UITextFieldViewModeAlways;
    self.againPassword.secureTextEntry = YES;
    [self.view addSubview:self.againPassword];
    
    
    self.againLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(474), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.againLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.againLine];
    
    
    UIImageView *loginImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(146), AUTO_MATE_HEIGHT(564), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    loginImage.image = [UIImage imageNamed:@"button"];
    loginImage.userInteractionEnabled = YES;
    [self.view addSubview:loginImage];
    
    self.loginTitle = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    self.loginTitle.text = @"保存";
    self.loginTitle.font = [UIFont systemFontOfSize:18.0f];
    self.loginTitle.alpha = 0.5;
    self.loginTitle.textAlignment = NSTextAlignmentCenter;
    self.loginTitle.userInteractionEnabled = YES;
    [loginImage addSubview:self.loginTitle];
    
    UITapGestureRecognizer *loginRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginImageClick:)];
    [loginImage addGestureRecognizer:loginRecognizer];
}

#pragma mark -- loginImageClick
- (void)loginImageClick:(UITapGestureRecognizer *)loginRecognizer
{
    if([self.firstpassword.text isEqualToString:@""] || [self.secondPassword.text isEqualToString:@""] || [self.againPassword.text isEqualToString:@""])
    {
     
        [self.navigationController.view makeToast:@"输入的信息有误!"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        return;
    }
    else if (![self.againPassword.text isEqualToString:self.secondPassword.text]) {
    
        [self.navigationController.view makeToast:@"两次输入的密码不一致!"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        return;
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
        hud.label.text = @"正在加载";
        [hud.label setTextColor:[UIColor whiteColor]];
        
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:[users.customerId intValue]] forKey:@"customerId"];
        [dict setObject:self.firstpassword.text forKey:@"oldPassword"];
        [dict setObject:self.secondPassword.text forKey:@"newPassword"];
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:POST_MODIFYPWD parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            if (![responseObject isKindOfClass:[NSNull class]]) {
                
                if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
                {
                    [self.navigationController.view makeToast:[responseObject objectForKey:@"message"]
                                                     duration:1.0
                                                     position:CSToastPositionCenter];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                   
                    [self.navigationController.view makeToast:[responseObject objectForKey:@"message"]
                                                     duration:1.0
                                                     position:CSToastPositionCenter];
                }
            }
            
            [hud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.0
                                             position:CSToastPositionCenter];
            [hud hideAnimated:YES];
        }];

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
