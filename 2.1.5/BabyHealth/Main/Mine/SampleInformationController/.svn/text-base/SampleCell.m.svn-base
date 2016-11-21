//
//  SampleCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "SampleCell.h"

@implementation SampleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createSampleInformationCell)];
    }
    return self;
}

- (void)createSampleInformationCell
{
    self.contentView.backgroundColor = BG_COLOR;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(710), AUTO_MATE_HEIGHT(146))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0f;
    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(500), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(100), AUTO_MATE_WIDTH(500), AUTO_MATE_HEIGHT(30))];
    self.timeLabel.font = [UIFont systemFontOfSize:15.0f];
    self.timeLabel.textColor = TXT_COLOR;
    [self.contentView addSubview:self.timeLabel];
    
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(628), AUTO_MATE_HEIGHT(47), AUTO_MATE_WIDTH(52), AUTO_MATE_HEIGHT(52))];
    [self.contentView addSubview:self.rightImage];
}

@end
