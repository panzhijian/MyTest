//
//  Popup.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/3.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupDelegate <NSObject>

- (void)pushAddInfromationView:(NSInteger)index;

@end

@interface Popup : UIView

- (void)showMyPopupView:(UIView *)view;

- (void)coloseThisView;

- (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic,weak)id<PopupDelegate>delegate;

@property(nonatomic,strong)UIImageView *growImage;

@property(nonatomic,strong)UIImageView *shitImage;

@property(nonatomic,strong)UIImageView *medicationImage;

@property(nonatomic,strong)UIImageView *coloseImage;

@end
