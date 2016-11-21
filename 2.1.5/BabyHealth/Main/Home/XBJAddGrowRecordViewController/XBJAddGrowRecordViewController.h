//
//  XBJAddGrowRecordViewController.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/17.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBaseViewController.h"
#import "XBJGrowRecordModel.h"

typedef NS_ENUM(NSInteger, XBJAddRecordStyle) {
    XBJAddRecordStyleGrow,
    XBJAddRecordStyleShit,
    XBJAddRecordStyleDrug
};
@interface XBJAddGrowRecordViewController : XBJBaseViewController

@property (nonatomic, strong) XBJGrowRecordModel *model;

@property (nonatomic, assign) BOOL isEdit;

@end
