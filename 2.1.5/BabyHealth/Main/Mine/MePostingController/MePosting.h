//
//  MePosting.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MePosting : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *postingTableView;

@property(nonatomic,strong)NSMutableArray *postingArray;

@end
