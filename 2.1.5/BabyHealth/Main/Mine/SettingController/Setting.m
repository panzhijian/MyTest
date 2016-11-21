//
//  Setting.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "Setting.h"
#import "SettingCell.h"
#import "RetrieveViewController.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "LoginViewController.h"
#import "About.h"
#import "BPush.h"
#import "ModifyPasswordViewController.h"
#import "ModifyMobliePhoneController.h"

@interface Setting ()
{
    UIAlertView *removeCacheAlert;
    UIAlertView *logoutAlert;
}
@property(nonatomic,strong)UsersModel *users;

@end

@implementation Setting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"修改手机号",@"修改密码",@"我是宝宝推荐消息",@"新的评论提醒",@"新的赞提醒",@"清除缓存",@"关于",@"退出登录", nil];
    
    self.settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 160)) style:UITableViewStyleGrouped];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    self.settingTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.settingTableView];
}

#pragma mark -- 修改tableview自带的线条不能填充满
-(void)viewDidLayoutSubviews {
    
    if ([self.settingTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.settingTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.settingTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.settingTableView setLayoutMargins:UIEdgeInsetsZero];
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
    if(indexPath.row == 1 || indexPath.row == 4)
    {
        return AUTO_MATE_HEIGHT(120);
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
        static NSString *settingCell = @"settingCell";
        SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if(!cell)
        {
            cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.detailTextLabel.text= [XBJAppHelper SQLUser].mobile;;
        
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    else if(indexPath.row == 1)
    {
        static NSString *settingCell = @"settingCell";
        SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if(!cell)
        {
            cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        cell.rightImage.image = [UIImage imageNamed:@"jiantou3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if(indexPath.row == 2 || indexPath.row == 3)
    {
        static NSString *settingCell = @"settingButtonCell";
        SettingButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if(!cell)
        {
            cell = [[SettingButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        
        //请求成功后将数据更新到本地
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 2:
                cell.settingSwitch.on = [users.myPushState boolValue];
                break;
            case 3:
                cell.settingSwitch.on = [users.commentState boolValue];
                break;
                
            default:
                break;
        }
        cell.indexNumber = indexPath.row;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if(indexPath.row == 4)
    {
        static NSString *settingCell = @"settingButtonCell";
        SettingButtonDouble *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if(!cell)
        {
            cell = [[SettingButtonDouble alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        
        //请求成功后将数据更新到本地
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        cell.settingSwitch.on = [users.upState boolValue];
        cell.indexNumber = indexPath.row;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        static NSString *settingCell = @"settingButtonCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        
        cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textColor = ME_TXT_COLOR;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
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

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            
            
            UIStoryboard  *LoginAndRegistStoryBoard=  [UIStoryboard storyboardWithName:@"LoginAndRegist" bundle:[NSBundle mainBundle]];
            
            ModifyMobliePhoneController *modifyVC=[LoginAndRegistStoryBoard instantiateViewControllerWithIdentifier:@"ModifyMobliePhoneController" ];
            [modifyVC setModifyMobilePhoneBlock: ^(NSString *mobilePhone){
                
                SettingCell *cell=[tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text=mobilePhone;
                
                QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
                self.users = [[qiao selectAllFromTable] lastObject];
                self.users.mobile = mobilePhone;
                [qiao updateDataWithModel:self.users];
                
            }];
            
            
            
            [self.navigationController pushViewController:modifyVC animated:YES];

            
        }
             break;
        case 1:
        {
//            RetrieveViewController *retrieve = [[RetrieveViewController alloc] init];
//            [self.navigationController pushViewController:retrieve animated:YES];
            ModifyPasswordViewController *modifyVC = [[ModifyPasswordViewController alloc] init];
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
            break;
        case 5:
        {
            removeCacheAlert = [[UIAlertView alloc] initWithTitle:@"消息提示" message:@"清除缓存需重新登录!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [removeCacheAlert show];
        }
            break;
        case 6:
        {
            About *bout = [[About alloc] init];
            [self.navigationController pushViewController:bout animated:YES];
        }
            break;
        case 7:
        {
            
            logoutAlert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [logoutAlert show];
        
            
        }
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == removeCacheAlert) {
        
        if(buttonIndex == 0)
        {
            //跳转到登陆界面
            LoginViewController *login = [[LoginViewController alloc] init];
            login.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:login animated:YES];
            
            //读取数据库
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
            [qiao truacateMyTable];
        }
    }
    
    else {
        
        if (buttonIndex == 1) {
            //跳转到登陆界面
            LoginViewController *login = [[LoginViewController alloc] init];
            login.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:login animated:YES];
            
            //读取数据库
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
            [qiao truacateMyTable];
        }
    }
    
}

#pragma mark --隐藏和显示tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -- 开关按钮返回的值
- (void)returnSwitchValue:(NSInteger)indexNumber switchValue:(BOOL)value
{
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[users.customerId integerValue]] forKey:@"customerId"];
    
    NSString *strUrl = @"";
    
    switch (indexNumber) {
        case 2:
        {
            strUrl = POST_UPDATE_CUSTOMER_PUSH;
            [dict setObject:[NSNumber numberWithBool:value] forKey:@"pushNotice"];
        }
            break;
        case 3:
        {
            strUrl = POST_UPDATE_CUSTOMER_COMMENT;
            [dict setObject:[NSNumber numberWithBool:value] forKey:@"commentNotice"];
        }
            break;
        case 4:
        {
            strUrl = POST_UPDATE_CUSTOMER_UP;
            [dict setObject:[NSNumber numberWithBool:value] forKey:@"upNotice"];
        }
            break;
        default:
            break;
    }
    
    [session GET:strUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([[responseObject objectForKey:@"result"]isEqualToString:@"SUCCESS"])
        {
            
            //将更新好的状态记录到本地数据库
            switch (indexNumber) {
                case 2:
                {
                    users.myPushState = [NSString stringWithFormat:@"%d",value];
                    
                    [qiao updateDataWithModel:users];
                    
                    if([users.myPushState doubleValue])
                    {
                    }
                    else
                    {
                        [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {
                        }];
                    }
                }
                    break;
                case 3:
                {
                    users.commentState = [NSString stringWithFormat:@"%d",value];
//                    [qiao updateDataWithModelWhereColName:@"_customerId" colName:@"_commentState" colValue:[NSString stringWithFormat:@"%d",value] whereValue:users.customerId];
                    [qiao updateDataWithModel:users];
                }
                    break;
                case 4:
                {
                    users.upState = [NSString stringWithFormat:@"%d",value];
//                    [qiao updateDataWithModelWhereColName:@"_customerId" colName:@"_upState" colValue:[NSString stringWithFormat:@"%d",value] whereValue:users.customerId];
                    [qiao updateDataWithModel:users];
                }
                    break;
                default:
                    break;
            }
        }
        
        [self.settingTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
