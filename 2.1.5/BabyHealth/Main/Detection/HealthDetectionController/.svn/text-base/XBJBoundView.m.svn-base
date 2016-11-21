//
//  XBJBoundView.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBoundView.h"

@implementation XBJBoundView

- (void)layoutSubviews{
    [super layoutSubviews];

    [self configureContactLabel];
}

- (void)configureContactLabel{
    NSString * string = @"如有疑问可拨打0755-36307818或者加Ｑ338622234在线咨询";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
    NSRange range1 = NSMakeRange(7, 13);
    NSRange range2 = NSMakeRange(23, 10);
    [attributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:color
                             range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:color
                             range:range2];
    self.contactLabel.attributedText = attributedString;
}

- (IBAction)bindBtnAction:(id)sender {
    if(self.bindBlock){
        self.bindBlock();
    }
}
- (IBAction)reportBtnAction:(id)sender {
    if(self.reportBlock){
        self.testImageView.hidden = YES;
        self.reportBlock();
    }
}
- (IBAction)censusBtnAction:(id)sender {
    if(self.censusBlock){
        self.censusBlock();
    }
}

- (IBAction)callBtnAction:(id)sender {
    if(self.callBlock){
        self.callBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
