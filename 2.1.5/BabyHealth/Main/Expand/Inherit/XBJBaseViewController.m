//
//  XBJBaseViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface XBJBaseViewController ()

@end

@implementation XBJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addLeftBarButtonWithTitle:nil color:nil normal:@"zuojiantou" highLight:@"zuojiantou" action:@selector(goBack) target:self];
    
    self.view.backgroundColor =RGB(244, 239, 242) ;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)showAlertWith:(NSString *)text
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showToastWith:(NSString *)text
{
    [self.navigationController.view makeToast:text
                                     duration:1.5
                                     position:CSToastPositionCenter];
}


- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
