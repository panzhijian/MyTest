//
//  RegisterViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "RegisterViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "LoginViewController.h"
#import "MeWebView.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    self.view.backgroundColor = BG_COLOR;
    
    _isFirstNumer = NO;
    
    self.viewScroll = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.viewScroll];
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    phoneImage.image = [UIImage imageNamed:@"phoneic"];
    [self.viewScroll addSubview:phoneImage];
    
    self.phoneText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(238), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.phoneText.placeholder = @"手机号码";
    self.phoneText.delegate = self;
    self.phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.viewScroll addSubview:self.phoneText];
    
    self.phoneLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(248), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.phoneLine.image = [UIImage imageNamed:@"line"];
    [self.viewScroll addSubview:self.phoneLine];
    
    UIImageView *verificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    verificationImage.image = [UIImage imageNamed:@"yanzhengma"];
    [self.viewScroll addSubview:verificationImage];
    
    self.verificationText= [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(361), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.verificationText.placeholder = @"验证码";
    self.verificationText.delegate = self;
    self.verificationText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.verificationText.rightViewMode = UITextFieldViewModeAlways;
    [self.viewScroll addSubview:self.verificationText];
    
    self.verificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(180), AUTO_MATE_HEIGHT(40))];
    [self.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verificationBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.verificationBtn setTitleColor:[UIColor colorWithRed:194.0f/255.0f green:172.0f/255.0f blue:180.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self.verificationBtn addTarget:self action:@selector(verificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.verificationText.rightView = self.verificationBtn;
    
    self.verificationLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(371), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.verificationLine.image = [UIImage imageNamed:@"line"];
    [self.viewScroll addSubview:self.verificationLine];
    
    
    UIImageView *settingImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(464), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    settingImage.image = [UIImage imageNamed:@"password"];
    [self.viewScroll addSubview:settingImage];
    
    self.settingText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(464), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.settingText.placeholder = @"设置密码";
    self.settingText.delegate = self;
    self.settingText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.settingText.rightViewMode = UITextFieldViewModeAlways;
    self.settingText.secureTextEntry = YES;
    [self.viewScroll addSubview:self.settingText];
    
    self.rightImage = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    self.rightImage.image = [UIImage imageNamed:@"eye on"];
    self.rightImage.userInteractionEnabled = YES;
    self.settingText.rightView = self.rightImage;
    
    UITapGestureRecognizer *rightRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightImageClick:)];
    [self.rightImage addGestureRecognizer:rightRecognizer];
    
    self.settingLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(474), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.settingLine.image = [UIImage imageNamed:@"line"];
    [self.viewScroll addSubview:self.settingLine];
    
    UIImageView *nameImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(86), AUTO_MATE_HEIGHT(568), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    nameImage.image = [UIImage imageNamed:@"nameic"];
    [self.viewScroll addSubview:nameImage];
    
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(568), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(40))];
    self.nameText.placeholder = @"设置昵称";
    self.nameText.delegate = self;
    self.nameText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.viewScroll addSubview:self.nameText];
    
    
    self.nameLine = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(138), AUTO_MATE_HEIGHT(578), AUTO_MATE_WIDTH(524), AUTO_MATE_HEIGHT(30))];
    self.nameLine.image = [UIImage imageNamed:@"line"];
    [self.viewScroll addSubview:self.nameLine];
    
    
    UIImageView *registerImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(146), AUTO_MATE_HEIGHT(650), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    registerImage.image = [UIImage imageNamed:@"button"];
    registerImage.userInteractionEnabled = YES;
    [self.viewScroll addSubview:registerImage];
    
    self.registerTitle = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108))];
    self.registerTitle.text = @"注册";
    self.registerTitle.font = [UIFont systemFontOfSize:18.0f];
    self.registerTitle.alpha = 0.5;
    self.registerTitle.textAlignment = NSTextAlignmentCenter;
    self.registerTitle.userInteractionEnabled = YES;
    [registerImage addSubview:self.registerTitle];
    
    UITapGestureRecognizer *registerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerImageClick:)];
    [registerImage addGestureRecognizer:registerRecognizer];
    
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"点击上面的“注册”按钮,即表示你同意《我是宝宝使用条款和隐私政策》"];
    [title addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(18, 15)];
    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0f] range:NSMakeRange(0, 18)];
    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:12.0f] range:NSMakeRange(18, 14)];
    
    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.protocolBtn.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(795), VIEW_SIZE.width, AUTO_MATE_HEIGHT(50));
    self.protocolBtn.titleLabel.numberOfLines = 0;
    [self.protocolBtn setAttributedTitle:title forState:UIControlStateNormal];
    self.protocolBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.viewScroll addSubview:self.protocolBtn];
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
        _isFirstNumer = NO;
    }
    
    [self messageCountdown];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.phoneText.text forKey:@"mobile"];
    
    [session GET:POST_VERIFCODE parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
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

#pragma mark -- registerImageClick
- (void)registerImageClick:(UITapGestureRecognizer *)registerRecogizer
{
    if([self.phoneText.text isEqualToString:@""] || [self.settingText.text isEqualToString:@""]|| self.phoneText.text.length != 11)
        {
        
            [self.navigationController.view makeToast:@"用户信息不完整"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            return;
        }
        else if([self.verificationText.text isEqualToString:@""])
        {
        
            [self.navigationController.view makeToast:@"请输入验证码"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            return;
        }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在注册";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.phoneText.text forKey:@"mobile"];
    [dict setObject:self.settingText.text forKey:@"password"];
    [dict setObject:self.verificationText.text forKey:@"smsVerifCode"];
    [dict setObject:self.nameText.text forKey:@"nickName"];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:POST_REGISTER parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
           
            [self.navigationController.view makeToast:@"注册成功!"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            self.registerTitle.alpha = 1;
            
            LoginViewController *login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else
        {
            NSString *message = @"";
            
            if(![[responseObject objectForKey:@"message"] isKindOfClass:[NSNull class]])
            {
                message = [responseObject objectForKey:@"message"];
            }
            else
            {
                message = @"注册失败!";
            }
            
            [self.navigationController.view makeToast:message
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
}

#pragma mark -- protocolBtnClick
- (void)protocolBtnClick
{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"PrivacyPolicy" ofType:@".docx"];
    MeWebView *meWebView = [[MeWebView alloc] init];
    meWebView.webUrl = str;
    meWebView.navTitle = @"使用条款和隐私政策";
    [self.navigationController pushViewController:meWebView animated:YES];
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

#pragma mark -- 获得焦点后改变背景
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.phoneText == textField)
    {
        self.phoneLine.image = [UIImage imageNamed:@"hover line"];
        self.settingLine.image = [UIImage imageNamed:@"line"];
        self.verificationLine.image = [UIImage imageNamed:@"line"];
        self.nameLine.image = [UIImage imageNamed:@"line"];
    }
    else if(self.verificationText == textField)
    {
        self.phoneLine.image = [UIImage imageNamed:@"line"];
        self.settingLine.image = [UIImage imageNamed:@"line"];
        self.verificationLine.image = [UIImage imageNamed:@"hover line"];
        self.nameLine.image = [UIImage imageNamed:@"line"];
    }
    else if(self.settingText == textField)
    {
        self.phoneLine.image = [UIImage imageNamed:@"line"];
        self.settingLine.image = [UIImage imageNamed:@"hover line"];
        self.verificationLine.image = [UIImage imageNamed:@"line"];
        self.nameLine.image = [UIImage imageNamed:@"line"];
    }
    else if(self.nameText == textField)
    {
        self.phoneLine.image = [UIImage imageNamed:@"line"];
        self.settingLine.image = [UIImage imageNamed:@"line"];
        self.verificationLine.image = [UIImage imageNamed:@"line"];
        self.nameLine.image = [UIImage imageNamed:@"hover line"];
    }
}



#pragma mark -- 失去焦点后判定手机号位数
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.text.length > 11)
    {
      
        [self.navigationController.view makeToast:@"输入的不是一个正确的手机号"
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
