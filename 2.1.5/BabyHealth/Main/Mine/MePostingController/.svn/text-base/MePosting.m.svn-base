//
//  MePosting.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MePosting.h"
#import "MeCommunityCell.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "PostingModel.h"
#import "PostDetails.h"

@implementation MePosting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发帖";
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.postingArray = [[NSMutableArray alloc] init];
    
    self.postingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 160)) style:UITableViewStyleGrouped];
    self.postingTableView.delegate = self;
    self.postingTableView.dataSource = self;
    self.postingTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.postingTableView];
    
    if([self.postingArray  count] > 0)
    {
        [self.postingArray removeAllObjects];
    }
}

- (void)createMePostingSource
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在加载";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[users.customerId integerValue]] forKey:@"customerId"];
    
    NSDictionary *dict1 = @{@"page":@"1",@"pageSize":@"1000",@"filter":@{@"logic":@"and",@"filters":[NSArray array]},@"sort":@[@{@"field":@"createTime",@"dir":@"asc"}]};
    
    [dict setObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]forKey:@"json"];
    
    [session GET:POST_ARTICLE parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(![[responseObject objectForKey:@"content"] isKindOfClass:[NSNull class]])
        {
            for(NSDictionary *dict in [responseObject objectForKey:@"content"])
            {
                PostingModel *posting = [[PostingModel alloc] init];
                posting.articleId = [[dict objectForKey:@"articleId"] integerValue];
                posting.articleName = [dict objectForKey:@"articleName"];
                posting.articleState = [dict objectForKey:@"articleState"];
                posting.browseNum = [[dict objectForKey:@"browseNum"] integerValue];
                posting.commentNum = [[dict objectForKey:@"commentNum"] integerValue];
                posting.content = [dict objectForKey:@"content"];
                posting.createTime = [dict objectForKey:@"createTime"];
                
                [self.postingArray addObject:posting];
            }
        }
        
        [self.postingTableView reloadData];
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];

    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([self.postingArray count] > 0)
    {
        [self.postingArray removeAllObjects];
    }
    [self performSelector:@selector(createMePostingSource)];
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postingArray count];
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO_MATE_HEIGHT(120);
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
    MeCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:sampleCell];
    if(!cell)
    {
        cell = [[MeCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sampleCell];
    }
    
    PostingModel *posting = [self.postingArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = posting.articleName;
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",posting.commentNum];
    cell.browseLabel.text = [NSString stringWithFormat:@"%ld",posting.browseNum];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    PostingModel *posting = [self.postingArray objectAtIndex:indexPath.row];
    
    PostDetails *post = [[PostDetails alloc] init];
    post.navTitle = @"帖子";
    post.webUrl = [NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",posting.articleId,[users.customerId integerValue]];
    
    [self.navigationController pushViewController:post animated:YES];
}

@end
