//
//  XBJAddRecordDescribeCell.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/4.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJGrowRecordModel.h"
#import "XBJShitRecordModel.h"
#import "XBJDrugRecordModel.h"
#import "UIPlaceholderTextView.h"
typedef void (^XBJAddRecordAddImageBlock)();

@interface XBJAddRecordDescribeCell : UITableViewCell<UITextViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIImage *defaultImage;
@property (assign, nonatomic) NSInteger deleteIndex;

@property (nonatomic, strong) XBJGrowRecordModel *growModel;
@property (nonatomic, strong) XBJShitRecordModel *shitModel;
@property (nonatomic, strong) XBJDrugRecordModel *drugModel;

@property (copy, nonatomic) XBJAddRecordAddImageBlock addImageBlock;

- (void)setImagesWith:(NSArray *)imageArr;

@end
