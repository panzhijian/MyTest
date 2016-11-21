//
//  XBJProtocolViewController.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/29.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJProtocolViewController.h"
#import "MeWebView.h"
@interface XBJProtocolViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XBJProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableView delegate/dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSString *text;
    if(indexPath.row==0){
        text = @"《我是宝宝-便便检测服务条款》";
    }else{
        text = @"《我是宝宝-便便检测知情同意书》";
    }
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        NSString *str = [[NSBundle mainBundle] pathForResource:@"ServiceAgreement" ofType:@"docx"];
        MeWebView *meWebView = [[MeWebView alloc] init];
        meWebView.webUrl = str;
        meWebView.navTitle = @"便便检测服务协议";
        [self.navigationController pushViewController:meWebView animated:YES];
    }else{
        NSString *str = [[NSBundle mainBundle] pathForResource:@"InformedConsent" ofType:@"docx"];
        MeWebView *meWebView = [[MeWebView alloc] init];
        meWebView.webUrl = str;
        meWebView.navTitle = @"便便检测知情同意书";
        [self.navigationController pushViewController:meWebView animated:YES];
    }
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
