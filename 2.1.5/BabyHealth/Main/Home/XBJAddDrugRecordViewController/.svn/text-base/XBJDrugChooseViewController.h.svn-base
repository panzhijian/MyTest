//
//  XBJDrugChooseViewController.h
//  BabyHealth
//
//  Created by lx on 16/10/18.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"

typedef void (^searchResultBlook)(NSString *);
@interface XBJDrugChooseViewController : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITextField * drugSearch;
@property(nonatomic,strong)UITableView * tablelView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * drugHistoryArr;
@property(nonatomic,strong)UILabel * hearderLable;
@property(copy,nonatomic)searchResultBlook blook;
@end
