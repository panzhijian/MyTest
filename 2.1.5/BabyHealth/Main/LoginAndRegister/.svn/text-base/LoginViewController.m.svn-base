//
//  LoginViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "LoginViewController.h"
#import "RetrieveViewController.h"

#import "AFHTTPSessionManager.h"
#import "UsersModel.h"
#import "BabyHealthViewController.h"
#import "StringConvertDate.h"
#import "QIAODBMangerEx.h"
#import "BirthMethodModel.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "RegisterViewController.h"
#import "BPush.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BG_COLOR;
    
    if([self performSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.title = @"登录";
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"注册" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0,0,AUTO_MATE_WIDTH(100),AUTO_MATE_HEIGHT(30));
    [addBtn addTarget:self action:@selector(registerViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(248), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    phoneImage.image = [UIImage imageNamed:@"phoneic"];
    [self.view addSubview:phoneImage];
    
    self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.phoneText.placeholder = @"手机号码";
    self.phoneText.delegate = self;
    self.phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.phoneText.text = @"15989478741";
    [self.view addSubview:self.phoneText];
    
    self.phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(248), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.phoneLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.phoneLine];
    
    UIImageView *passwordImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    passwordImage.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:passwordImage];
    
    self.passwordText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(150), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.passwordText.placeholder = @"密码";
//    self.passwordText.text = @"3365609";
    self.passwordText.delegate = self;
    self.passwordText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passwordText.rightViewMode = UITextFieldViewModeAlways;
    self.passwordText.secureTextEntry = YES;
    [self.view addSubview:self.passwordText];
    
    self.passwordLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(371), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.passwordLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.passwordLine];
    
    UIButton *passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(170), AUTO_MATE_HEIGHT(30))];
    [passwordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    passwordBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [passwordBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(passwordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.passwordText.rightView = passwordBtn;
    
    UIImageView *loginImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(146), AUTO_MATE_HEIGHT(467), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    loginImage.image = [UIImage imageNamed:@"button"];
    loginImage.userInteractionEnabled = YES;
    [self.view addSubview:loginImage];
    
    self.loginTitle = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    self.loginTitle.text = @"登录";
    self.loginTitle.font = [UIFont systemFontOfSize:18.0f];
    self.loginTitle.alpha = 0.5;
    self.loginTitle.textAlignment = NSTextAlignmentCenter;
    self.loginTitle.userInteractionEnabled = YES;
    [loginImage addSubview:self.loginTitle];
    
    UITapGestureRecognizer *loginRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginImageClick:)];
    [loginImage addGestureRecognizer:loginRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    if(users.mobile)
    {
        self.phoneText.text = users.mobile;
    }

}

#pragma mark -- passwordBtnClick
- (void)passwordBtnClick
{
    RetrieveViewController *retrieve = [[RetrieveViewController alloc] init];
    [self.navigationController pushViewController:retrieve animated:YES];
    
    NSLog(@"忘记密码");
}

#pragma mark -- loginImageClick
- (void)loginImageClick:(UITapGestureRecognizer *)loginRecognizer
{
    if([self.phoneText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:@""] || self.phoneText.text.length != 11)
    {

        [self.navigationController.view makeToast:@"账号或密码错误，请重新输入"
                                         duration:1.0
                                         position:CSToastPositionCenter];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在登入";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.phoneText.text forKey:@"mobile"];
    [dict setObject:self.passwordText.text forKey:@"password"];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:POST_LOGIN parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
//            MBProgressHUD *hud2 = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//            
//            // Set the custom view mode to show any view.
//            hud2.mode = MBProgressHUDModeCustomView;
//            // Set an image view with a checkmark.
//            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//            hud2.customView = [[UIImageView alloc] initWithImage:image];
//            // Looks a bit nicer if we make it square.
//            hud2.square = YES;
//            // Optional label text.
//            hud.label.text = @"登入成功";
//            [hud.label setTextColor:[UIColor whiteColor]];
//
//            [hud hideAnimated:YES afterDelay:2.0f];
//            
            
            
            self.loginTitle.alpha = 1;
            
            
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            
            UsersModel *users = [[UsersModel alloc] init];
            
            users.passWord = self.passwordText.text;
            
            users.myPushState = [dict objectForKey:@"pushNotice"];
            users.upState = [dict objectForKey:@"upNotice"];
            users.commentState = [dict objectForKey:@"commentNotice"];
            
            users.accumulatePoints = [dict objectForKey:@"accumulatePoints"];
            if(![[dict objectForKey:@"avatarImg"] isKindOfClass:[NSNull class]])
            {
                users.avatarImg = [dict objectForKey:@"avatarImg"];
            }
            
            if(![[dict objectForKey:@"birthday"] isKindOfClass:[NSNull class]])
            {
                users.birthday = [dict objectForKey:@"birthday"];
            }
            else
            {
                users.birthday = @"";
            }
            
            if(![[dict objectForKey:@"city"] isKindOfClass:[NSNull class]])
            {
                users.city = [dict objectForKey:@"city"];
            }
            else
            {
                users.city = @"";
            }
            
            if(![[dict objectForKey:@"createTime"] isKindOfClass:[NSNull class]])
            {
                users.createTime = [dict objectForKey:@"createTime"];
            }
            NSLog(@"%@",NSHomeDirectory());
            users.customerId = [dict objectForKey:@"customerId"];
            users.mobile = [dict objectForKey:@"mobile"];
            
            if(![[dict objectForKey:@"nickName"] isKindOfClass:[NSNull class]])
            {
                users.nickName = [dict objectForKey:@"nickName"];
            }
            else
            {
                users.nickName = @"";
            }
            
            if(![[dict objectForKey:@"province"] isKindOfClass:[NSNull class]])
            {
                users.province = [dict objectForKey:@"province"];
            }
            else
            {
                users.province = @"";
            }
            
            users.reportNum = [dict objectForKey:@"reportNum"];
            
            if(![[dict objectForKey:@"babys"] isKindOfClass:[NSNull class]])
            {
                for(NSDictionary *babyDict in [dict objectForKey:@"babys"])
                {
                    users.babyId = [babyDict objectForKey:@"babyId"];
                    if(![[babyDict objectForKey:@"birthday"] isKindOfClass:[NSNull class]])
                    {
                        users.babyBirthday = [babyDict objectForKey:@"birthday"];
                    }
                    else
                    {
                        users.babyBirthday = (NSDate *)@"1970-01-01";
                    }
                    
                    if([[babyDict objectForKey:@"sex"] integerValue] == 0)
                    {
                        users.babySex = @"女孩";
                    }
                    else
                    {
                        users.babySex = @"男孩";
                    }
                    
                    users.babyPregnancyCycle = [babyDict objectForKey:@"pregnancyCycle"];
                    
                    if(![[babyDict objectForKey:@"childbirthType"] isKindOfClass:[NSNull class]])
                    {
                        if([[babyDict objectForKey:@"childbirthType"] isEqualToString:@"NORMAL"])
                        {
                            users.babyChildbirthType = @"自然分娩";
                        }
                        else if([[babyDict objectForKey:@"childbirthType"] isEqualToString:@"CAESAREAN"])
                        {
                            users.babyChildbirthType = @"剖腹产";
                        }
                        else
                        {
                            users.babyChildbirthType = @"其他";
                        }
                    }
                    else
                    {
                        users.babyChildbirthType = @"";
                    }
                    
                    users.babyLength = [babyDict objectForKey:@"length"];
                    users.babyBodyWeight = [babyDict objectForKey:@"bodyWeight"];
                    users.babyHeadSize = [babyDict objectForKey:@"headSize"];
                    
                    if(![[babyDict objectForKey:@"nickName"] isKindOfClass:[NSNull class]])
                    {
                        users.babyNickName = [babyDict objectForKey:@"nickName"];
                    }
                    else
                    {
                        users.babyNickName = @"";
                    }
                }
            }
            
            [self performSelector:@selector(setUsersChannelId:) withObject:users.customerId];
            
            //创建数据库
            QIAODBMangerEx *usersQiao = [[QIAODBMangerEx alloc] initWithFirst:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]  autoincrement:YES];
            [usersQiao insertDataWithModel:users];
            
            //创建分娩类型数据库
            QIAODBMangerEx *birthQiao = [[QIAODBMangerEx alloc] initWithFirst:@"BabyHealth" tableName:@"BirthMethodModel" modelClass:[BirthMethodModel class]  autoincrement:YES];
            birthQiao = nil;
            
            BabyHealthViewController *baby = [[BabyHealthViewController alloc] init];
            self.view.window.rootViewController = baby;
        }
        else
        {
            
            
            [self.navigationController.view makeToast:[responseObject objectForKey:@"message"]
                                             duration:1.0
                                             position:CSToastPositionCenter];

        }
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        [hud hideAnimated:YES];
    }];
    
    NSLog(@"登陆");
}

//设置
- (void)setUsersChannelId:(NSString *)customerId
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *channelDict = [[NSMutableDictionary alloc] init];
    [channelDict setObject:[NSNumber numberWithInteger:[customerId integerValue]] forKey:@"customerId"];
    if([BPush getChannelId])
    {
        [channelDict setObject:[BPush getChannelId] forKey:@"channelId"];
        //登陆成功传递channelId给服务器用于推送
        [session GET:POST_UPDATE_CUSTOMER_CHANID parameters:channelDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.phoneText == textField)
    {
        self.phoneLine.image = [UIImage imageNamed:@"hover line"];
        self.passwordLine.image = [UIImage imageNamed:@"line"];
    }
    else
    {
        self.passwordLine.image = [UIImage imageNamed:@"hover line"];
        self.phoneLine.image = [UIImage imageNamed:@"line"];
    }
}

#pragma mark -- 跳转到注册界面
- (void)registerViewClick
{
    RegisterViewController *baby = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:baby animated:YES];
}

#pragma mark -- textFeildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
