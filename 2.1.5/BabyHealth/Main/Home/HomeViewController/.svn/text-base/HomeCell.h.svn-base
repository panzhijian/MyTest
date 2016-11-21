//
//  HomeCell.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/28.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePopupDelegate <NSObject>

- (void)showHomePopup:(NSInteger)number indexRow:(NSInteger)indexRow;

@end

@interface HomeCell : UITableViewCell

@property(nonatomic,weak)id<HomePopupDelegate>delegate;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *heightLabel;

@property(nonatomic,strong)UILabel *weightLabel;

@property(nonatomic,strong)UILabel *headerLabel;

@property(nonatomic,strong)UILabel *shitLabel;

@property(nonatomic,strong)UILabel *medicineLabel;

@property(nonatomic,strong)UIImageView *topImage;

@property(nonatomic,strong)UIImageView *midImage;

@property(nonatomic,assign)NSInteger indexRow;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *midView;

@end
