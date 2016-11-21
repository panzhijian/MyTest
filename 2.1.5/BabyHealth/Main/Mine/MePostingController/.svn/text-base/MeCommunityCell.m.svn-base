//
//  MeCommunityCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/9.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeCommunityCell.h"

@implementation MeCommunityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createMeCommunityCell)];
    }
    return self;
}

- (void)createMeCommunityCell
{
    self.contentView.backgroundColor = BG_COLOR;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(710), AUTO_MATE_HEIGHT(100))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.0f;
    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(10), AUTO_MATE_WIDTH(690), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [bgView addSubview:self.titleLabel];
    
    UIImageView *commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(60), AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30))];
    commentImage.image = [UIImage imageNamed:@"comment"];
    [bgView addSubview:commentImage];
    
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(60), AUTO_MATE_HEIGHT(60), AUTO_MATE_WIDTH(100), AUTO_MATE_HEIGHT(30))];
    self.commentLabel.font = [UIFont systemFontOfSize:15.0f];
    self.commentLabel.textColor = TXT_COLOR;
    [bgView addSubview:self.commentLabel];
    
    UIImageView *browseImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(180), AUTO_MATE_HEIGHT(60), AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(30))];
    browseImage.image = [UIImage imageNamed:@"read"];
    [bgView addSubview:browseImage];
    
    self.browseLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(210), AUTO_MATE_HEIGHT(60), AUTO_MATE_WIDTH(100), AUTO_MATE_HEIGHT(30))];
    self.browseLabel.font = [UIFont systemFontOfSize:15.0f];
    self.browseLabel.textColor = TXT_COLOR;
    [bgView addSubview:self.browseLabel];
    
}

@end
