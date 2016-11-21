//
//  UpdateMeInformation.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "UpdateMeInformation.h"

@implementation UpdateMeInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = BG_COLOR2;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.updateText = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    self.updateText.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.updateText];

    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(100), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(2))];
    lineImage.backgroundColor = RGB(221, 222, 223);
    [self.view addSubview:lineImage];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"zuojiantou"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 16, 20);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"保存" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    addBtn.frame = CGRectMake(0,0,AUTO_MATE_WIDTH(100),AUTO_MATE_HEIGHT(30));

//    addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addBtnItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.updateText.text = @" ";
    
    if([self.updateTitle isEqualToString:@"修改生日"] && self.updateText)
    {
        self.updateText.text = @"";
        self.updateText.placeholder = @"请输入以下格式:xxxx-xx-xx";
    }
    else
    {
        self.updateText.placeholder = @"";
        self.updateText.text = self.updateValue;
    }
    
    self.title = self.updateTitle;
    
    [self.updateText resignFirstResponder];
}

- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick
{
    if(self.updateIndex == 1)
    {
        if(self.updateText.text.length != 11)
        {
          
            [self.navigationController.view makeToast:@"输入的手机信息有误"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            return;
        }
    }
    [self.delegate returnUpdateMeinformationValue:self.updateText.text updateIndex:self.updateIndex];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
