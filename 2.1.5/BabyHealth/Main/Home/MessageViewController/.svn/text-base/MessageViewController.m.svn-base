//
//  MessageViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/30.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MessageViewController.h"
#import "NoticeCell.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "PostingModel.h"
#import "NSString+Date.h"
#import "UIImageView+AFNetworking.h"
#import "MessageModel.h"
#import "PostDetails.h"
#import "MJRefresh.h"
#import "NSString+FontSize.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = BG_COLOR;
    
    self.commentArray = [[NSMutableArray alloc] init];
    self.likeArray= [[NSMutableArray alloc] init];
    self.noticeArray = [[NSMutableArray alloc] init];
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if([self performSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.noticeBtn.frame = CGRectMake(AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(80));
    [self.noticeBtn setTitle:@"通知" forState:UIControlStateNormal];
    [self.noticeBtn setTitleColor:TXT_RED_COLOR forState:UIControlStateNormal];
    self.noticeBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.noticeBtn];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(AUTO_MATE_WIDTH(306), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(80));
    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentBtn];
    
    self.btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(110), AUTO_MATE_HEIGHT(12), AUTO_MATE_WIDTH(12), AUTO_MATE_HEIGHT(12))];
    self.btnImage.image = [UIImage imageNamed:@"circle"];
    self.btnImage.hidden = YES;
    [self.commentBtn addSubview:self.btnImage];
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likeBtn.frame = CGRectMake(AUTO_MATE_WIDTH(482), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(80));
    [self.likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.likeBtn];
    
    self.likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(110), AUTO_MATE_HEIGHT(12), AUTO_MATE_WIDTH(12), AUTO_MATE_HEIGHT(12))];
    self.likeImage.image = [UIImage imageNamed:@"circle"];
    self.likeImage.hidden = YES;
    [self.likeBtn addSubview:self.likeImage];

    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(80), AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(2))];
    self.lineLabel.backgroundColor = TXT_RED_COLOR;
    [self.view addSubview:self.lineLabel];
    
    self.noticeTable = [[UITableView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001), SCREEN_HEIGHT-AUTO_MATE_HEIGHT(82)) style:UITableViewStylePlain];
    self.noticeTable.delegate = self;
    self.noticeTable.dataSource = self;
    self.noticeTable.backgroundColor = RGB(240, 234, 238);
    self.noticeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.noticeTable];
    
    self.commentTable = [[UITableView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001), AUTO_MATE_HEIGHT(SCREEN_HEIGHT-82)) style:UITableViewStylePlain];
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    self.commentTable.hidden = YES;
    self.commentTable.backgroundColor = RGB(240, 234, 238);
    self.commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    static int commentPageCurrent = 1;
    
    __unsafe_unretained typeof (self)vc = self;
    
    [self.commentTable addHeaderWithCallback:^{
        if(self.commentArray.count > 0)
        {
            [vc.commentArray removeAllObjects];
        }
        
        commentPageCurrent = 1;
        
        [vc performSelector:@selector(createCommentSource:)withObject:[NSNumber numberWithInt:commentPageCurrent]];
        
        [vc.commentTable headerEndRefreshing];
    }];
    
    [self.commentTable addFooterWithCallback:^{
        
        commentPageCurrent++;
        
        [vc performSelector:@selector(createCommentSource:)withObject:[NSNumber numberWithInt:commentPageCurrent]];
        
        [vc.commentTable footerEndRefreshing];
        
    }];
    
    [self.view addSubview:self.commentTable];
    
    self.likeTable = [[UITableView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001),SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.likeTable.delegate = self;
    self.likeTable.dataSource = self;
    self.likeTable.hidden = YES;
    self.likeTable.backgroundColor = RGB(240, 234, 238);
    self.likeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    static int likePageCurrent = 1;
    
    [self.likeTable addHeaderWithCallback:^{
        if(self.likeArray.count > 0)
        {
            [vc.likeArray removeAllObjects];
        }
        
        likePageCurrent = 1;
        
        [vc performSelector:@selector(createMePostingSource:)withObject:[NSNumber numberWithInt:likePageCurrent]];
        
        [vc.likeTable headerEndRefreshing];
    }];
    
    [self.likeTable addFooterWithCallback:^{
        
        likePageCurrent++;
        
        [vc performSelector:@selector(createMePostingSource:)withObject:[NSNumber numberWithInt:likePageCurrent]];
        
        [vc.likeTable footerEndRefreshing];
        
    }];
    
    [self.view addSubview:self.likeTable];
    
    if(VIEW_SIZE.height > 568)
    {
        self.noticeTable.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001), AUTO_MATE_HEIGHT(1050));
        self.commentTable.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001), AUTO_MATE_HEIGHT(1050));
        self.likeTable.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(82), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.001), AUTO_MATE_HEIGHT(1050));
    }
    
    //获取通知内容
    [self performSelector:@selector(getUsersNotificationMessage)];
}

#pragma mark -- 获取通知内容
- (void)getUsersNotificationMessage
{
    if([self.noticeArray count] > 0)
    {
        [self.noticeArray removeAllObjects];
    }
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"MessageModel" modelClass:[MessageModel class]];
    self.noticeArray = [[NSMutableArray alloc] initWithArray:[qiao selectAllFromTable]];
    [self.noticeTable reloadData];
}

#pragma mark -- 返回显示多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.commentTable)
    {
        return [self.commentArray count];
    }
    else if(tableView == self.likeTable)
    {
        return [self.likeArray count];
    }
    else
    {
        return [self.noticeArray count];
    }
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if (tableView == self.noticeTable) {
        MessageModel *message = [self.noticeArray objectAtIndex:indexPath.row];
        size = [message.count sizeWithFont:FONT(13) maxSize:CGSizeMake(AUTO_MATE_WIDTH(600), MAXFLOAT)];
        return AUTO_MATE_HEIGHT(116)+size.height;
    }
    
    else if (tableView == self.commentTable) {
        PostingModel *posting = [self.commentArray objectAtIndex:indexPath.row];
        size = [posting.content sizeWithFont:FONT(13) maxSize:CGSizeMake(AUTO_MATE_WIDTH(600), MAXFLOAT)];
    }
    else {
        
//        PostingModel *posting = [self.likeArray objectAtIndex:indexPath.row];
//        size = [posting.content sizeWithFont:FONT(13) maxSize:CGSizeMake(AUTO_MATE_WIDTH(600), MAXFLOAT)];
        size.height = 40;
    }
//    return AUTO_MATE_HEIGHT(116+1)+size.height;//这里面使用加法结果反差很大?
    return AUTO_MATE_HEIGHT(146)+size.height;
}

#pragma mark -- 返回每行数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.noticeTable)
    {
        static NSString *noticeStr = @"noticeStr";
        NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeStr];
        if(!cell)
        {
            cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:noticeStr];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if([self.noticeArray count] != 0)
        {
            MessageModel *model = [self.noticeArray objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = @"我是宝宝团队";
            cell.headImage.image = [UIImage imageNamed:@"LOGO"];
            cell.detailLabel.numberOfLines = 0;
            cell.detailLabel.text = model.count;
            cell.timeLabel.text = model.time;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CGRect frame = cell.titleLabel.frame;
            frame.size.width = [cell.titleLabel.text sizeWithFont:FONT(14) maxSize:CGSizeMake(MAXFLOAT, AUTO_MATE_HEIGHT(30))].width;
            cell.titleLabel.frame = frame;
            
            CGRect frame2 = cell.likeLabel.frame;
            frame2.origin.x = CGRectGetMaxX(cell.titleLabel.frame) + AUTO_MATE_WIDTH(13);
            cell.likeLabel.frame = frame2;
            
            
            cell.nameLabel.hidden = YES;
            CGRect frame3 = cell.detailLabel.frame;
            frame3.size.height = [ cell.detailLabel.text sizeWithFont:FONT(13) maxSize:CGSizeMake(AUTO_MATE_WIDTH(600), MAXFLOAT)].height;
            frame3.origin.y = CGRectGetMaxY(cell.titleLabel.frame)+AUTO_MATE_HEIGHT(30);
            cell.detailLabel.frame = frame3;
            
            CGRect frame4 = cell.line.frame;
            frame4.origin.y = CGRectGetMaxY(cell.detailLabel.frame)+AUTO_MATE_HEIGHT(29);
            cell.line.frame = frame4;
        }
        
        return cell;
    }
    else if(tableView == self.commentTable)
    {
        static NSString *noticeStr = @"commentStr";
        NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeStr];
        if(!cell)
        {
            cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeStr];
        }
        if([self.commentArray count] != 0)
        {
            PostingModel *posting = [self.commentArray objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = posting.nickName;
            [cell.headImage setImageWithURL:[NSURL URLWithString:posting.avatarImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            if(!posting.readAble)
            {
                cell.backgroundColor = [UIColor colorWithRed:216.0f/250.f green:219.0f/250.f blue:222.0f/250.f alpha:1];
            }
            else
            {
                cell.backgroundColor = [UIColor colorWithRed:250.0f/250.f green:250.0f/250.f blue:250.0f/250.f alpha:1];
            }
                cell.likeLabel.text = @"评论你的帖子";
            cell.detailLabel.numberOfLines = 0;
            cell.nameLabel.text = posting.articleName;
            cell.detailLabel.text = posting.content;
            cell.timeLabel.text = posting.createTime;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            CGRect frame = cell.titleLabel.frame;
            frame.size.width = [posting.nickName sizeWithFont:FONT(14) maxSize:CGSizeMake(MAXFLOAT, AUTO_MATE_HEIGHT(30))].width;
            cell.titleLabel.frame = frame;
            
            CGRect frame2 = cell.likeLabel.frame;
            frame2.origin.x = CGRectGetMaxX(cell.titleLabel.frame) + AUTO_MATE_WIDTH(13);
            cell.likeLabel.frame = frame2;
            
            CGRect frame3 = cell.detailLabel.frame;
            frame3.size.height = [posting.content sizeWithFont:FONT(13) maxSize:CGSizeMake(AUTO_MATE_WIDTH(600), MAXFLOAT)].height;
            cell.detailLabel.frame = frame3;
         
            CGRect frame4 = cell.line.frame;
            frame4.origin.y = AUTO_MATE_HEIGHT(146)+frame3.size.height-1;
            cell.line.frame = frame4;
        }
        
        return cell;
    }
    else
    {
        static NSString *noticeStr = @"commentStr";
        NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeStr];
        if(!cell)
        {
            cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeStr];
        }
        
        if([self.likeArray count] != 0)
        {
            PostingModel *posting = [self.likeArray objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = posting.nickName;            
            [cell.headImage setImageWithURL:[NSURL URLWithString:posting.avatarImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            if(!posting.readAble)
            {
                cell.backgroundColor = [UIColor colorWithRed:216.0f/250.f green:219.0f/250.f blue:222.0f/250.f alpha:1];
            }
            else
            {
                cell.backgroundColor = [UIColor colorWithRed:250.0f/250.f green:250.0f/250.f blue:250.0f/250.f alpha:1];
            }
                cell.likeLabel.font = [UIFont systemFontOfSize:13.0f];
            cell.likeLabel.text = @"赞了你的帖子";
            cell.detailLabel.numberOfLines = 2;
            cell.nameLabel.text = posting.articleName;
            cell.detailLabel.text = posting.content;
            cell.timeLabel.text = posting.createTime;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CGRect frame = cell.titleLabel.frame;
            frame.size.width = [posting.nickName sizeWithFont:FONT(14) maxSize:CGSizeMake(MAXFLOAT, AUTO_MATE_HEIGHT(30))].width;
            cell.titleLabel.frame = frame;
            
            CGRect frame2 = cell.likeLabel.frame;
            frame2.origin.x = CGRectGetMaxX(cell.titleLabel.frame) + AUTO_MATE_WIDTH(13);
            cell.likeLabel.frame = frame2;
            
            CGRect frame3 = cell.detailLabel.frame;
            frame3.size.height = 40;
            cell.detailLabel.frame = frame3;
            
            CGRect frame4 = cell.line.frame;
            frame4.origin.y = AUTO_MATE_HEIGHT(146)+frame3.size.height-1;
            cell.line.frame = frame4;
        }

        return cell;
    }
}

//开启Cell滑动
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//启动删除功能
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//删除数据源数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        if(tableView == self.commentTable)
        {
            PostingModel *posting = [self.commentArray objectAtIndex:indexPath.row];
            
            AFHTTPSessionManager *manange = [[AFHTTPSessionManager alloc] init];
            [manange GET:GET_REMOVE_COMMENT parameters:@{@"commentId":[NSNumber numberWithInteger:posting.commentId]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
                {
                    [self.commentArray removeObjectAtIndex:indexPath.row];
                    [self.commentTable reloadData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self.navigationController.view makeToast:error.localizedDescription
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
            }];
        }
        else if (tableView == self.likeTable)
        {
            PostingModel *posting = [self.likeArray objectAtIndex:indexPath.row];
            
            AFHTTPSessionManager *manange = [[AFHTTPSessionManager alloc] init];
            [manange GET:GET_REMOVE_PRAICE parameters:@{@"praiseId":[NSNumber numberWithInteger:posting.praiseId]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
                {
                    [self.likeArray removeObjectAtIndex:indexPath.row];
                    [self.likeTable reloadData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self.navigationController.view makeToast:error.localizedDescription
                                                 duration:1.0
                                                 position:CSToastPositionCenter];
            }];
        }
        else if (tableView == self.noticeTable)
        {
            MessageModel *model = [self.noticeArray objectAtIndex:indexPath.row];
            //读取数据库
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"MessageModel" modelClass:[MessageModel class]];
            [qiao deleteDataWithPrimaryKey:model];
            
            [self.noticeArray removeObjectAtIndex:indexPath.row];
            
            [self.noticeTable reloadData];
        }
    }
}

#pragma mark -- 修改删除英文为中文
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark -- cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.commentTable == tableView)
    {
        //请求成功后将数据更新到本地
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        PostingModel *posting = [self.commentArray objectAtIndex:indexPath.row];
        
        PostDetails *post = [[PostDetails alloc] init];
        post.webUrl = [NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",posting.articleId,[users.customerId integerValue]];
        post.navTitle = @"评论";
        [self.navigationController pushViewController:post animated:YES];
        
        AFHTTPSessionManager *manange = [[AFHTTPSessionManager alloc] init];
        [manange GET:POST_UPDATE_COMMENT_STATE parameters:@{@"commentId":[NSNumber numberWithInteger:posting.commentId]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(![[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]])\
            {
                posting.readAble = YES;
                [self.commentArray replaceObjectAtIndex:indexPath.row withObject:posting];
                
                [self.commentTable reloadData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    else if(self.likeTable == tableView)
    {
        //请求成功后将数据更新到本地
        QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
        
        UsersModel *users = [[qiao selectAllFromTable] lastObject];
        PostingModel *posting = [self.likeArray objectAtIndex:indexPath.row];
        
        PostDetails *post = [[PostDetails alloc] init];
        post.navTitle = @"赞";
        post.webUrl = [NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",posting.articleId,[users.customerId integerValue]];
        [self.navigationController pushViewController:post animated:YES];
        
        AFHTTPSessionManager *manange = [[AFHTTPSessionManager alloc] init];
        [manange GET:POST_UPDATE_PRAICE parameters:@{@"praiseId":[NSNumber numberWithInteger:posting.praiseId]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(![[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]])\
            {
                posting.readAble = YES;
                [self.likeArray replaceObjectAtIndex:indexPath.row withObject:posting];
                
                [self.likeTable reloadData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

#pragma mark -- noticeBtnClick通知
- (void)noticeBtnClick
{
    [UIView animateWithDuration:0.35 animations:^{
        
        CGRect rect = self.lineLabel.frame;
        
        rect.origin.x = self.noticeBtn.frame.origin.x;
        
        self.lineLabel.frame = rect;
        
        [self.noticeBtn setTitleColor:TXT_RED_COLOR forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        
        self.noticeTable.hidden = NO;
        self.commentTable.hidden = YES;
        self.likeTable.hidden = YES;
        
    }];
    
    //获取通知内容
    [self performSelector:@selector(getUsersNotificationMessage)];
}

#pragma mark -- commentBtnClick评论
- (void)commentBtnClick
{
    [UIView animateWithDuration:0.35 animations:^{
        
        CGRect rect = self.lineLabel.frame;
        
        rect.origin.x = self.commentBtn.frame.origin.x;
        
        self.lineLabel.frame = rect;
        
        [self.noticeBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:TXT_RED_COLOR forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        
        self.noticeTable.hidden = YES;
        self.commentTable.hidden = NO;
        self.likeTable.hidden = YES;
    }];
    
    if([self.commentArray count] > 0)
    {
        [self.commentArray removeAllObjects];
    }
    
    [self performSelector:@selector(createCommentSource:)withObject:[NSNumber numberWithInt:1]];
}

#pragma mark -- likeBtnClick赞
- (void)likeBtnClick
{
    [UIView animateWithDuration:0.35 animations:^{
        
        CGRect rect = self.lineLabel.frame;
        
        rect.origin.x = self.likeBtn.frame.origin.x;
        
        self.lineLabel.frame = rect;
        
        [self.noticeBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:TXT_RED_COLOR forState:UIControlStateNormal];
        
        self.noticeTable.hidden = YES;
        self.commentTable.hidden = YES;
        self.likeTable.hidden = NO;
    }];
    
    if([self.likeArray count] > 0)
    {
        [self.likeArray removeAllObjects];
    }
    
    [self performSelector:@selector(createMePostingSource:)withObject:[NSNumber numberWithInt:1]];
}

#pragma mark -- 获取赞信息
- (void)createMePostingSource:(NSNumber *)page
{
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[users.customerId integerValue]] forKey:@"customerId"];
    
    NSDictionary *dict1 = @{@"page":page,@"pageSize":@"10",@"filter":@{@"logic":@"and",@"filters":[NSArray array]},@"sort":@[@{@"field":@"createTime",@"dir":@"asc"}]};
    
    [dict setObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]forKey:@"json"];
    
    [session POST:POST_PRAICE parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject objectForKey:@"content"] > 0)
        {
            for(NSDictionary *responseDict in [responseObject objectForKey:@"content"])
            {
                NSDictionary *topicDict = [responseDict objectForKey:@"topicArticle"];
                NSDictionary *customerDict = [responseDict objectForKey:@"customer"];
                
                PostingModel *postring = [[PostingModel alloc] init];
                postring.articleId = [[topicDict objectForKey:@"articleId"] integerValue];
                postring.createTime = [responseDict objectForKey:@"createTime"];
                postring.articleName = [topicDict objectForKey:@"articleName"];
                postring.content = [topicDict objectForKey:@"content"];
                postring.nickName = [customerDict objectForKey:@"nickName"];
                postring.praiseId = [[responseDict objectForKey:@"praiseId"] integerValue];
                postring.readAble = [[responseDict objectForKey:@"readAble"] boolValue];
                if(![[customerDict objectForKey:@"avatarImg"]isKindOfClass:[NSNull class]])
                {
                    postring.avatarImg = [customerDict objectForKey:@"avatarImg"];
                }
                else
                {
                    postring.avatarImg = @"";
                }
                
                postring.customerId = [[customerDict objectForKey:@"customerId"] integerValue];
                
                [self.likeArray addObject:postring];
            }
        }
        
        [self.likeTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }];
}

#pragma mark -- 获取评论信息
- (void)createCommentSource:(NSNumber *)page
{
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[users.customerId integerValue]] forKey:@"customerId"];
    
    NSDictionary *dict1 = @{@"page":page,@"pageSize":@"10",@"filter":@{@"logic":@"and",@"filters":[NSArray array]},@"sort":@[@{@"field":@"createTime",@"dir":@"asc"}]};
    
    [dict setObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]forKey:@"json"];
    
    
    [session POST:POST_COMMENT parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject objectForKey:@"content"] > 0)
        {
            for(NSDictionary *responseDict in [responseObject objectForKey:@"content"])
            {
                NSDictionary *topicDict = [responseDict objectForKey:@"topicArticle"];
                NSDictionary *customerDict = [responseDict objectForKey:@"customer"];
                
                PostingModel *postring = [[PostingModel alloc] init];
                postring.articleId = [[topicDict objectForKey:@"articleId"] integerValue];
                postring.createTime = [responseDict objectForKey:@"createTime"];
                postring.articleName = [topicDict objectForKey:@"articleName"];
                postring.content = [responseDict objectForKey:@"content"];
                postring.nickName = [customerDict objectForKey:@"nickName"];
                postring.commentId = [[responseDict objectForKey:@"commentId"] integerValue];
                postring.readAble = [[responseDict objectForKey:@"readAble"] boolValue];
                
                if(![[customerDict objectForKey:@"avatarImg"]isKindOfClass:[NSNull class]])
                {
                    postring.avatarImg = [customerDict objectForKey:@"avatarImg"];
                }
                else
                {
                    postring.avatarImg = @"";
                }
                
                postring.customerId = [[customerDict objectForKey:@"customerId"] integerValue];
                
                [self.commentArray addObject:postring];
            }
        }
        
        [self.commentTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    AFHTTPSessionManager *manage = [[AFHTTPSessionManager alloc] init];
    [manage GET:POST_COMMENT_OPINION parameters:@{@"customerId":users.customerId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject objectForKey:@"data"])
        {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            if([[dict objectForKey:@"commentNum"] integerValue] > 0)
            {
                self.btnImage.hidden = NO;
            }
            else
            {
                self.btnImage.hidden = YES;
            }
            
            if([[dict objectForKey:@"praiseNum"] integerValue] > 0)
            {
                self.likeImage.hidden = NO;
            }
            else
            {
                self.likeImage.hidden = YES;
            }
        }
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
