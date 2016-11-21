//
//  XBJTestDepictPopView.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MMPopupView.h"
#import "XBJTestReportModel.h"

@interface XBJTestDepictPopView : MMPopupView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) XBJTestReportModel *model;

@property (assign, nonatomic) NSInteger openRow;

@end
