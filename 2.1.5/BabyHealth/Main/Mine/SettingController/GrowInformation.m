//
//  GrowInformation.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "GrowInformation.h"
#import "GrowInformationCell.h"

@implementation GrowInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"修改密码",@"我是宝宝推荐消息",@"新的评论提醒",@"新的赞提醒",@"清除缓存",@"关于", nil];
    
    self.growTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, AUTO_MATE_HEIGHT(VIEW_SIZE.height - 160)) style:UITableViewStyleGrouped];
    self.growTableView.delegate = self;
    self.growTableView.dataSource = self;
    self.growTableView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.growTableView];
}

#pragma mark -- 修改tableview自带的线条不能填充满
-(void)viewDidLayoutSubviews {
    
    if ([self.growTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.growTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.growTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.growTableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    static NSString *settingCell = @"settingButtonCell";
    GrowInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    if(!cell)
    {
        cell = [[GrowInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
    }
    
    cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.indexRow = indexPath.row;
    if(indexPath.row == 0)
    {
        cell.rightImage.hidden = NO;
        cell.rightImage.image = [UIImage imageNamed:@"rili"];
        cell.textFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    else
    {
        cell.textFiled.text = @"CM";
        cell.rightImage.hidden = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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
}

@end
