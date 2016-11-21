//
//  SampleInformation.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleInformation : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *sampleTableView;

@property(nonatomic,strong)NSMutableArray *sampleArray;

@end
