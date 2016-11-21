//
//  GrowInformationCell.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GrowInformationCellDelegate<NSObject>

- (void)returnTextFiledValue:(NSInteger)index;

@end

@interface GrowInformationCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UITextField *textFiled;

@property(nonatomic,strong)UIImageView *rightImage;

@property(nonatomic,assign)NSInteger indexRow;

@end
