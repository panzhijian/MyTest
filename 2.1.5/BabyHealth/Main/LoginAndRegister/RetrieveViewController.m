//
//  RetrieveViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "RetrieveViewController.h"
#import "LoginViewController.h"    

@interface RetrieveViewController ()

@end

@implementation RetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    self.view.backgroundColor = BG_COLOR;
    
    _isFirstNumer = NO;
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    phoneImage.image = [UIImage imageNamed:@"phoneic"];
    [self.view addSubview:phoneImage];
    
    self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.phoneText.placeholder = @"手机号码";
    self.phoneText.delegate = self;
    self.phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:self.phoneText];
    
    self.phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(248), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.phoneLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.phoneLine];
    
    UIImageView *verificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    verificationImage.image = [UIImage imageNamed:@"yanzhengma"];
    [self.view addSubview:verificationImage];
    
    self.verificationText= [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.verificationText.placeholder = @"验证码";
    self.verificationText.delegate = self;
    self.verificationText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.verificationText.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.verificationText];
    
    self.verificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(180), AUTO_MATE_HEIGHT(40))];
    [self.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verificationBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.verificationBtn setTitleColor:[UIColor colorWithRed:194.0f/255.0f green:172.0f/255.0f blue:180.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.verificationBtn addTarget:self action:@selector(verificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.verificationText.rightView = self.verificationBtn;
    
    self.verificationLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(371), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.verificationLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.verificationLine];
    
    
    UIImageView *settingImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(464), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    settingImage.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:settingImage];
    
    self.settingText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(464), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.settingText.placeholder = @"设置密码";
    self.settingText.delegate = self;
    self.settingText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.settingText.rightViewMode = UITextFieldViewModeAlways;
    self.settingText.secureTextEntry = YES;
    [self.view addSubview:self.settingText];
    
    self.rightImage = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    self.rightImage.image = [UIImage imageNamed:@"eye on"];
    self.rightImage.userInteractionEnabled = YES;
    self.settingText.rightView = self.rightImage;
    
    UITapGestureRecognizer *rightRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightImageClick:)];
    [self.rightImage addGestureRecognizer:rightRecognizer];
    
    self.settingLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(474), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.settingLine.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:self.settingLine];
    
    
    UIImageView *loginImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(146), AUTO_MATE_HEIGHT(537), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    loginImage.image = [UIImage imageNamed:@"button"];
    loginImage.userInteractionEnabled = YES;
    [self.view addSubview:loginImage];
    
    self.loginTitle = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    self.loginTitle.text = @"完成";
    self.loginTitle.font = [UIFont systemFontOfSize:18.0f];
    self.loginTitle.alpha = 0.5;
    self.loginTitle.textAlignment = NSTextAlignmentCenter;
    self.loginTitle.userInteractionEnabled = YES;
    [loginImage addSubview:self.loginTitle];
    
    UITapGestureRecognizer *loginRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginImageClick:)];
    [loginImage addGestureRecognizer:loginRecognizer];
}

#pragma mark -- passwordBtnClick
- (void)verificationBtnClick
{
    if(!self.phoneText.text || self.phoneText.text.length != 11)
    {
        
        
        [self.navigationController.view makeToast:@"请输入手机号"
                                         duration:1.0
                                         position:CSToastPositionCenter];
       
        return;
    }
    
    if(_number > 0 && _isFirstNumer)
    {
        return;
    }
    {
        _number = 60;
    }
    NSLog(@"获取验证码");
    [self messageCountdown];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.phoneText.text forKey:@"mobile"];
    
    [session GET:POST_FORGOTPWDSMSVERIFCODE parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            
            [self.navigationController.view makeToast:@"获取验证码成功!"
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }
        else
        {
        
            
            
            [self.navigationController.view makeToast:[responseObject objectForKey:@"message"]
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        
    }];
}

- (void)messageCountdown
{
    if(_number <= 0)
    {
        [self.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    else
    {
        NSLog(@"时间:%ld",(long)_number);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _number--;
        
        [self.verificationBtn setTitle:[NSString stringWithFormat:@"%lds后重发",(long)_number] forState:UIControlStateNormal];
        [self.verificationBtn setTitleColor:[UIColor colorWithRed:194.0f/255.0f green:172.0f/255.0f blue:180.0f/255.0f alpha:1] forState:UIControlStateNormal];
        _isFirstNumer = YES;
        [self messageCountdown];
    });
}

#pragma mark -- rightImageClick
- (void)rightImageClick:(UITapGestureRecognizer *)rightRecognizer
{
    self.settingText.secureTextEntry = !self.settingText.secureTextEntry;
    [self.settingText becomeFirstResponder];
    if(self.settingText.secureTextEntry)
    {
        self.rightImage.image = [UIImage imageNamed:@"eye on"];
    }
    else
    {
        self.rightImage.image = [UIImage imageNamed:@"eye off"];
    }
}

#pragma mark -- textFeildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- loginImageClick
- (void)loginImageClick:(UITapGestureRecognizer *)loginRecognizer
{
    if([self.phoneText.text isEqualToString:@""] || [self.settingText.text isEqualToString:@""] || [self.verificationText.text isEqualToString:@""])
    {
       
        [self.navigationController.view makeToast:@"输入的信息有误!"
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
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.phoneText.text forKey:@"mobile"];
        [dict setObject:self.verificationText.text forKey:@"smsVerifCode"];
        [dict setObject:self.settingText.text forKey:@"password"];
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:POST_FORGOTPWD parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
            {
                
                [self.navigationController.view makeToast:[responseObject objectForKey:@"message"]
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
                
                self.loginTitle.alpha = 1;
                
                LoginViewController *login = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:YES];
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
        
        self.loginTitle.alpha = 1;
    }
}

#pragma mark -- 解决明文转密文再次输入的时候清空文本框内容的问题
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //string就是此时输入的那个字符
    //得到输入框的内容
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.settingText && textField.isSecureTextEntry ) {
        textField.text = toBeString;
        return NO;
    }
    
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
