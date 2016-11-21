//
//  LoginViewController.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : XBJBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *passwordText;

@property(nonatomic,strong)UIImageView *phoneLine;
@property(nonatomic,strong)UIImageView *passwordLine;

@property(nonatomic,strong)UILabel *loginTitle;

@end
