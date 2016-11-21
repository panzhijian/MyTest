//
//  InformationCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createInformationCell)];
    }
    return self;
}

- (void)createInformationCell
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(50), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:self.titleLabel];
    
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(290), AUTO_MATE_HEIGHT(40), AUTO_MATE_WIDTH(450), AUTO_MATE_HEIGHT(40))];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.rightLabel];
}

@end
