//
//  FootView.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/28.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "FootView.h"

@implementation FootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createFotViewUI:frame];
    }
    return self;
}

- (void)createFotViewUI:(CGRect)frame
{
    //上方头像
    UIImageView *photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(195), AUTO_MATE_HEIGHT(150), AUTO_MATE_WIDTH(290), AUTO_MATE_HEIGHT(200))];
    photoImage.layer.cornerRadius = photoImage.frame.size.width / 2;
    photoImage.image = [UIImage imageNamed:@"baby car"];
    [self addSubview:photoImage];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(230), AUTO_MATE_HEIGHT(photoImage.frame.size.height + 160), AUTO_MATE_WIDTH(400), AUTO_MATE_HEIGHT(30))];
    messageLabel.text = @"您还没有添加您的宝宝信息";
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:messageLabel];
    
    
    UIButton *addBabyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBabyBtn.frame = CGRectMake(AUTO_MATE_WIDTH(160), AUTO_MATE_HEIGHT(photoImage.frame.size.height +messageLabel.frame.size.height + 180), AUTO_MATE_WIDTH(456), AUTO_MATE_HEIGHT(108));
    addBabyBtn.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:115.0f/255.0f blue:143.0f/255.0f alpha:1];
    [addBabyBtn setTitle:@"添加宝宝信息" forState:UIControlStateNormal];
    [addBabyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBabyBtn.layer.cornerRadius = addBabyBtn.frame.size.height / 2;
    [addBabyBtn addTarget:self action:@selector(addBabyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBabyBtn];
    
}

- (void)addBabyBtnClick
{
    [self.delegate pushBabyInformationViewController];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
