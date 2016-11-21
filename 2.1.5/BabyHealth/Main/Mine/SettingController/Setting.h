//
//  Setting.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingButtonCell.h"
#import "SettingButtonDouble.h"

@interface Setting : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource,SettingButtonCellDelegate,SettingButtonDoubleDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *settingTableView;

@property(nonatomic,strong)NSArray *titleArray;

@end
