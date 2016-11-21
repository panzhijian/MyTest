//
//  XBJTestDepictPopView.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestDepictPopView.h"
#import "XBJTestDepictPopViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"

@implementation XBJTestDepictPopView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.tableView registerNib:[UINib nibWithNibName:@"XBJTestDepictPopViewCell" bundle:nil] forCellReuseIdentifier:@"XBJTestDepictPopViewCell"];
    
    self.type = MMPopupTypeCustom;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(frame.size);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.openRow = -1;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//}

#pragma mark - tableView delegate/dataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.openRow==indexPath.row){
        self.openRow = -1;
    }else{
        self.openRow = indexPath.row;
    }
    [tableView reloadData];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XBJTestDepictPopViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.open = NO;
//    [tableView reloadData];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    __block NSInteger index = indexPath.row;
    float height = [tableView fd_heightForCellWithIdentifier:@"XBJTestDepictPopViewCell" cacheByIndexPath:indexPath configuration:^(XBJTestDepictPopViewCell * cell) {
        
        [cell configerCellWith:indexPath.row];
        if(index==self.openRow){
            cell.open = YES;
        }else{
            cell.open = NO;
        }
    }];
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBJTestDepictPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBJTestDepictPopViewCell"];
    if(indexPath.row==self.openRow){
        cell.open = YES;
    }else{
        cell.open = NO;
    }
    [cell configerCellWith:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 54)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 24)];
    label.textColor = CELL_TXT_COLOR;
    label.font = [UIFont systemFontOfSize:12.f];
    label.text = @"结果正常范围";
    [headView addSubview:label];
    return headView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
