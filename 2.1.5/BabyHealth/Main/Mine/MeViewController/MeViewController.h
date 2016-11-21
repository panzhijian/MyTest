//
//  MeViewController.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeCell.h"

@interface MeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MeCellDelegate>

@property(nonatomic,strong)UITableView *meTableView;

@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSArray *imageArray;

///记录积分
@property(nonatomic,assign)NSInteger points;

//签到状态
@property(nonatomic,assign)BOOL isSignSate;
@end
