//
//  XBJTestDepictPopViewCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/8.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJTestReportModel.h"

@interface XBJTestDepictPopViewCell : UITableViewCell

@property(nonatomic, assign) BOOL open;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *depictLabel;
@property (weak, nonatomic) IBOutlet UIImageView *openImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;

@property (strong, nonatomic) XBJTestReportModel *model;

- (void)setModel:(XBJTestReportModel *)model andIndex:(NSInteger )index;

- (void)configerCellWith:(NSInteger )index;

@end
