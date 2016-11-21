//
//  XBJTestReportCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJTestReportModel.h"

@interface XBJTestReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) XBJTestReportModel *model;
+(CGFloat)rowheight:(NSString*)contentText;

- (void)setModel:(XBJTestReportModel *)model andIndex:(NSInteger )index;
@property(nonatomic, assign) BOOL open;

@end
