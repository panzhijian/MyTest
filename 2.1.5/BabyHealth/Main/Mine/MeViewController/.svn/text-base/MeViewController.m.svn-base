//
//  MeViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeViewController.h"
#import "MeDetailCell.h"
#import "MeTopDetailCell.h"
#import "MeInformation.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "UIImageView+AFNetworking.h"
#import "BabyInformation.h"
#import "SampleInformation.h"
#import "MePosting.h"
#import "MeCollection.h"
#import "Setting.h"
#import "UMSocial.h"
#import "NSString+Date.h"
#import "MBProgressHUD.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPointsSource];

    self.title = @"我的";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.isSignSate = NO;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = color;
    
    self.meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height) style:UITableViewStyleGrouped];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.meTableView];
    
    self.titleArray = [[NSMutableArray alloc] initWithObjects:@"",@"宝宝信息",@"我的样本信息",@"我的发帖",@"我的收藏",@"我的积分",@"分享我是宝宝给好友",@"设置", nil];
    
    
    
    self.imageArray = [[NSArray alloc] initWithObjects:@"",@"bbinfo",@"sample",@"post",@"collect",@"points",@"share40x40",@"set up", nil];
    
}

- (void)getPointsSource
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在加载";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    [session GET:POST_POINTS parameters:@{@"customerId":[NSNumber numberWithInteger:[users.customerId integerValue]]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [hud hideAnimated:YES];

        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            self.points = [[responseObject objectForKey:@"data"] integerValue];
            [self.meTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        [hud hideAnimated:YES];

    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取用户积分
    // 2016-10-25 时攀 将刷新放到下面self.isSignSate发生变化时使用,解决签到逻辑问题
   // [self.meTableView reloadData];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    if(users.qianDate)
    {
        NSDate *earlier_date = [[NSString stringDateFromString:users.qianDate] earlierDate:[NSDate date]];
        if([earlier_date isEqualToDate:[NSString stringDateFromString:users.qianDate]])
        {
            self.isSignSate = YES;
        }
        else
        {
            self.isSignSate = NO;
        }
    }
    else
    {
        self.isSignSate = NO;
    }
    [self.meTableView reloadData];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];


  
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:users.customerId forKey:@"customerId"];
    ///获取签到状态
    [manager GET:POST_SIGN_STATE parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            self.isSignSate = YES;
            [self.meTableView reloadData];
        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {


    }];
    
}

-(void)viewDidLayoutSubviews {
    
    if ([self.meTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.meTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.meTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.meTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return AUTO_MATE_HEIGHT(218);
    }
    else if(indexPath.row != 3 && indexPath.row != 6 &&indexPath.row != 7)
    {
        return AUTO_MATE_HEIGHT(118);
    }
    else
    {
        return AUTO_MATE_HEIGHT(100);
    }
}

#pragma mark -- 返回头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AUTO_MATE_HEIGHT(10);
}

#pragma mark -- 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        static NSString *meCell = @"meCell";
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCell];
        if(!cell)
        {
            cell = [[MeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meCell];
        }
        
        //读取数据库
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        
        [cell.headerImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP_2,users.avatarImg]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        cell.nameLabel.text = users.nickName;
        cell.addressLabel.text = [NSString stringWithFormat:@"%@%@",users.province,users.city];
        cell.delegate = self;
        if(self.isSignSate)
        {
            cell.signBtn.userInteractionEnabled = NO;
            cell.signBtn.backgroundColor = BG_COLOR;
            [cell.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if(indexPath.row != 3 && indexPath.row != 6)
    {
        static NSString *detailCell = @"detailCell";
        MeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell];
        if(!cell)
        {
            cell = [[MeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCell];
        }
        
        cell.headerImage.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        if(indexPath.row != 5)
        {
            cell.rightLabel.hidden = YES;
            cell.rightImage.hidden = NO;
        }
        else
        {
            cell.rightLabel.hidden = NO;
            cell.rightImage.hidden = YES;
            cell.rightLabel.text = [NSString stringWithFormat:@"%ld",self.points];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *detailTopCell = @"detailTopCell";
        MeTopDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTopCell];
        if(!cell)
        {
            cell = [[MeTopDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailTopCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        cell.headerImage.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  2016-9.29 时攀 push到下一页面都加了隐藏底部操作xxx.hidesBottomBarWhenPushed = yes
    switch (indexPath.row) {
        case 0:
        {
            MeInformation *information = [[MeInformation alloc] init];
            information.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:information animated:YES];
        }
            break;
        case 1:
        {
            BabyInformation *baby = [[BabyInformation alloc] init];
            baby.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:baby animated:YES];
        }
            break;
        case 2:
        {
            SampleInformation *sample = [[SampleInformation alloc] init];
            sample.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sample animated:YES];
        }
            break;
        case 3:
        {
            MePosting *posting = [[MePosting alloc] init];
            posting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:posting animated:YES];
        }
            break;
        case 4:
        {
            MeCollection *collection = [[MeCollection alloc] init];
            collection.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collection animated:YES];
        }
            break;
        case 6:
        {
            
            NSString * url =@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8";
            
            [UMSocialData defaultData].extConfig.title = @"我是宝宝";
            
            [UMSocialData defaultData].extConfig.wechatSessionData.title = @"我是宝宝";
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
            
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"我是宝宝";
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            
            [UMSocialData defaultData].extConfig.qqData.title = @"我是宝宝";
            [UMSocialData defaultData].extConfig.qqData.url = url;
            
            
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMENG_KEY
                                              shareText:@"我正在使用我是宝宝APP，下载地址https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8 "
                                             shareImage:[UIImage imageNamed:@"icon"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                               delegate:nil];
        }
            break;
        case 7:
        {
            Setting *seting = [[Setting alloc] init];
            seting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:seting animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)showNewMeView:(UIButton *)btn
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在签到";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:users.customerId forKey:@"customer.customerId"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"state"];
    
    [manager GET:POST_SAVE_SIGN parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
    
            [self.navigationController.view makeToast:@"签到成功,积分+10"
                                             duration:1.0
                                             position:CSToastPositionCenter];
            
            btn.userInteractionEnabled = NO;
            btn.backgroundColor = BG_COLOR;
            [btn setTitle:@"已签到" forState:UIControlStateNormal];
            self.isSignSate = YES;
            users.qianDate = [NSString stringDateFromDate:[NSDate date]];
            [qiao updateDataWithModel:users];
            
            [self performSelectorOnMainThread:@selector(setPointsCustomerID:) withObject:[NSNumber numberWithInteger:[users.customerId integerValue]]  waitUntilDone:nil];
        }
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
        
        [hud hideAnimated:YES];
    }];
}

- (void)setPointsCustomerID:(NSNumber *)customerID
{
    AFHTTPSessionManager *manmager = [[AFHTTPSessionManager alloc] init];
    [manmager GET:POST_ADD_POINTS parameters:@{@"customerId":customerID,@"point":[NSNumber numberWithInt:10]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //获取用户积分
        [self performSelector:@selector(getPointsSource)];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
