//
//  SettingButtonDouble.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/10.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingButtonDoubleDelegate <NSObject>

- (void)returnSwitchValue:(NSInteger)indexNumber switchValue:(BOOL)value;

@end

@interface SettingButtonDouble : UITableViewCell

@property(nonatomic,weak)id<SettingButtonDoubleDelegate>delegate;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UISwitch *settingSwitch;

@property(nonatomic,assign)NSInteger indexNumber;

@end
