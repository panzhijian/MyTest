//
//  XBJSubmitSuccessViewController.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJSubmitSuccessViewController.h"
#import "SampleInformation.h"

@interface XBJSubmitSuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation XBJSubmitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交成功";
}
- (IBAction)confirmBtnAction:(id)sender {
    
    SampleInformation *sample = [[SampleInformation alloc] init];
    [self.navigationController pushViewController:sample animated:YES];
    
    NSArray *vcs = self.navigationController.viewControllers;
    
    NSMutableArray *newvcs = [[NSMutableArray alloc] initWithObjects:vcs.firstObject,vcs.lastObject, nil];
    self.navigationController.viewControllers = newvcs;
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
