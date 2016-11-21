//
//  MeCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/5.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createMeCell)];
    }
    return self;
}

- (void)createMeCell
{
    self.contentView.backgroundColor = BG_COLOR;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(198))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(44), AUTO_MATE_WIDTH(110), AUTO_MATE_HEIGHT(110))];
    self.headerImage.userInteractionEnabled = YES;
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.height / 2;
    self.headerImage.layer.masksToBounds = YES;
    [bgView addSubview:self.headerImage];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(194), AUTO_MATE_HEIGHT(74), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(40))];
    self.nameLabel.font = [UIFont systemFontOfSize:15.0f];
    self.nameLabel.textColor = ME_TXT_COLOR;
    [bgView addSubview:self.nameLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(194), AUTO_MATE_HEIGHT(132), AUTO_MATE_WIDTH(500), AUTO_MATE_HEIGHT(40))];
    self.addressLabel.font = [UIFont systemFontOfSize:14.0f];
    self.addressLabel.textColor = TXT_COLOR;
    [bgView addSubview:self.addressLabel];
    
    self.signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signBtn.frame = CGRectMake(AUTO_MATE_WIDTH(630), AUTO_MATE_HEIGHT(80), AUTO_MATE_WIDTH(92), AUTO_MATE_HEIGHT(42));
    [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
    self.signBtn.backgroundColor = BTN_COLOR;
    self.signBtn.layer.cornerRadius = self.signBtn.frame.size.height / 2;
    self.signBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.signBtn];
}

- (void)signBtnClick:(UIButton *)btn
{
    [self.delegate showNewMeView:btn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
