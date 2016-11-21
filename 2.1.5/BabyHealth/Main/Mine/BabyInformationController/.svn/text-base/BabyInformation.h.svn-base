//
//  BabyInformation.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateMeInformation.h"
#import "UsersModel.h"

@protocol BabyInformationDelegate <NSObject>

- (void)showNewView;

@end

@interface BabyInformation : XBJBaseViewController<UITableViewDelegate,UITableViewDataSource,UpdateMeInformationDelegate,UIAlertViewDelegate>

@property(nonatomic,weak)id<BabyInformationDelegate>delegate;

@property(nonatomic,strong)UITableView *babyTableView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)UpdateMeInformation *updateMe;

@property(nonatomic,strong)UsersModel *users;

@property(nonatomic,assign)BOOL isUpdateValue;

@end
