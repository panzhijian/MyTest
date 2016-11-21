//
//  XBJAddRecordEditCell.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddRecordEditCell.h"
#import "XBJAppHelper.h"

@implementation XBJAddRecordEditCell

- (void)configureGrowCellWith:(NSInteger)index andModel:(XBJGrowRecordModel *)model{
    
    self.index = index;
    self.growModel = model;
    self.type = XBJAddRecordStyleGrow;
    if(index==1){
        self.textField.text = [NSString stringWithFormat:@"%.2f",[model.length floatValue]];
        self.titleLabel.text = @"身高";
        self.unitLabel.text = @"cm";
    }else if(index==2){
        self.textField.text = [NSString stringWithFormat:@"%.2f",[model.bodyWeight floatValue]];
        self.titleLabel.text = @"体重";
        self.unitLabel.text = @"kg";
    }else if(index==3){
        self.textField.text = [NSString stringWithFormat:@"%.2f",[model.headSize floatValue]];
        self.titleLabel.text = @"头围";
        self.unitLabel.text = @"cm";
    }
}

- (void)configureShitCellWith:(NSInteger)index andModel:(XBJShitRecordModel *)model{
    self.index = index;
    self.shitModel = model;
    self.type = XBJAddRecordStyleShit;
    if(index==1){
        self.titleLabel.text = @"便便性状";
        self.unitLabel.text = nil;
        self.textField.text = [XBJAppHelper britishSinoConversion:model.trait];
    }else if(index==2){
        self.titleLabel.text = @"便便颜色";
        self.unitLabel.text = nil;
        self.textField.text = [XBJAppHelper britishSinoConversion:model.color];
    }
    self.textField.userInteractionEnabled = NO;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (self.type) {
        case XBJAddRecordStyleGrow:
        {
            if(_index==1){
                self.growModel.length = textField.text.length?textField.text:nil;
            }else if(_index==2){
                self.growModel.bodyWeight = textField.text.length?textField.text:nil;
            }else{
                self.growModel.headSize = textField.text.length?textField.text:nil;
            }
        }
            break;
//        case XBJAddRecordStyleShit:{
//            if(_index==1){
//                self.shitModel.trait = [XBJAppHelper sinoBritishConversion:textField.text];
//            }else if(_index==2){
//                self.shitModel.color = [XBJAppHelper sinoBritishConversion:textField.text];            }
//        }
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

@end
