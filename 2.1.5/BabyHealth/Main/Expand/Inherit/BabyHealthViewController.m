//
//  BabyHealthViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/28.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "BabyHealthViewController.h"
#import "HomeViewController.h"
#import "TestingViewController.h"
#import "CommunityViewController.h"
#import "MeViewController.h"

@interface BabyHealthViewController ()

@end

@implementation BabyHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeNavigation = [[UINavigationController alloc] initWithRootViewController:home];
    
    TestingViewController *testing = [[TestingViewController alloc] init];
    UINavigationController *testingNavigation = [[UINavigationController alloc] initWithRootViewController:testing];
    
    CommunityViewController *community = [[CommunityViewController alloc] init];
    UINavigationController *communityNavigation = [[UINavigationController alloc] initWithRootViewController:community];
    
    MeViewController *me = [[MeViewController alloc] init];
    UINavigationController *meNavigation = [[UINavigationController alloc] initWithRootViewController:me];
    
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[
                             homeNavigation,
                             testingNavigation,
                             communityNavigation,
                             meNavigation,
                             ];
    
    NSArray *titles = @[@"首页", @"检测",@"社区", @"我的"];
    NSArray *images = @[@"home", @"jiance", @"shequ",@"wo"];

    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[UIImage imageNamed:images[idx]]];
    }];
    
    [self.tabBar setTintColor:[UIColor whiteColor]];
    [self.tabBar setSelectedImageTintColor:[UIColor colorWithRed:252.0f/255.0f green:115.0f/255.0f blue:143.0f/255.0f alpha:1]];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    UIViewController* topVC = self.selectedViewController;
    return [topVC preferredStatusBarStyle];
    
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
