//
//  RegisterViewController.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;

@interface RegisterViewController : XBJBaseViewController<UITextFieldDelegate>
{
    //设置重新倒计时的秒数
    NSInteger _number;
    //判断是否在60秒内就点了一次  默认是NO
    BOOL _isFirstNumer;
}

@property(nonatomic,strong)TPKeyboardAvoidingScrollView *viewScroll;
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *verificationText;
@property(nonatomic,strong)UITextField *settingText;
@property(nonatomic,strong)UITextField *nameText;
@property(nonatomic,strong)UIButton *protocolBtn;
@property(nonatomic,strong)UIImageView *phoneLine;
@property(nonatomic,strong)UIImageView *verificationLine;
@property(nonatomic,strong)UIImageView *settingLine;
@property(nonatomic,strong)UIImageView *nameLine;
@property(nonatomic,strong)UIImageView *rightImage;
@property(nonatomic,strong)UILabel *registerTitle;
@property(nonatomic,strong)UIButton *verificationBtn;

@end
