//
//  MeCell.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/5.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeCellDelegate <NSObject>

- (void)showNewMeView:(UIButton *)btn;

@end

@interface MeCell : UITableViewCell

@property(nonatomic,weak)id<MeCellDelegate>delegate;

///头像
@property(nonatomic,strong)UIImageView *headerImage;

///名字
@property(nonatomic,strong)UILabel *nameLabel;

///地址
@property(nonatomic,strong)UILabel *addressLabel;

///签到
@property(nonatomic,strong)UIButton *signBtn;

//git

@end
