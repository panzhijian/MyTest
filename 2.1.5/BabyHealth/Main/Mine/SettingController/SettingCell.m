//
//  SettingCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createSettingCell)];
    }
    return self;
}

- (void)createSettingCell
{
    self.contentView.backgroundColor = BG_COLOR;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [self.contentView addSubview:self.titleLabel];
    
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(690), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30))];
    [self.contentView addSubview:self.rightImage];
}

@end
