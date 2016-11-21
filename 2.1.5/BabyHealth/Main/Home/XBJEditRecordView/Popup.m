//
//  Popup.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/3.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "Popup.h"

@implementation Popup

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
    }
    return self;
}

- (void)createPopupViewUI:(UIView *)view
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    bgView.alpha = 0.8f;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    [window addSubview:self];
    
    //添加用药按钮
    self.growImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(view.frame.size.width - 142), AUTO_MATE_HEIGHT(view.frame.size.height - 130), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112))];
    self.growImage.image = [UIImage imageNamed:@"yongyao"];
    self.growImage.userInteractionEnabled = YES;
    [self addSubview:self.growImage];
    
    UITapGestureRecognizer *growRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(medicationRecognizerClick:)];
    [self.growImage addGestureRecognizer:growRecognizer];
    
    //添加便便按钮
    self.shitImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(view.frame.size.width - 142), AUTO_MATE_HEIGHT(view.frame.size.height - 110), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112))];
    self.shitImage.image = [UIImage imageNamed:@"bianbian"];
    self.shitImage.userInteractionEnabled = YES;
    [self addSubview:self.shitImage];
    
    UITapGestureRecognizer *shitRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shitRecognizerClick:)];
    [self.shitImage addGestureRecognizer:shitRecognizer];
    
    //添加生长按钮
    self.medicationImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(view.frame.size.width - 142), AUTO_MATE_HEIGHT(view.frame.size.height - 140), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112))];
    self.medicationImage.image = [UIImage imageNamed:@"shengzhang"];
    self.medicationImage.userInteractionEnabled = YES;
    [self addSubview:self.medicationImage];
    
    UITapGestureRecognizer *medicationRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(growRecognizerClick:)];
    [self.medicationImage addGestureRecognizer:medicationRecognizer];
    
    //关闭按钮
    self.coloseImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(view.frame.size.width - 142), AUTO_MATE_HEIGHT(view.frame.size.height - 242), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112))];
    self.coloseImage.image = [UIImage imageNamed:@"cancel"];
    self.coloseImage.userInteractionEnabled = YES;
    [self addSubview:self.coloseImage];
    
    UITapGestureRecognizer *coloseRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coloseRecognizerClick:)];
    [self.coloseImage addGestureRecognizer:coloseRecognizer];
    
}

- (void)showMyPopupView:(UIView *)view
{
    [self createPopupViewUI:view];
    
    [UIView animateWithDuration:0.75 animations:^{
        //成长动画
        self.growImage.transform = CGAffineTransformRotate(self.growImage.transform, M_PI);
        self.growImage.transform = CGAffineTransformRotate(self.growImage.transform, M_PI);
        CGRect growRect = self.growImage.frame;
        growRect.origin.y = AUTO_MATE_HEIGHT(view.frame.size.height - 364);
        self.growImage.frame = growRect;
        
        //关闭动画
        self.coloseImage.transform = CGAffineTransformRotate(self.coloseImage.transform, M_PI * 3);
        CGRect coloseRect = self.coloseImage.frame;
        self.coloseImage.frame = coloseRect;
        
            [UIView animateWithDuration:0.95 animations:^{
                
                //便便动画
                self.shitImage.transform = CGAffineTransformRotate(self.shitImage.transform, M_PI);
                self.shitImage.transform = CGAffineTransformRotate(self.shitImage.transform, M_PI);
                CGRect shitRect = self.shitImage.frame;
                shitRect.origin.y = AUTO_MATE_HEIGHT(view.frame.size.height - 484);
                self.shitImage.frame = shitRect;
                
                [UIView animateWithDuration:0.95 animations:^{
                    //用药动画
                    self.medicationImage.transform = CGAffineTransformRotate(self.medicationImage.transform, M_PI);
                    self.medicationImage.transform = CGAffineTransformRotate(self.medicationImage.transform, M_PI);
                    CGRect medicationRect = self.medicationImage.frame;
                    medicationRect.origin.y = AUTO_MATE_HEIGHT(view.frame.size.height - 604);
                    self.medicationImage.frame = medicationRect;
                }];
            }];
    }];
}

#pragma mark -- 添加成长记录
- (void)growRecognizerClick:(UITapGestureRecognizer *)growRecognizer
{
    [self.delegate pushAddInfromationView:1];
}

#pragma mark -- 添加便便记录
-(void)shitRecognizerClick:(UITapGestureRecognizer *)shitRecognizer
{
    [self.delegate pushAddInfromationView:2];
}

#pragma mark -- 添加用药记录
-(void)medicationRecognizerClick:(UITapGestureRecognizer *)medicationRecognizer
{
    [self.delegate pushAddInfromationView:3];
}

#pragma mark -- 关闭界面
- (void)coloseRecognizerClick:(UITapGestureRecognizer *)coloseRecognizer
{
    [self removeFromSuperview];
    [self.delegate pushAddInfromationView:4];
}

- (void)coloseThisView
{
    [self removeFromSuperview];
}

@end
