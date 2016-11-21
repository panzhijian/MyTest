//
//  SampleInformation.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "SampleInformation.h"
#import "SampleCell.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "SampleModel.h"
#import "NSString+Date.h"
#import "MJExtension.h"
#import "XBJReportViewController.h"

@implementation SampleInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的样本信息";
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.sampleArray = [[NSMutableArray alloc] init];
    
    self.sampleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 160)) style:UITableViewStyleGrouped];
    self.sampleTableView.delegate = self;
    self.sampleTableView.dataSource = self;
    self.sampleTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.sampleTableView];
    
    [self performSelector:@selector(SampleInformationSource)];
}

- (void)SampleInformationSource
{
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    if([users.babyId integerValue] == 0)
    {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在加载";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:POST_REPORTS parameters:@{@"babyId":[NSNumber numberWithInteger:[users.babyId integerValue]]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for(NSDictionary *dict in [responseObject objectForKey:@"data"])
        {
            SampleModel *sample = [SampleModel objectWithKeyValues:dict];
            
            [self.sampleArray addObject:sample];
        }
        
        [self.sampleTableView reloadData];
        [hud hideAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];
        
        
        //
        
   
    }];
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sampleArray count];
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO_MATE_HEIGHT(166);
}

#pragma mark -- 返回头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return AUTO_MATE_HEIGHT(10);
}

#pragma mark -- 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sampleCell = @"sampleCell";
    SampleCell *cell = [tableView dequeueReusableCellWithIdentifier:sampleCell];
    if(!cell)
    {
        cell = [[SampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sampleCell];
    }
    
    SampleModel *samlpe = [self.sampleArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [NSString stringWithFormat:@"样本编号:%@",samlpe.sampleCode];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",samlpe.collectTime];
    if(samlpe.reportTime)
    {
        cell.rightImage.image = [UIImage imageNamed:@"jiance icon"];
    }
    else {
        cell.rightImage.image = [UIImage imageNamed:@""];
    }
    
    return cell;
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleModel *samlpe = [self.sampleArray objectAtIndex:indexPath.row];
    if(samlpe.reportTime)
    {
        SampleModel *samlpe = [self.sampleArray objectAtIndex:indexPath.row];
        XBJReportViewController *vc = [[XBJReportViewController alloc] init];
        vc.sampleCode = samlpe.sampleCode;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController.view makeToast:@"检测报告未出,请耐心等待"
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }
}

@end
