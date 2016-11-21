//
//  XBJAddRecordNomalCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^calendarCellBlock)();

@interface XBJAddRecordCalendarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *calendarBtn;

@property (copy, nonatomic) calendarCellBlock block;

@end
