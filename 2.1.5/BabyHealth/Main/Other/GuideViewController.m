//
//  GuideViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
    self.title = @"返回";
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0),AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001),AUTO_MATE_HEIGHT(VIEW_SIZE.height - 98))];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for(int i = 0 ;i < 4;i++)
    {
        NSArray *array = @[@"GPbg1",@"GPbg2",@"GPbg3",@"GPbg4"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*VIEW_SIZE.width, -20, AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(1334))];
        imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(4*VIEW_SIZE.width, 0);
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width / 2 - 60), AUTO_MATE_HEIGHT(VIEW_SIZE.height - 182), AUTO_MATE_WIDTH(100), AUTO_MATE_HEIGHT(30))];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1];
    [self.pageControl addTarget:self action:@selector(pageControlClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(VIEW_SIZE.height - 98),VIEW_SIZE.width / 2, AUTO_MATE_HEIGHT(98));
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor colorWithRed:254.0f/255.0f green:115.0f/255.0f blue:141.0f/255.0f alpha:1];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(VIEW_SIZE.width / 2, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 98), VIEW_SIZE.width / 2, AUTO_MATE_HEIGHT(98));
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:212.0f/255.0f blue:215.0f/255.0f alpha:1];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark -- loginBtnClick
- (void)loginBtnClick
{
    self.navigationController.navigationBar.hidden = NO;
    
    LoginViewController *login = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:login animated:YES];
    NSLog(@"登陆界面");
}

#pragma mark -- registerBtnClick
- (void)registerBtnClick
{
    self.navigationController.navigationBar.hidden = NO;
    
    RegisterViewController *regis = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regis animated:YES];
    NSLog(@"注册界面");
}

#pragma mark -- pageControlClick
- (void)pageControlClick
{
    
    
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * VIEW_SIZE.width, 0);
}

#pragma mark -- scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
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
