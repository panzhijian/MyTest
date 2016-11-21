//
//  MeTopDetailCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeTopDetailCell.h"

@implementation MeTopDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createMeTopDetailCell)];
    }
    return self;
}

- (void)createMeTopDetailCell
{
    self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(18), AUTO_MATE_HEIGHT(34), AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(40))];
    [self.contentView addSubview:self.headerImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(78), AUTO_MATE_HEIGHT(10), AUTO_MATE_WIDTH(400), AUTO_MATE_HEIGHT(80))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [self.contentView addSubview:self.titleLabel];
    
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(700), AUTO_MATE_HEIGHT(40), AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30))];
    self.rightImage.image = [UIImage imageNamed:@"jiantou3"];
    [self.contentView addSubview:self.rightImage];
}

@end
