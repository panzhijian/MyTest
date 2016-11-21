//
//  XBJHealthRecordTableViewCell.h
//  ChartDemo
//
//  Created by jxmac2 on 16/6/30.
//  Copyright © 2016年 jxmac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJGrowRecordModel.h"
#import "XBJShitRecordModel.h"
#import "XBJDrugRecordModel.h"

typedef void (^HealthRecordCellEditBlock)(NSInteger);
typedef void (^HealthRecordCellZoomImageBlock)(UIImage *);

@interface XBJHealthRecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;

@property (assign, nonatomic) NSInteger index;

@property (copy, nonatomic) HealthRecordCellEditBlock edit_block;
@property (copy, nonatomic) HealthRecordCellZoomImageBlock zoom_block;

@property (strong,nonatomic) XBJGrowRecordModel *growModel;
@property (strong,nonatomic) XBJShitRecordModel *shitModel;
@property (strong,nonatomic) XBJDrugRecordModel *drugModel;

@end
