//
//  XBJAddRecordNomalCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddRecordCalendarCell.h"

@implementation XBJAddRecordCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)calendarBtnAction:(id)sender {
    if(self.block){
        self.block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
