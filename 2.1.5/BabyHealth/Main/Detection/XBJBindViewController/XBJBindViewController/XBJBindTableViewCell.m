//
//  XBJBindTableViewCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJBindTableViewCell.h"

@implementation XBJBindTableViewCell

- (void)configureCellWith:(NSInteger) index{
    self.scanBtn.hidden = YES;
    self.textField.userInteractionEnabled = YES;
//    self.accessoryType = UITableViewCellAccessoryNone;
    switch (index) {
        case 0:
        {
            self.titleLabel.text = @"样品编号：";
            self.textField.userInteractionEnabled = NO;
            self.textField.placeholder = @"仅支持扫描";
            self.scanBtn.hidden = NO;
        }
            break;
        case 1:
        {
            self.titleLabel.text = @"送样联系人：";
            self.textField.placeholder = @"请输入您的姓名";
        }
            break;
        case 2:
        {
            self.titleLabel.text = @"电话号码：";
            self.textField.placeholder = @"请输入您的电话号码";
        }
            break;
        case 3:
        {
            self.titleLabel.text = @"所在地区：";
            
            
            self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 4:
        {
            self.titleLabel.text = @"详细地址：";
            self.textField.placeholder = @"街道、楼牌号等";
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)sacnAction:(id)sender {
    if(self.scanBlock){
        self.scanBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
