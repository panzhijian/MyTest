//
//  XBJDrugChooseViewController.m
//  BabyHealth
//
//  Created by lx on 16/10/18.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJDrugChooseViewController.h"
#import "XBJDrugChooseViewCell.h"
#import "XBJNetWork.h"


@interface XBJDrugChooseViewController ()

@end

@implementation XBJDrugChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
    self.title = @"添加药品";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"zuojiantou"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 16, 20);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    backView.backgroundColor = BG_COLOR2;
    [self.view addSubview:backView];
    
    self.drugSearch = [[UITextField alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(700), AUTO_MATE_HEIGHT(100))];
    self.drugSearch.font = [UIFont systemFontOfSize:15];
    self.drugSearch.placeholder = @"请输入药品,疫苗或保健品名称搜索";
    self.drugSearch.clearButtonMode = UITextFieldViewModeAlways;
    self.drugSearch.backgroundColor = BG_COLOR2;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.drugSearch];
    self.drugSearch.delegate = self;
    [backView addSubview:self.drugSearch];
    
    self.tablelView = [[UITableView alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(100), VIEW_SIZE.width, VIEW_SIZE.height) style:UITableViewStylePlain];
    [self.tablelView registerNib:[UINib nibWithNibName:@"XBJDrugChooseViewCell" bundle:nil] forCellReuseIdentifier:@"XBJDrugChooseViewCell"];
    self.tablelView.backgroundColor = BG_COLOR;
    self.tablelView.delegate = self;
    self.tablelView.dataSource = self;
    self.hearderLable = [[UILabel alloc]initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), VIEW_SIZE.width, AUTO_MATE_HEIGHT(50))];
    self.hearderLable.font = [UIFont systemFontOfSize:14];
    self.hearderLable.textColor = ME_TXT_COLOR;
    self.tablelView.tableHeaderView = self.hearderLable;
    self.tablelView.tableHeaderView.frame = CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(50));
    
    [self.view addSubview:self.tablelView];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    if ([userDefaultes arrayForKey:@"drugHistory"].count>0) {
        self.drugHistoryArr = [NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"drugHistory"]];
        self.hearderLable.text = @"   用药历史";
        self.dataArr = [NSMutableArray arrayWithArray:self.drugHistoryArr];
    }
    else
    {
        self.drugHistoryArr = [NSMutableArray new];
        self.hearderLable.text = @"   亲您还没搜索药品哦~";

    }
    
}
- (void)textDidChange:(NSNotification *)notification {
    
    if (self.drugSearch.text.length!=0) {
        [[XBJNetWork sharedInstance] getDrugListWithDrugName:self.drugSearch.text block:^(NSArray *result, NSString *msg, NSError *error) {
            if(result.count){
                if (self.dataArr) {
                    [self.dataArr removeAllObjects];
                }
                self.dataArr = [NSMutableArray arrayWithArray:result];
                self.hearderLable.text = @"   请选择药品";
                [self.tablelView reloadData];
            }
            else
            {
                if (self.dataArr) {
                    [self.dataArr removeAllObjects];
                }
                if (self.drugSearch.text.length>0) {
                    self.dataArr = [NSMutableArray arrayWithObject:self.drugSearch.text];
                    self.hearderLable.text = @"   请选择药品";
                }
                else//清除按钮后还会走接口
                {
                    self.hearderLable.text = @"   用药历史";
                    self.dataArr  = [NSMutableArray arrayWithArray:self.drugHistoryArr];
                }
                
                [self.tablelView reloadData];
            }
            
        }];
    }
    else
    {
        if (self.dataArr) {
            [self.dataArr removeAllObjects];
        }
        if (self.drugHistoryArr.count>0) {
            self.hearderLable.text = @"   用药历史";
            self.dataArr  = [NSMutableArray arrayWithArray:self.drugHistoryArr];
        }
        else
        {
            self.hearderLable.text = @"   亲您还没搜索药品哦~";
        }
        [self.tablelView reloadData];

    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBJDrugChooseViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"XBJDrugChooseViewCell"];
    cell.drugNameLable.text = self.dataArr[indexPath.row];
    cell.drugNameLable.font = [UIFont systemFontOfSize:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blook) {
        self.blook(self.dataArr[indexPath.row]);
    }
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    if (self.drugHistoryArr.count>0) {
        int i=0;
        //判断重复
        for (NSString *str in self.drugHistoryArr) {
            if ([self.dataArr[indexPath.row] isEqualToString:str]) {
                i += 1;
            }
        }
        if (i==0) {
            [self.drugHistoryArr addObject:self.dataArr[indexPath.row]];
            [userDefaultes removeObjectForKey:@"drugHistory"];
            [userDefaultes setObject:self.drugHistoryArr  forKey:@"drugHistory"];
        }
    }
    else
    {
        //长度大于0
        if ([self.dataArr[indexPath.row] length]) {
            [self.drugHistoryArr addObject:self.dataArr[indexPath.row]];
            [userDefaultes removeObjectForKey:@"drugHistory"];
            [userDefaultes setObject:self.drugHistoryArr  forKey:@"drugHistory"];
        }
        
    }
   

    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.hearderLable.text isEqualToString:@"   用药历史"]) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.hearderLable.text isEqualToString:@"   用药历史"]) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [self.drugHistoryArr removeObjectAtIndex:indexPath.row];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes removeObjectForKey:@"drugHistory"];
        [userDefaultes setObject:self.drugHistoryArr  forKey:@"drugHistory"];
        if (self.drugHistoryArr.count==0) {
            self.hearderLable.text = @"   亲您还没搜索药品哦~";
            [tableView reloadData];
            return;
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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





































