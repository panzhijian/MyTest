//
//  XBJBindTableViewCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^scanCode)();

@interface XBJBindTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;

@property (copy,nonatomic) scanCode scanBlock;

- (void)configureCellWith:(NSInteger) index;

@end
