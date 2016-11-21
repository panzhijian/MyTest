//
//  MeCollection.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeCollection.h"
#import "MeCommunityCell.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "PostingModel.h"
#import "PostDetails.h"

@implementation MeCollection

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    self.collectionArray = [[NSMutableArray alloc] init];
    
    self.collectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 160)) style:UITableViewStyleGrouped];
    self.collectionTableView.delegate = self;
    self.collectionTableView.dataSource = self;
    self.collectionTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.collectionTableView];
    
    if([self.collectionArray  count] > 0)
    {
        [self.collectionArray removeAllObjects];
    }
    
    [self performSelector:@selector(createMeCollctionSource)];
    
    
    
    
    // begain  潘志健  9-27
    
    //end  潘志健 7-27
}

- (void)createMeCollctionSource
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在加载";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *dict = @{@"customerId":[NSNumber numberWithInteger:[users.customerId integerValue]]};
    NSLog(@"%@%@",POST_FAVORITE,dict);
    
    [session GET:POST_FAVORITE parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"]isEqualToString:@"SUCCESS"])
        {
            NSArray *responseArray = [responseObject objectForKey:@"data"];
            for(NSDictionary *responseDict in responseArray)
            {
                NSDictionary *dict = [responseDict objectForKey:@"topicArticle"];
                    PostingModel *posting = [[PostingModel alloc] init];
                
                    posting.articleId = [[dict objectForKey:@"articleId"] integerValue];
                    posting.articleName = [dict objectForKey:@"articleName"];
                    posting.articleState = [dict objectForKey:@"articleState"];
                    posting.browseNum = [[dict objectForKey:@"browseNum"] integerValue];
                    posting.commentNum = [[dict objectForKey:@"commentNum"] integerValue];
                    posting.content = [dict objectForKey:@"content"];
                    posting.createTime = [dict objectForKey:@"createTime"];
                
                    [self.collectionArray addObject:posting];
            }
            
            [self.collectionTableView reloadData];
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
  
    }];
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.collectionArray count];
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
    
    PostingModel *posting = [self.collectionArray objectAtIndex:indexPath.row];
    
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
    PostingModel *posting = [self.collectionArray objectAtIndex:indexPath.row];
    
    PostDetails *post = [[PostDetails alloc] init];
    post.navTitle = @"帖子";
    post.webUrl = [NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",posting.articleId,[users.customerId integerValue]];
    [self.navigationController pushViewController:post animated:YES];
    
}


#pragma mark --begin  潘志健  2016-9-30   添加删除收藏功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteOrder:indexPath];

    }
}

-(void)deleteOrder:(NSIndexPath *)indexPath
{
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    PostingModel *post=self.collectionArray[indexPath.row];
    
   NSString *urlStr = [NSString stringWithFormat:@"%@%@?customerId=%@&articleId=%ld",REQUEST_IP,@"/cancelFavorite.do",users.customerId,(long)post.articleId];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=30;
    NSURLSessionDataTask *task =[[NSURLSession sharedSession] dataTaskWithRequest:request   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view makeToast:error.localizedDescription
                                duration:1.0
                                position:CSToastPositionCenter];
                });
       
        }else
        {
     
            NSDictionary *originalDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if([[originalDic objectForKey:@"result"]isEqualToString:@"SUCCESS"]){
                [self.collectionArray  removeObjectAtIndex:indexPath.row];

                dispatch_async(dispatch_get_main_queue(), ^{
      
                    [self.collectionTableView reloadData];
                    [self.view makeToast:originalDic[@"message"]
                                duration:1.0
                                position:CSToastPositionCenter];
                });
                
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.view makeToast:originalDic[@"message"]
                                                     duration:1.0
                                                     position:CSToastPositionCenter];
                });
            }
            
            
        }
        
    }];
    
    [task resume];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath      //当在Cell上滑动时会调用此函数
{
        return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键,点击Delete后会调
}
#pragma mark --end  潘志健  2016-9-30  添加删除收藏功能

@end
