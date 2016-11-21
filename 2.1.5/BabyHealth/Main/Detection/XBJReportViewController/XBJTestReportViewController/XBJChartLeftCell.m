//
//  XBJChartLeftCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJChartLeftCell.h"

@implementation XBJChartLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
