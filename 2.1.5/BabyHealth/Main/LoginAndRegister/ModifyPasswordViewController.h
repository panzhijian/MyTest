//
//  ModifyPasswordViewController.h
//  BabyHealth
//
//  Created by xingzhi on 16/8/31.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"

@interface ModifyPasswordViewController : XBJBaseViewController

@property(nonatomic,strong)UITextField *firstpassword;
@property(nonatomic,strong)UIImageView *firstLine;
@property(nonatomic,strong)UITextField *secondPassword;
@property(nonatomic,strong)UIImageView *secondLine;
@property(nonatomic,strong)UITextField *againPassword;
@property(nonatomic,strong)UIImageView *againLine;
@property(nonatomic,strong)UILabel *loginTitle;

@end
