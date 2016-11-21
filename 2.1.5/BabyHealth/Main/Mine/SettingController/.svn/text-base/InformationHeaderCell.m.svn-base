//
//  InformationHeaderCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "InformationHeaderCell.h"

@implementation InformationHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createInformationHeaderCell)];
    }
    return self;
}

- (void)createInformationHeaderCell
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(90), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:self.titleLabel];
    
    self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(630), AUTO_MATE_HEIGHT(40), AUTO_MATE_WIDTH(110), AUTO_MATE_HEIGHT(110))];
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.height / 2;
    self.headerImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerImage];
}

@end
