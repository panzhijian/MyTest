//
//  SettingButtonCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "SettingButtonCell.h"

@implementation SettingButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createSettingButtonCell)];
    }
    return self;
}

- (void)createSettingButtonCell
{
//    self.contentView.backgroundColor = BG_COLOR;
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
//    
//    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.layer.cornerRadius = 5.0f;
//    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(34), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [self.contentView addSubview:self.titleLabel];
    
    self.settingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(630), AUTO_MATE_HEIGHT(15), AUTO_MATE_WIDTH(80), AUTO_MATE_HEIGHT(42))];
    [self.settingSwitch addTarget:self action:@selector(switchUpdateValue:) forControlEvents:UIControlEventValueChanged];
    self.settingSwitch.onTintColor = BTN_COLOR;
    self.settingSwitch.layer.cornerRadius = self.settingSwitch.frame.size.height / 2;
    [self.contentView addSubview:self.settingSwitch];
}

- (void)switchUpdateValue:(UISwitch *)switchValue
{
    if(!switchValue.on)
    {
        self.settingSwitch.tintColor = CELL_TXT_COLOR;
        self.settingSwitch.backgroundColor = CELL_TXT_COLOR;
    }
    
    [self.delegate returnSwitchValue:self.indexNumber switchValue:switchValue.on];
}

@end
