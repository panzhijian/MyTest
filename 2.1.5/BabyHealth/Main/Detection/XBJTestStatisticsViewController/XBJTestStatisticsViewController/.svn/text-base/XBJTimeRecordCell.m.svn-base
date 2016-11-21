//
//  XBJTimeRecordCell.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/10.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTimeRecordCell.h"

@implementation XBJTimeRecordCell

- (void)setModel:(XBJReportDetailModel *)model{
    _model = model;
    NSString *string = [NSString stringWithFormat:@"%@  %@",model.dateTime,model.babyAge];
    self.dateLabel.text = string;
    NSString *length = model.length.integerValue==0?@"":[NSString stringWithFormat:@"身高：%.2fcm",[model.length floatValue]];
    NSString *bodyWeight = model.bodyWeight.integerValue==0?@"":[NSString stringWithFormat:@"体重：%.2fkg",[model.bodyWeight floatValue]];
    NSString *headSize = model.headSize.integerValue==0?@"":[NSString stringWithFormat:@"头围：%.2fcm",[model.headSize floatValue]];

    self.heightAndWieght.text = [NSString stringWithFormat:@"%@  %@  %@",length,bodyWeight,headSize];
    
    NSString *dungNumber = model.dungNumber.integerValue==0?@"":[NSString stringWithFormat:@"便便：%@次",model.dungNumber];
    self.dungLabel.text = dungNumber;
    
    NSString *medicineNumber = model.medicineNumber.integerValue==0?@"":[NSString stringWithFormat:@"用药：%@次",model.medicineNumber];
    self.medicineLabel.text = medicineNumber;
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
