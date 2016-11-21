//
//  XBJAddRecordEditCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJAddGrowRecordViewController.h"
#import "XBJGrowRecordModel.h"
#import "XBJShitRecordModel.h"

@interface XBJAddRecordEditCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) XBJAddRecordStyle type;
@property (nonatomic, strong) XBJGrowRecordModel *growModel;
@property (nonatomic, strong) XBJShitRecordModel *shitModel;


- (void)configureGrowCellWith:(NSInteger)index andModel:(XBJGrowRecordModel *)model;

- (void)configureShitCellWith:(NSInteger)index andModel:(XBJShitRecordModel *)model;


@end
