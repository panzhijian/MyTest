//
//  HomeViewController.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootView.h"
#import "Popup.h"
#import "BabyInformation.h"
#import "HomeCell.h"
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FootViewDelegate,PopupDelegate,BabyInformationDelegate,HomePopupDelegate>
{
    //记录滚动偏移量
    NSInteger _scrollViewY;
   
}

//记录是否刷新过首页  只刷新一次 从宝宝回调的界面
@property(nonatomic,assign)BOOL isBabyInformation;

//宝宝记录
@property(nonatomic,strong)NSMutableArray *babyArray;

@property(nonatomic,strong)UIButton *babyBtn;

@property(nonatomic,strong)UITableView *footTable;

@property(nonatomic,strong)UIImageView *topView;

//上方头像
@property(nonatomic,strong)UIImageView *photoImage;
//上方name1
@property(nonatomic,strong)UILabel *momLabel;
//宝宝name
@property(nonatomic,strong)UILabel *babyLabel;

@property(nonatomic,strong)UIImageView *messageImage;
@property(nonatomic,strong)UILabel *messageLabel;

@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIImageView *footImage;

@property(nonatomic,strong)UIButton *minBtn;

@property(nonatomic,strong)UIButton *detailBtn;

@property(nonatomic,strong)UIImageView *addImage;

@property(nonatomic,strong)UIImageView *likeImage;

@property(nonatomic,assign)BOOL isRoper;

@property(nonatomic,strong)Popup *po;

@property(nonatomic,assign)NSInteger  babyYear;
@property(nonatomic,assign)NSInteger  babyMonth;
@property(nonatomic,assign)NSInteger  babyDay;

@property(nonatomic,strong)NSTimer * myTimer;
@property(nonatomic,strong)NSTimer * oneTimer;
@property(nonatomic,assign)NSInteger repeatCount;
@property(nonatomic,strong)NSMutableArray * messageViewArr;
@property(nonatomic,strong)UIView *ringView;
@property(nonatomic,strong)UIView *messageView;
@end
