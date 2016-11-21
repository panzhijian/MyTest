//
//  NoticeCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/2.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createNoticeCell)];
    }
    return self;
}

- (void)createNoticeCell
{    
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(90), AUTO_MATE_HEIGHT(90))];
    [self.contentView addSubview:self.headImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(180), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.titleLabel];
    
    self.likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+AUTO_MATE_WIDTH(13), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(30))];
    self.likeLabel.textColor = TXT_COLOR;
    self.likeLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:self.likeLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(508), AUTO_MATE_HEIGHT(30), AUTO_MATE_WIDTH(280), AUTO_MATE_HEIGHT(30))];
    self.timeLabel.textColor = CELL_TXT_COLOR;
    self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.timeLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(86), AUTO_MATE_WIDTH(600), AUTO_MATE_HEIGHT(30))];
    self.nameLabel.font = [UIFont systemFontOfSize:15.0f];
    self.nameLabel.text = @"";
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(132), AUTO_MATE_HEIGHT(136), AUTO_MATE_WIDTH(600), AUTO_MATE_HEIGHT(30))];
    self.detailLabel.font = [UIFont systemFontOfSize:13.0f];
    self.detailLabel.textColor = TXT_COLOR;
    self.detailLabel.text = @"";
    self.detailLabel.numberOfLines = 2;
    [self.contentView addSubview:self.detailLabel];
    
    self.line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame)+29, SCREEN_WIDTH, 1)];
    self.line.backgroundColor = RGB(224, 224, 224);
    [self.contentView addSubview:self.line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
