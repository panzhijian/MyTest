//
//  XBJAddShitRecordViewController.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"
#import "XBJShitRecordModel.h"
#import"XBJBindModel.h"
@interface XBJAddShitRecordViewController : XBJBaseViewController

@property (nonatomic, strong) XBJShitRecordModel *model;

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isBindSample;

@property (nonatomic,strong) XBJBindModel *bind_model;



@end
