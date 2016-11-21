//
//  XBJAddDurgRecordCell.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAddDurgRecordCell.h"
#import "XBJNetWork.h"
#import "GxMenu.h"
@implementation XBJAddDurgRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.lineHeight.constant = 0.5;
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField1];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.textField2];
}

- (void)setDrugDic:(NSMutableDictionary *)drugDic{
    _drugDic = drugDic;
    self.textField1.text = drugDic[@"medicineName"];
    self.textField2.text = drugDic[@"measure"];
}

//- (void)textDidChange:(NSNotification *)notification {
//    UITextField *textField = notification.object;
//    if(textField.text.length) [self showGxMenu:textField];
//    else [GxMenu dismissMenu];
//}
- (IBAction)chooseName:(id)sender {
    if (self.nameBlock) {
        self.nameBlock();
    }
    
}
- (IBAction)chooseCount:(id)sender {
    if (self.countBlock) {
        self.countBlock();
    }

}

#pragma mark UITextField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==self.textField1 && self.textField1.text.length){
        [self.drugDic setValue:self.textField1.text forKey:@"medicineName"];
    }else{
        [self.drugDic setValue:self.textField2.text forKey:@"measure"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSString *text = [textField.text stringByAppendingString:string];
//    if(text.length){
//        [self showGxMenu:textField];
//    }
//    return YES;
//}

- (void)showGxMenu:(UITextField *)textField
{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect       = [textField convertRect: textField.bounds toView:window];
    CGRect newRect = CGRectMake(rect.origin.x+rect.size.width/2.0, rect.origin.y, rect.size.width, rect.size.height);
    if(textField==self.textField1){
        
        [[XBJNetWork sharedInstance] getDrugListWithDrugName:textField.text block:^(NSArray *result, NSString *msg, NSError *error) {
            if(result.count){
                
                [GxMenu showMenuInView:[UIApplication sharedApplication].keyWindow fromRect:newRect contentSize:CGSizeMake(120, 200) menuItems:result block:^(id value, NSInteger index) {
                    [GxMenu dismissMenu];
                    self.textField1.text = value;
                    if(self.textField1.text.length)
                        [self.drugDic setValue:self.textField1.text forKey:@"medicineName"];
                    
                }];
                [GxMenu setTintColor:[UIColor whiteColor]];
            }
        }];
        
    }else{
        NSArray *data = @[@"片",@"粒",@"袋",@"支",@"喷",@"克",@"毫克",@"微克",@"毫升"];
        [GxMenu showMenuInView:[UIApplication sharedApplication].keyWindow fromRect:newRect contentSize:CGSizeMake(120, 200) menuItems:data block:^(NSString *value, NSInteger index) {
            [GxMenu dismissMenu];
            self.textField2.text = [self.textField2.text stringByAppendingString:value];
            if(self.textField2.text.length)
                [self.drugDic setValue:self.textField2.text forKey:@"measure"];
            
        }];
        [GxMenu setTintColor:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
