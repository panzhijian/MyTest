//
//  About.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/10.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "About.h"
#import "Feedback.h"
#import "MeWebView.h"

@implementation About

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = BG_COLOR;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"意见反馈",@"去评分", nil];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(284), AUTO_MATE_HEIGHT(68), AUTO_MATE_WIDTH(180), AUTO_MATE_HEIGHT(180))];
    headerImageView.image = [UIImage imageNamed:@"LOGO"];
    [self.view addSubview:headerImageView];

    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(270), AUTO_MATE_WIDTH(750.0), AUTO_MATE_HEIGHT(30))];
    versionLabel.text = [NSString stringWithFormat:@"当前版本 %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:15.0f];
    versionLabel.textColor = ME_TXT_COLOR;
    [self.view addSubview:versionLabel];
    
    
    self.aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, AUTO_MATE_HEIGHT(400), VIEW_SIZE.width, AUTO_MATE_HEIGHT(200)) style:UITableViewStyleGrouped];
    self.aboutTableView.delegate = self;
    self.aboutTableView.dataSource = self;
    self.aboutTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.aboutTableView];
    
    UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    useBtn.frame = CGRectMake(AUTO_MATE_WIDTH(184), AUTO_MATE_HEIGHT(1064), AUTO_MATE_WIDTH(380), AUTO_MATE_HEIGHT(20));
    [useBtn setTitleColor:CELL_TXT_COLOR forState:UIControlStateNormal];
    [useBtn setTitle:@"《我是宝宝使用条款》" forState:UIControlStateNormal];
    useBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [useBtn addTarget:self action:@selector(useBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:useBtn];
    
    UIButton *scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreBtn.frame = CGRectMake(AUTO_MATE_WIDTH(140), AUTO_MATE_HEIGHT(1104), AUTO_MATE_WIDTH(500), AUTO_MATE_HEIGHT(20));
    scoreBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [scoreBtn setTitleColor:CELL_TXT_COLOR forState:UIControlStateNormal];
    [scoreBtn setTitle:@"《我是宝宝-便便检测服务条款》" forState:UIControlStateNormal];
    [scoreBtn addTarget:self action:@selector(scoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreBtn];
    
    UIButton *informedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    informedBtn.frame = CGRectMake(AUTO_MATE_WIDTH(140), AUTO_MATE_HEIGHT(1144), AUTO_MATE_WIDTH(500), AUTO_MATE_HEIGHT(20));
    informedBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [informedBtn setTitleColor:CELL_TXT_COLOR forState:UIControlStateNormal];
    [informedBtn setTitle:@"《我是宝宝-便便检测知情同意书》" forState:UIControlStateNormal];
    [informedBtn addTarget:self action:@selector(informedBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:informedBtn];
}

#pragma mark -- 修改tableview自带的线条不能填充满
-(void)viewDidLayoutSubviews {
    
    if ([self.aboutTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.aboutTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.aboutTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.aboutTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO_MATE_HEIGHT(100);
}

#pragma mark -- 返回头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AUTO_MATE_HEIGHT(10);
}

#pragma mark -- 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *settingCell = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
    }
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            Feedback *feed = [[Feedback alloc] init];
            [self.navigationController pushViewController:feed animated:YES];
        }
            break;
        case 1:
        {
            //去评分，创建APPStroe项目后才能获取到对应的ID和URL
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/beyondfoto/id1143765129"]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- 修改tableview自带的线条不能填充满
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


#pragma mark -- useBtnClick
- (void)useBtnClick
{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"PrivacyPolicy" ofType:@"docx"];
    MeWebView *meWebView = [[MeWebView alloc] init];
    meWebView.webUrl = str;
    meWebView.navTitle = @"使用条款和隐私政策";
    [self.navigationController pushViewController:meWebView animated:YES];
}

#pragma mark -- scoreBtnClick
- (void)scoreBtnClick
{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"ServiceAgreement" ofType:@"docx"];
    MeWebView *meWebView = [[MeWebView alloc] init];
    meWebView.webUrl = str;
    meWebView.navTitle = @"便便检测服务协议";
    [self.navigationController pushViewController:meWebView animated:YES];
    
}

#pragma mark -- informedBtnBtnClick
- (void)informedBtnBtnClick
{

    NSString *str = [[NSBundle mainBundle] pathForResource:@"InformedConsent" ofType:@"docx"];
    MeWebView *meWebView = [[MeWebView alloc] init];
    meWebView.webUrl = str;
    meWebView.navTitle = @"便便检测知情同意书";
    [self.navigationController pushViewController:meWebView animated:YES];
}
#pragma mark --隐藏和显示tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}
@end
