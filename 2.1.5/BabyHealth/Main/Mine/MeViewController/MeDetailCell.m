//
//  MeDetailCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeDetailCell.h"

@implementation MeDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createMeDetailCell)];
    }
    return self;
}

- (void)createMeDetailCell
{
    self.contentView.backgroundColor = BG_COLOR;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(18), AUTO_MATE_HEIGHT(34), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    [bgView addSubview:self.headerImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(78), AUTO_MATE_HEIGHT(10), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(80))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [bgView addSubview:self.titleLabel];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(530), AUTO_MATE_HEIGHT(10), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(80))];
    self.rightLabel.font = [UIFont systemFontOfSize:15.0f];
    self.rightLabel.textColor = TXT_COLOR;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:self.rightLabel];
    
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(700), AUTO_MATE_HEIGHT(40), AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30))];
    self.rightImage.image = [UIImage imageNamed:@"jiantou3"];
    [bgView addSubview:self.rightImage];
}

@end
