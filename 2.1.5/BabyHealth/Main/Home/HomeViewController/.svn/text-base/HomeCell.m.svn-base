//
//  HomeCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/28.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createHomeCell)];
    }
    return self;
}

- (void)createHomeCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:232.0f/255.0f blue:237.0f/255.0f alpha:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(40), 0, AUTO_MATE_WIDTH(2), AUTO_MATE_HEIGHT(303))];
    label.backgroundColor = [UIColor colorWithRed:194.0f/255.0f green:172/255.0f blue:180/255.0f alpha:1];
    [self.contentView addSubview:label];
    
    UIImageView *roundImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(13), AUTO_MATE_WIDTH(22), AUTO_MATE_HEIGHT(22))];
    roundImage.image = [UIImage imageNamed:@"dian"];
    [self.contentView addSubview:roundImage];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(67), AUTO_MATE_HEIGHT(5), AUTO_MATE_WIDTH(400), AUTO_MATE_HEIGHT(30))];
    self.timeLabel.font = [UIFont systemFontOfSize:14.0f];
    self.timeLabel.textColor = CELL_TXT_COLOR;
    [self.contentView addSubview:self.timeLabel];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(70), AUTO_MATE_HEIGHT(53),AUTO_MATE_WIDTH(656),AUTO_MATE_HEIGHT(204))];
    footView.backgroundColor = [UIColor whiteColor];
    footView.layer.cornerRadius = 10;
    [self.contentView addSubview:footView];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(18), AUTO_MATE_WIDTH(750.0), AUTO_MATE_HEIGHT(72))];
    [footView addSubview:self.topView];
    
    self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(footView.frame.size.width - AUTO_MATE_WIDTH(45), AUTO_MATE_HEIGHT(7), AUTO_MATE_WIDTH(36), AUTO_MATE_HEIGHT(36))];
    self.topImage.image = [UIImage imageNamed:@"zhuyi"];
    self.topImage.userInteractionEnabled = YES;
    [self.topView addSubview:self.topImage];
    
    UITapGestureRecognizer *topTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageClick:)];
    [self.topView addGestureRecognizer:topTGR];
    
    //身高 体重 头围
    self.heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(18), AUTO_MATE_HEIGHT(22), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(50))];
    self.heightLabel.font = [UIFont systemFontOfSize:13.0f];
    self.heightLabel.textColor = CELL_TXT_COLOR;
    [footView addSubview:self.heightLabel];
    
    self.weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(228), AUTO_MATE_HEIGHT(22), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(50))];
    self.weightLabel.font = [UIFont systemFontOfSize:13.0f];
    self.weightLabel.textColor = CELL_TXT_COLOR;
    [footView addSubview:self.weightLabel];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(438), AUTO_MATE_HEIGHT(22), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(50))];
    self.headerLabel.font = [UIFont systemFontOfSize:13.0f];
    self.headerLabel.textColor = CELL_TXT_COLOR;
    [footView addSubview:self.headerLabel];
    
    //便便
    self.shitLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(18), AUTO_MATE_HEIGHT(77), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(50))];
    self.shitLabel.textColor = CELL_TXT_COLOR;
    self.shitLabel.font = [UIFont systemFontOfSize:13.0f];
    [footView addSubview:self.shitLabel];
    
    self.midView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(77), AUTO_MATE_WIDTH(750.0), AUTO_MATE_HEIGHT(50))];
    [footView addSubview:self.midView];
    
    self.midImage = [[UIImageView alloc] initWithFrame:CGRectMake(footView.frame.size.width -AUTO_MATE_WIDTH(45),AUTO_MATE_HEIGHT(7), AUTO_MATE_WIDTH(36), AUTO_MATE_HEIGHT(36))];
    self.midImage.image = [UIImage imageNamed:@"zhuyi"];
    self.midImage.userInteractionEnabled = YES;
    [self.midView addSubview:self.midImage];
    
    UITapGestureRecognizer *midTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(midImageClick:)];
    [self.midView addGestureRecognizer:midTGR];
    
    //用药
    self.medicineLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(18), AUTO_MATE_HEIGHT(132), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(50))];
    self.medicineLabel.textColor = CELL_TXT_COLOR;
    self.medicineLabel.font = [UIFont systemFontOfSize:13.0f];
    [footView addSubview:self.medicineLabel];
}

- (void)topImageClick:(UITapGestureRecognizer *)tgr
{
    [self.delegate showHomePopup:1 indexRow:self.indexRow];
}

- (void)midImageClick:(UITapGestureRecognizer *)tgr
{
    [self.delegate showHomePopup:2 indexRow:self.indexRow];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
