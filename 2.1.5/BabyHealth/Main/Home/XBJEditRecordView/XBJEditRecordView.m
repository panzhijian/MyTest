//
//  XBJEditRecordView.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJEditRecordView.h"
#import "Masonry.h"

@implementation XBJEditRecordView

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.type = MMPopupTypeSheet;

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(frame.size);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cancerBtn.layer.borderWidth = 0.5;
    self.cancerBtn.layer.borderColor = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0].CGColor;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
}

- (IBAction)cancerBtnAction:(id)sender {
    [self hide];
}

- (IBAction)deleteBtnAction:(id)sender {
    if(self.delete_block){
        self.delete_block();
    }
    [self hide];
}
- (IBAction)editBtnAction:(id)sender {
    if(self.edit_block){
        self.edit_block();
    }
    [self hide];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
