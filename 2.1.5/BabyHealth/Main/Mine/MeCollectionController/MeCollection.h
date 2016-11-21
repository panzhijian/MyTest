//
//  MeCollection.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCollection : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *collectionTableView;

@property(nonatomic,strong)NSMutableArray *collectionArray;

@end
