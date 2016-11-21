//
//  HomeViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "HomeViewController.h"
#import "ActionSheetStringPicker.h"
#import "MessageViewController.h"
#import "XBJHealthRecordViewController.h"
#import "UIImageView+AFNetworking.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "BabyInformation.h"
#import "GrowInformation.h"
#import "XBJAddGrowRecordViewController.h"
#import "XBJAddShitRecordViewController.h"
#import "XBJAddDrugRecordViewController.h"
#import "AppDelegate.h"
//#import "MBProgressHUD.h"
#import "SampleModel.h"
#import "MJExtension.h"
#import "XBJReportViewController.h"
#import "NSString+Date.h"
#import "XBJHomePopView.h"
#import "TestingViewController.h"
#import "SHandle.h"
#import "NSString+FontSize.h"
#import"OpenUDID.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import"XBJNetWork.h"

@interface HomeViewController ()

@property (nonatomic,strong) XBJHomePopView *popView;

@end

@implementation HomeViewController

- (XBJHomePopView *)popView
{
    if(!_popView){
        float width = SCREEN_WIDTH - 60;
        float height = 150;
        _popView = [[[UINib nibWithNibName:@"XBJHomePopView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _popView.frame = CGRectMake(0, 0, width, height);
    }
    return _popView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.title = @"首页";
    [self upLoadmobliePhoneInformation];

    self.isRoper = NO;
    
    self.babyArray = [[NSMutableArray alloc] init];
    
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    
    BabyInformation *babyInformation = [[BabyInformation alloc] init];
    babyInformation.delegate = self;
    
    self.navigationController.navigationBar.barTintColor = NAV_COLOR;
    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = color;
    
    if([self performSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(400))];
    self.topView.image = [UIImage imageNamed:@"header bg"];
    self.topView.userInteractionEnabled = YES;
    [self.view addSubview:self.topView];
    
    self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width / 2 - 78), AUTO_MATE_HEIGHT(83), AUTO_MATE_WIDTH(156), AUTO_MATE_HEIGHT(156))];
    [self.photoImage setImageWithURL:[NSURL URLWithString:users.avatarImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.photoImage.layer.cornerRadius = self.photoImage.frame.size.height / 2;
    self.photoImage.layer.masksToBounds = YES;
    [self.topView addSubview:self.photoImage];
    
    //右侧图像
    self.ringView = [[UIView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width - 84), AUTO_MATE_HEIGHT(62), AUTO_MATE_WIDTH(56), AUTO_MATE_HEIGHT(56))];
    self.ringView.userInteractionEnabled = YES;
    [self.topView addSubview:self.ringView];
    
    UIImageView *rigthImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(56), AUTO_MATE_HEIGHT(56))];
    rigthImage.image = [UIImage imageNamed:@"ring"];
    //begin 2016.10.11 时攀 该图片增加立体感
    rigthImage.layer.shadowColor=[UIColor blackColor].CGColor;
    rigthImage.layer.shadowOffset = CGSizeMake(5, 5);
    rigthImage.layer.shadowOpacity = 0.2;
    //end 2016.10.11 时攀 该图片增加立体感
    [self.ringView addSubview:rigthImage];
    
    self.likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(30), AUTO_MATE_HEIGHT(4), AUTO_MATE_WIDTH(15), AUTO_MATE_HEIGHT(15))];
    self.likeImage.hidden = NO;
    self.likeImage.backgroundColor = [UIColor colorWithRed:69.0f/255.0f green:227.0f/255.0f blue:255.0f/255.0f alpha:1];
    self.likeImage.layer.cornerRadius = self.likeImage.frame.size.height / 2;
    [rigthImage addSubview:self.likeImage];
    
    
    UITapGestureRecognizer *rightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightGestureClick:)];
    [self.ringView addGestureRecognizer:rightGesture];
    
    //上方name1
    self.momLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(240), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(50))];
    self.momLabel.text = users.nickName;
    CGSize size;
    size = [self.momLabel.text sizeWithFont:FONT(20) maxSize:CGSizeMake(MAXFLOAT, self.momLabel.frame.size.height)];
    CGRect rect =self.momLabel.frame;
    rect.origin.x=VIEW_SIZE.width/2-size.width/2;
    rect.size = size;
    self.momLabel.frame = rect;

    
    self.momLabel.font = [UIFont systemFontOfSize:20.0f];
    self.momLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    self.momLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:self.momLabel];
    
    //上方name2
    self.babyLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(296), VIEW_SIZE.width, AUTO_MATE_HEIGHT(40))];
    self.babyLabel.textAlignment = NSTextAlignmentCenter;
    self.babyLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:212.0f/255.0f blue:220.0f/255.0f alpha:1];
    self.babyLabel.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:self.babyLabel];
    
    if(users.babyBirthday)
    {
        //当前时间和宝宝出生时间差多少秒
        NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        timeZone = [NSTimeZone systemTimeZone];
        [formatter setTimeZone:timeZone];
        NSDate *userDate = [formatter dateFromString:timeStr];
        
        NSArray *dateArr = [SHandle countAge:userDate aDate:nil];
        NSInteger years = [dateArr[0] integerValue];
        NSInteger months = [dateArr[1] integerValue];
        NSInteger days = [dateArr[2] integerValue];
        
        
        NSString * babyString = [NSString stringWithFormat:@"%@ %ld岁%ld个月%ld天",users.babyNickName,years,months,days];

        
        CGSize size2;
        size2= [babyString sizeWithFont:FONT(15) maxSize:CGSizeMake(MAXFLOAT, self.babyLabel.frame.size.height)];
        CGRect rect2 =self.babyLabel.frame;
        rect2.size = size2;
        rect2.origin.x =VIEW_SIZE.width/2-size2.width/2.0;
        self.babyLabel.frame = rect2;
        self.babyLabel.text = babyString;
        
    }
    else
    {
        self.babyLabel.text = @"";
    }
        [self.topView addSubview:self.babyLabel];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, AUTO_MATE_HEIGHT(400), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01),  AUTO_MATE_HEIGHT(VIEW_SIZE.height - 400))];
    self.footView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:232.0f/255.0f blue:237.0f/255.0f alpha:1];
    [self.view addSubview:self.footView];
    
    //创建界面
    [self performSelector:@selector(createHomeViewUI:) withObject:users];
    
    //消息
    self.messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(360), AUTO_MATE_WIDTH(720), AUTO_MATE_HEIGHT(92))];
    self.messageImage.userInteractionEnabled = YES;
    self.messageImage.image = [UIImage imageNamed:@"yuajiaojuxing"];
    //begin 2016.10.11 时攀 该图片增加立体感

    self.messageImage.layer.shadowColor=[UIColor blackColor].CGColor;
    self.messageImage.layer.shadowOffset = CGSizeMake(7, 5);
    self.messageImage.layer.shadowOpacity = 0.15;
    //end 2016.10.11 时攀 该图片增加立体感
    [self.view addSubview:self.messageImage];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(20), AUTO_MATE_WIDTH(720- 80), AUTO_MATE_HEIGHT(35))];
    self.messageLabel.textColor = TXT_COLOR;
    self.messageLabel.text = @"检测便便，关注宝宝的肠道健康。";
    self.messageLabel.font = [UIFont systemFontOfSize:14.0f];
    self.messageLabel.adjustsFontSizeToFitWidth = YES;
    [self.messageImage addSubview:self.messageLabel];
    [self.messageImage bringSubviewToFront:self.messageLabel];
    
    UITapGestureRecognizer *messageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageImageClick:)];
    [self.messageImage addGestureRecognizer:messageRecognizer];
    
  
    //begin 2016.10.12 时攀 铃铛消息动画
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onAnimation) userInfo:nil repeats:YES];
    self.oneTimer = [NSTimer scheduledTimerWithTimeInterval:1/40.0 target:self selector:@selector(messageAnimation) userInfo:nil repeats:YES];
    
    self.repeatCount=0;
    self.messageViewArr = [NSMutableArray new];
    for (int i=0; i<35; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(AUTO_MATE_WIDTH(22 + i)),@"changeWidth",@(0.6-(0.5/35.0)*i),@"changeAlpha", nil];
        [self.messageViewArr addObject:dict];
    }
    [self.myTimer setFireDate:[NSDate distantFuture]];
    [self.oneTimer setFireDate:[NSDate distantFuture]];
    
    
    
if([[NSUserDefaults standardUserDefaults] objectForKey:@"samepleCode"])
{
    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"我是宝宝采样提醒" message:@"有样品需要绑定,请前往进行绑定!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
}else
{
    
}
    
    
}
-(void)onAnimation
{
    [self.oneTimer setFireDate:[NSDate distantPast]];
}
-(void)messageAnimation
{
    if (self.repeatCount==35) {
        self.repeatCount=0;
        [self.oneTimer setFireDate:[NSDate distantFuture]];
        return;
    }
    self.messageView.hidden=NO;
    CGRect rect = self.messageView.frame;
    rect.size.width = [[_messageViewArr[_repeatCount] objectForKey:@"changeWidth"] floatValue];
    rect.size.height = [[_messageViewArr[_repeatCount] objectForKey:@"changeWidth"] floatValue];
    self.messageView.frame = rect;
    self.messageView.center = self.ringView.center;
    self.messageView.layer.cornerRadius = rect.size.width/2;
    self.messageView.backgroundColor=[UIColor colorWithWhite:1.0 alpha:[[_messageViewArr[_repeatCount] objectForKey:@"changeAlpha"] floatValue]];
    self.repeatCount+=1;
}
-(UIView *)messageView
{
    if (!_messageView) {
        self.messageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(56), AUTO_MATE_HEIGHT(56))];
         self.messageView.center = self.ringView.center;
        [self.topView addSubview:self.messageView];
        [self.topView bringSubviewToFront:self.ringView];
    }
    return _messageView;
}
 //end 2016.10.12 时攀 铃铛消息动画
- (void)createHomeViewUI:(UsersModel *)users
{
    if (!users.babyNickName) {
        FootView *foot = [[FootView alloc] initWithFrame:self.footView.bounds];
        foot.delegate = self;
        [self.footView addSubview:foot];
        
        self.isBabyInformation = NO;
    }
    else
    {
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, AUTO_MATE_HEIGHT(46), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01), AUTO_MATE_HEIGHT(90))];
        [self.footView addSubview:self.headerView];
        
        self.footImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(20), AUTO_MATE_WIDTH(35), AUTO_MATE_HEIGHT(35))];
        self.footImage.image = [UIImage imageNamed:@"footprin"];
        [self.headerView addSubview:self.footImage];
        
        self.babyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.babyBtn.frame = CGRectMake(AUTO_MATE_WIDTH(60),AUTO_MATE_HEIGHT(20), AUTO_MATE_WIDTH(340), AUTO_MATE_HEIGHT(30));
        self.babyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.babyBtn setTitleColor:TXT_COLOR forState:UIControlStateNormal];
        self.babyBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.babyBtn addTarget:self action:@selector(babyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.babyBtn];
        
        self.minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minBtn.frame = CGRectMake(AUTO_MATE_WIDTH(400),AUTO_MATE_HEIGHT(17), AUTO_MATE_WIDTH(32), AUTO_MATE_HEIGHT(32));
        self.minBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"jiantou"]];
        [self.minBtn addTarget:self action:@selector(babyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.minBtn];
        
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"记录详情"];
        [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:15.0f] range:NSMakeRange(0, 4)];
        
        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailBtn.frame = CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width - 200), AUTO_MATE_HEIGHT(18), AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(30));
        [self.detailBtn setAttributedTitle:title forState:UIControlStateNormal];
        [self.detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.detailBtn.titleLabel.font = [UIFont systemFontOfSize:30.0f];
        [self.headerView addSubview:self.detailBtn];
        
        self.footTable = [[UITableView alloc] initWithFrame:CGRectMake(0, AUTO_MATE_HEIGHT(126), VIEW_SIZE.width,AUTO_MATE_HEIGHT(730)) style:UITableViewStylePlain];
        self.footTable.delegate = self;
        self.footTable.dataSource = self;
        self.footTable.backgroundColor = BG_COLOR;
        self.footTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
        self.footTable.bounces=NO;
        [self.footView addSubview:self.footTable];
        
        //添加按钮
        self.addImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width - 144), AUTO_MATE_HEIGHT(VIEW_SIZE.height - 242), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112))];
        self.addImage.image = [UIImage imageNamed:@"plus"];
        self.addImage.userInteractionEnabled = YES;
        [self.view addSubview:self.addImage];
        
        UITapGestureRecognizer *addRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addRecognizerClick:)];
        [self.addImage addGestureRecognizer:addRecognizer];
        
        self.isBabyInformation = YES;
    }
}
// end 2016-9.29 时攀 UI替换
- (void)createGrowRecordInfo
{
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    if([users.babyId integerValue] == 0)
    {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;
    hud.label.text = @"正在加载";
    [hud.label setTextColor:[UIColor whiteColor]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInteger:[users.babyId integerValue]] forKey:@"babyId"];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:POST_GROW_RECORD parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            
            NSLog(@"%d",[NSThread isMainThread]);
            
            for(NSDictionary *dict in [responseObject objectForKey:@"data"])
            {
                UsersModel *model = [[UsersModel alloc] init];
                model.babyBodyWeight = [dict objectForKey:@"bodyWeight"];
                model.createBabyTime = [dict objectForKey:@"dateTime"];
                model.dungNumber = [dict objectForKey:@"dungNumber"];
                model.babyHeadSize = [dict objectForKey:@"headSize"];
                model.babyLength = [dict objectForKey:@"length"];
                model.medicineNumber = [dict objectForKey:@"medicineNumber"];
                model.growState = [dict objectForKey:@"growState"];
                model.dungState = [dict objectForKey:@"dungState"];
                model.headSizeDifference = [dict objectForKey:@"headSizeDifference"];
                model.lengthDifference = [dict objectForKey:@"lengthDifference"];
                model.weightDifference = [dict objectForKey:@"weightDifference"];
                
                if(![[dict objectForKey:@"dungColor"] isKindOfClass:[NSNull class]])
                {
                    model.dungColor = [dict objectForKey:@"dungColor"];
                }
                
                if(![[dict objectForKey:@"trait"] isKindOfClass:[NSNull class]])
                {
                    model.trait = [dict objectForKey:@"trait"];
                }
                
                model.traitState = [dict objectForKey:@"traitState"];
                
                [self.babyArray addObject:model];
            }
        }
        
        if([self.babyArray count] > 0)
        {
            UsersModel *model = [self.babyArray firstObject];
            
//            //读取数据库
//            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
//            UsersModel *users = [[qiao selectAllFromTable] lastObject];
//            
//            //当前时间和宝宝出生时间差多少秒
//            NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateStyle:NSDateFormatterMediumStyle];
//            [formatter setTimeStyle:NSDateFormatterShortStyle];
//            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//            timeZone = [NSTimeZone systemTimeZone];
//            [formatter setTimeZone:timeZone];
//            NSDate *userDate = [formatter dateFromString:timeStr];
//            
//            NSString* timeStr1 = [NSString stringWithFormat:@"%@ 00:00:00",model.createBabyTime];
//            //获取当前到出生的秒数
//            NSDate *userDate1 = [formatter dateFromString:timeStr1];
//            
//            NSArray *dateArr = [SHandle countAge:userDate aDate:userDate1];
//            NSInteger years = [dateArr[0] integerValue];
//            NSInteger months = [dateArr[1] integerValue];
//            NSInteger days = [dateArr[2] integerValue];
//            
//            
//            NSString *timeString  = [NSString stringWithFormat:@"%@ %ld岁%ld月%ld天",model.createBabyTime,years,months,days];
            
            NSString *timeString = [self ageString:model];
            
            //begin 2016.10.10 时攀 记录选取位置适配
            CGSize size;
            size = [timeString  sizeWithFont:FONT(15) maxSize:CGSizeMake(MAXFLOAT, self.babyBtn.frame.size.height)];
            CGRect rect =self.babyBtn.frame;
            rect.size = size;
            self.babyBtn.frame = rect;
            
            CGPoint point;
            point=self.minBtn.frame.origin;
            point.x = CGRectGetMaxX(rect) + 5;
            point.y = self.minBtn.frame.origin.y;
            CGRect rectMinbtn = self.minBtn.frame;
            rectMinbtn.origin = point;
            self.minBtn.frame=rectMinbtn;
             //end 2016.10.10 时攀 记录选取位置适配
            
            [self.babyBtn setTitle:timeString forState:UIControlStateNormal];
        }
        
        [self.footTable reloadData];
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [self.navigationController.view makeToast:error.localizedDescription
                                         duration:1.0
                                         position:CSToastPositionCenter];
    }];
}


//begin 2016.10.14 时攀 年龄计算提取
-(NSString *)ageString:(UsersModel *)model
{
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    //当前时间和宝宝出生时间差多少秒
    NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",users.babyBirthday];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *userDate = [formatter dateFromString:timeStr];
    
    NSArray *dateArr;
    if (model) {
        NSString* timeStr1 = [NSString stringWithFormat:@"%@ 00:00:00",model.createBabyTime];
        //获取目标时间到出生的秒数
        NSDate *userDate1 = [formatter dateFromString:timeStr1];
        
        dateArr = [SHandle countAge:userDate aDate:userDate1];
    }
    else{
        dateArr = [SHandle countAge:userDate aDate:nil];
    }
    
    NSInteger years = [dateArr[0] integerValue];
    NSInteger months = [dateArr[1] integerValue];
    NSInteger days = [dateArr[2] integerValue];
    
    NSString *timeString;
    if (model) {
        timeString  = [NSString stringWithFormat:@"%@ %ld岁%ld个月%ld天",model.createBabyTime,years,months,days];
    }else
    {
        timeString  = [NSString stringWithFormat:@"%ld岁%ld个月%ld天",years,months,days];
    }
    
    return timeString;
}
//end 2016.10.14 时攀 年龄计算提取

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.messageView.hidden=YES;
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.tabBarController setSelectedIndex:0];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];

    
    
    [self.photoImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_IP_2,users.avatarImg]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    if([self.babyArray count] > 0)
    {
        [self.babyArray removeAllObjects];
    }
    
    [self performSelector:@selector(createGrowRecordInfo)];
    
    [self performSelector:@selector(SampleInformationSource)];
    
    [self performSelector:@selector(showNewView)];
    
    [self performSelector:@selector(getComment)];
}


- (void)getComment
{
    //请求成功后将数据更新到本地
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    if(!users.customerId)
    {
        return;
    }
    
    AFHTTPSessionManager *manage = [[AFHTTPSessionManager alloc] init];
    [manage GET:POST_COMMENT_OPINION parameters:@{@"customerId":users.customerId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject objectForKey:@"data"])
        {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            //时攀   消息badge开关
            if([[dict objectForKey:@"commentNum"] integerValue] > 0||[[dict objectForKey:@"praiseNum"] integerValue] > 0)
            {
                self.likeImage.hidden = NO;
                [self.myTimer setFireDate:[NSDate distantPast]];
            }
            else
            {
                self.likeImage.hidden = YES;
                self.messageView.hidden=YES;
                [self.myTimer setFireDate:[NSDate distantFuture]];
//                [self.myTimer setFireDate:[NSDate distantPast]];
            }

            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)showNewView
{
    if(self.isBabyInformation)
    {
        return;
    }
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    [self performSelector:@selector(createHomeViewUI:) withObject:users];
}

- (void)SampleInformationSource
{
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:POST_REPORTS parameters:@{@"babyId":[NSNumber numberWithInteger:[users.babyId integerValue]]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"FAILURE"])
        {
            return;
        }
        
        NSDictionary *dict = [[responseObject objectForKey:@"data"] lastObject];
        SampleModel *sample = [SampleModel objectWithKeyValues:dict];
        
        if(sample.reportTime)
        {
            
            //当前时间和宝宝出生时间差多少秒
            NSString* timeStr = (NSString *)sample.collectTime;
            NSString *newTime = [NSString stringWithFormat:@"%@:00",timeStr];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
            timeZone = [NSTimeZone systemTimeZone];
            [formatter setTimeZone:timeZone];
            NSDate *userDate = [formatter dateFromString:newTime];
            
            if([sample.reportState isEqualToString:@"ABNORMAL"])
            {
                NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@检测报告有异常,查看详情!",[NSString stringDateFromDate:userDate withFormat:SHORT_DATE_TIME_FORMAT]]];
                NSRange contentRange = {15,2};
                [content addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFE738d) range:contentRange];
                self.messageLabel.attributedText = content;
                
            }
            else
            {
                self.messageLabel.text = [NSString stringWithFormat:@"%@检测报告已出,查看详情!",[NSString stringDateFromDate:userDate withFormat:SHORT_DATE_TIME_FORMAT]];
            }
            
            self.isRoper = YES;
        }
        else
        {
            self.messageLabel.text = @"检测便便，关注宝宝的肠道健康。";
        }
        
        [self performSelector:@selector(calculationTime:) withObject:sample];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

#pragma mark -- 计算时间
- (void)calculationTime:(SampleModel *)sample
{
    //获取注册时间
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    NSString* timeStr = users.createTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *userDate = [formatter dateFromString:timeStr];
    
    //获取绑定时间
    NSString* timeStr1 = [NSString stringWithFormat:@"%@",sample.collectTime];
    NSDate *sampleDate = [formatter dateFromString:timeStr1];
    
    NSTimeInterval twentyFive = 25*24*60*60;
    NSTimeInterval forty = 40*24*60*60;
    
    if(sampleDate)
    {
        //计算时间差是否是25天
        NSTimeInterval secondsInterval= [[NSDate date] timeIntervalSinceDate:sampleDate];
        
        if(secondsInterval >= twentyFive && secondsInterval <= forty)
        {
            self.messageLabel.text = @"这个月还没给宝宝检测便便，记得来检测哦！";
        }
        else if(secondsInterval >= forty)
        {
            self.messageLabel.text = @"持续关注宝宝肠道健康，快来检测吧！";
        }
    }
    else
    {
        //计算时间差是否是25天
        NSTimeInterval secondsInterval= [[NSDate date] timeIntervalSinceDate:userDate];
        if(secondsInterval >= twentyFive && secondsInterval <= forty)
        {
            self.messageLabel.text = @"宝宝拉肚子便秘？便便酸臭？来检测便便看看";
        }
        else if(secondsInterval >= forty)
        {
            //计算时间差是否是40天
            self.messageLabel.text = @"行动起来，检测便便，关注健康，更懂宝宝";
        }
    }
}

- (void)messageImageClick:(UITapGestureRecognizer *)messageRecognizer
{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.selectedIndex = 1;
    if(self.isRoper)
    {
        XBJReportViewController *vc = [[XBJReportViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.tabBarController.selectedViewController pushViewController:vc animated:YES];
    }
}

#pragma mark -- 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.babyArray count];
    
}

#pragma mark -- 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO_MATE_HEIGHT(303);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeCell = @"homeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCell];
    
    if(!cell)
    {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCell];
    }
    cell.delegate = self;
    
    UsersModel *model;
    if(self.babyArray.count>0)
    {
        model = [self.babyArray objectAtIndex:indexPath.row];

    }

    if([model.growState boolValue] && ([model.lengthDifference floatValue] > 0 ||[model.lengthDifference floatValue] < 0 || [model.headSizeDifference floatValue] > 0 ||[model.headSizeDifference floatValue] < 0 || [model.weightDifference floatValue] > 0 ||[model.weightDifference floatValue] < 0))
    {
        cell.topImage.hidden = NO;
        cell.topImage.userInteractionEnabled = YES;
        cell.topView.userInteractionEnabled = YES;
    }
    else
    {
        cell.topImage.hidden = YES;
        cell.topImage.userInteractionEnabled = YES;
        cell.topView.userInteractionEnabled = NO;
    }
    
    if([model.dungState boolValue] || [model.traitState boolValue])
    {
        cell.midImage.hidden = NO;
        cell.midImage.userInteractionEnabled = YES;
        cell.midView.userInteractionEnabled = YES;
    }
    else
    {
        cell.midImage.hidden = YES;
        cell.midImage.userInteractionEnabled = YES;
        cell.midView.userInteractionEnabled = NO;
    }
    
    if([model.babyHeadSize floatValue] > 0 || [model.babyLength floatValue] > 0 || [model.babyBodyWeight floatValue] > 0)
    {
        cell.headerLabel.text = [NSString stringWithFormat:@"头围:%.1lfcm",[model.babyHeadSize floatValue]];
        cell.heightLabel.text = [NSString stringWithFormat:@"身高:%.1lfcm",[model.babyLength floatValue]];
        cell.weightLabel.text = [NSString stringWithFormat:@"体重:%.1lfkg",[model.babyBodyWeight floatValue]];
    }
    else
    {
        cell.headerLabel.text = @"";
        cell.heightLabel.text = @"";
        cell.weightLabel.text = @"";
    }
    cell.timeLabel.text = [self ageString:model];
    
    if([model.dungNumber integerValue] > 0)
    {
        cell.shitLabel.text = [NSString stringWithFormat:@"便便 %ld次",[model.dungNumber integerValue]];
    }
    else
    {
        cell.shitLabel.text = @"";
    }
    
    if([model.medicineNumber integerValue] > 0)
    {
        cell.medicineLabel.text = [NSString stringWithFormat:@"用药 %ld次",[model.medicineNumber integerValue]];
    }
    else
    {
        cell.medicineLabel.text = @"";
    }
    
    cell.indexRow = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark -- tableView滚动代理  制作首页动画
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_messageView) {
    _messageView.hidden = YES;
    }
    if([self.babyArray count] < 4)
    {
        return;
    }
    
        if (scrollView.contentOffset.y <= 0 || scrollView.contentOffset.y < _scrollViewY)
        {
            [UIView animateWithDuration:0.75 animations:^{
                CGRect topRect = self.topView.frame;
                topRect = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(400));
                self.topView.frame = topRect;
                
                CGRect photoRect = self.photoImage.frame;
                photoRect = CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width / 2 - 78), AUTO_MATE_HEIGHT(83), AUTO_MATE_WIDTH(156), AUTO_MATE_HEIGHT(156));

                self.photoImage.layer.cornerRadius = self.photoImage.layer.bounds.size.height / 2;
                self.photoImage.layer.masksToBounds = YES;
                self.photoImage.frame = photoRect;
                
                CGSize size;
                size = [self.momLabel.text sizeWithFont:FONT(20) maxSize:CGSizeMake(MAXFLOAT, self.momLabel.frame.size.height)];
                CGRect rect =self.momLabel.frame;
                rect.origin.x=VIEW_SIZE.width/2-rect.size.width/2;
                rect.size = size;
                rect.origin.y = AUTO_MATE_HEIGHT(240);
//                momRect = CGRectMake(AUTO_MATE_WIDTH(100), AUTO_MATE_HEIGHT(240), AUTO_MATE_WIDTH(550), AUTO_MATE_HEIGHT(50));
                self.momLabel.frame = rect;
                
                self.babyLabel.frame = CGRectMake(AUTO_MATE_WIDTH(VIEW_SIZE.width / 2 - 150), AUTO_MATE_HEIGHT(298), AUTO_MATE_WIDTH(300), AUTO_MATE_HEIGHT(30));
                self.babyLabel.hidden = NO;
                self.babyLabel.alpha = 1;
                
                
                self.messageImage.frame = CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(360), AUTO_MATE_WIDTH(720), AUTO_MATE_HEIGHT(92));
                
                self.messageLabel.frame = CGRectMake(AUTO_MATE_WIDTH(40), AUTO_MATE_HEIGHT(20), AUTO_MATE_WIDTH(VIEW_SIZE.width - 40), AUTO_MATE_HEIGHT(35));
                
//                self.footView.frame = CGRectMake(0, AUTO_MATE_HEIGHT(400), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01),  AUTO_MATE_HEIGHT(VIEW_SIZE.height - 400));
                 self.footView.frame = CGRectMake(0, AUTO_MATE_HEIGHT(400), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01), VIEW_SIZE.height- AUTO_MATE_HEIGHT(400));
                
                self.headerView.frame = CGRectMake(0, AUTO_MATE_HEIGHT(46), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01), AUTO_MATE_HEIGHT(90));
                
                self.footTable.frame = CGRectMake(0, AUTO_MATE_HEIGHT(126), VIEW_SIZE.width,AUTO_MATE_HEIGHT(730));
                
                self.addImage.frame = CGRectMake(VIEW_SIZE.width - AUTO_MATE_WIDTH(144), VIEW_SIZE.height - AUTO_MATE_HEIGHT(128), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112));
                //2016-9.29 时攀 上滑加号值由no改为yes
                self.addImage.hidden = YES;
            }];
            _scrollViewY = scrollView.contentOffset.y+9;
        }
        else if(scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height)
        {
            [UIView animateWithDuration:0.35 animations:^{
                self.addImage.frame =CGRectMake(VIEW_SIZE.width - AUTO_MATE_WIDTH(144), VIEW_SIZE.height - AUTO_MATE_HEIGHT(242), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112));
                self.addImage.hidden = NO;
            }];
        }    //begin 2016-9.30  时攀  解决首页动画闪烁问题增加唯一条件scrollView.contentOffset.y > _scrollViewY
        else if(scrollView.contentOffset.y > _scrollViewY)
        {
            //变小动画
            [UIView animateWithDuration:0.75 animations:^{
                self.topView.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), VIEW_SIZE.width, AUTO_MATE_HEIGHT(128));
                
                self.photoImage.frame = CGRectMake(AUTO_MATE_WIDTH(14), AUTO_MATE_HEIGHT(62), AUTO_MATE_WIDTH(56), AUTO_MATE_HEIGHT(56));

                self.photoImage.layer.cornerRadius = self.photoImage.layer.bounds.size.height / 2;
                self.photoImage.layer.masksToBounds = YES;
                
                CGRect momRect = self.momLabel.frame;
                momRect = CGRectMake(AUTO_MATE_WIDTH(80), AUTO_MATE_HEIGHT(64), self.momLabel.frame.size.width, self.momLabel.frame.size.height);
                self.momLabel.frame = momRect;
                self.momLabel.textAlignment = NSTextAlignmentCenter;
                
                self.babyLabel.frame = CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), self.babyLabel.frame.size.width, self.babyLabel.frame.size.height);
                self.babyLabel.alpha = 0;
                self.babyLabel.textAlignment = NSTextAlignmentCenter;
                
            
                
                self.messageImage.frame = CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(148), AUTO_MATE_WIDTH(720), AUTO_MATE_HEIGHT(92));
                
                 self.footView.frame = CGRectMake(0, AUTO_MATE_HEIGHT(128), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01), VIEW_SIZE.height- AUTO_MATE_HEIGHT(128));
                
                self.headerView.frame = CGRectMake(0, AUTO_MATE_HEIGHT(112), AUTO_MATE_WIDTH(VIEW_SIZE.width - 0.01), AUTO_MATE_HEIGHT(90));
                
                self.footTable.frame = CGRectMake(0, AUTO_MATE_HEIGHT(192), VIEW_SIZE.width,AUTO_MATE_HEIGHT(950));
                
                self.addImage.frame = CGRectMake(self.addImage.frame.origin.x, AUTO_MATE_HEIGHT(VIEW_SIZE.height + 10), self.addImage.frame.size.width, self.addImage.frame.size.height);
                self.addImage.hidden = YES;
            }completion:^(BOOL finished) {
            }];
            
        }

    _scrollViewY = scrollView.contentOffset.y;
    
}

#pragma mark -- tableView滚动代理  制作首页动画 滚动到最后执行的事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_messageView) {
        _messageView.hidden = YES;
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.addImage.frame = CGRectMake(VIEW_SIZE.width - AUTO_MATE_WIDTH(144), VIEW_SIZE.height - AUTO_MATE_HEIGHT(128), AUTO_MATE_WIDTH(112), AUTO_MATE_HEIGHT(112));
        self.addImage.hidden = NO;
    }];
}

#pragma mark -- 点击宝贝时间触发的事件babyBtnClick
- (void)babyBtnClick
{
    NSMutableArray *titmeArray = [[NSMutableArray alloc] init];
    
    //读取数据库
    //    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    //    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    for(UsersModel *model in self.babyArray)
    {

         NSString *timeString = [self ageString:model];
        [titmeArray addObject:timeString];
    }
    
    if([titmeArray count] == 0)
    {
        return;
    }
    
    
    ActionSheetStringPicker *actionSheet = [[ActionSheetStringPicker alloc] initWithTitle:@"时间" rows:titmeArray initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        NSIndexPath *indexPat = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [self.footTable scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionTop animated:YES];
         //begin 2016.10.10 时攀 记录选取位置适配
        CGSize size;
        size = [selectedValue  sizeWithFont:FONT(15) maxSize:CGSizeMake(MAXFLOAT, self.babyBtn.frame.size.height)];
        CGRect rect =self.babyBtn.frame;
        rect.size = size;
        self.babyBtn.frame = rect;
        
        CGPoint point;
        point=self.minBtn.frame.origin;
        point.x = CGRectGetMaxX(rect) + 5;
        point.y = self.minBtn.frame.origin.y;
        CGRect rectMinbtn = self.minBtn.frame;
        rectMinbtn.origin = point;
        self.minBtn.frame=rectMinbtn;
         //end 2016.10.10 时攀 记录选取位置适配
        [self.babyBtn setTitle:selectedValue forState:UIControlStateNormal];
        
        [self.footTable reloadData];
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        NSLog(@"取消");
    } origin:self.babyBtn];
    
    [actionSheet setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确 定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
    [actionSheet setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取 消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    [actionSheet showActionSheetPicker];
    actionSheet = nil;
}

#pragma mark -- 点击详情页触发的事件detailBtnClick
- (void)detailBtnClick
{
    NSLog(@"跳转到详情页");
    self.navigationController.navigationBar.hidden = NO;
    
    XBJHealthRecordViewController *vc = [[XBJHealthRecordViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 点击跳转到消息界面
- (void)rightGestureClick:(UITapGestureRecognizer *)rightGesture
{
    self.navigationController.navigationBar.hidden = NO;
    
    MessageViewController *message = [[MessageViewController alloc] init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
    
    NSLog(@"跳转到消息界面");
}

#pragma mark -- 弹出添加信息界面
- (void)addRecognizerClick:(UITapGestureRecognizer *)addRecognizer
{
    self.addImage.hidden = YES;
    //添加PopupView
    self.po = [[Popup alloc] initWithFrame:self.view.bounds];
    self.po.delegate = self;
    [self.po showMyPopupView:self.navigationController.view];
    self.po.hidden = NO;
    
    self.tabBarController.view.userInteractionEnabled = NO;
}

#pragma mark -- PopupDelegate
- (void)pushAddInfromationView:(NSInteger)index
{
    switch (index) {
        case 1:
        {
            self.navigationController.navigationBar.hidden = NO;
            XBJAddGrowRecordViewController *grow = [[XBJAddGrowRecordViewController alloc] init];
            grow.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:grow animated:YES];
            
            [self.po coloseThisView];
            self.po = nil;
        }
            break;
        case 2:
        {
            self.navigationController.navigationBar.hidden = NO;
            XBJAddShitRecordViewController *grow = [[XBJAddShitRecordViewController alloc] init];
            grow.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:grow animated:YES];
            
            [self.po coloseThisView];
            self.po = nil;
        }
            break;
        case 3:
        {
            self.navigationController.navigationBar.hidden = NO;
            XBJAddDrugRecordViewController *grow = [[XBJAddDrugRecordViewController alloc] init];
            grow.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:grow animated:YES];
            
            [self.po coloseThisView];
            self.po = nil;
            
        }
            break;
        default:
            break;
    }
    
    //显示添加按钮
    self.addImage.hidden = NO;
    self.tabBarController.view.userInteractionEnabled = YES;
}

- (void)showHomePopup:(NSInteger)number indexRow:(NSInteger)indexRow
{
    UsersModel *model;
    if (self.babyArray.count>0) {
        model = [self.babyArray objectAtIndex:indexRow];
    }
    

    if(number == 2)
    {
        [self.popView showWithBlock:^(MMPopupView *popupView, BOOL finished){
            self.popView.detailLabel_1.text = @"";
            self.popView.detailLabel_2.text = @"";
            self.popView.titleLabel_1.text = @"";
            self.popView.titleLabel_2.text = @"";
            self.popView.detailLabel.text = @"";
            CGRect rect = self.popView.frame;
            rect.size.height += AUTO_MATE_HEIGHT(250);
            self.popView.frame = rect;
            self.popView.detailLabel.textColor = TXT_RED_COLOR;
            self.popView.detailLabel.font = [UIFont systemFontOfSize:14.0f];
            self.popView.titleLabel.text = @"";
            self.popView.detailLabel.text = @"";
            
            if([model.trait isEqualToString:@"WATERY"])
            {
                
                if([model.trait isEqualToString:@"WATERY"])
                {
                    self.popView.detailLabel.text = @"宝宝腹泻时，便便中水分增多，呈汤样，且排便次数和量有所增加。同时，宝宝腹泻还会出现哭闹、进食差、睡眠不安等其他不适症状。\n  引起宝宝腹泻的原因很多，一类为非感染性因素造成，饮食喂养不当或天气变化均可引起腹泻。一类由感染性的病毒、细菌、真菌、寄生虫引起的腹泻。还有因继发一些疾病或药物使用后引起的腹泻。\n  腹泻时，要注意预防和纠正脱水，并及时补充营养。最好将宝宝的便便送检，以便及早寻找引起宝宝腹泻的原因，对症治疗。";
                }
                
                if ([model.dungColor isEqualToString:@"RED"])
                {
                    self.popView.detailLabel.text = @"宝宝的便便发红，需先考虑是否因过量食用红色果蔬及食物等因素导致。此外，最有可能造成红色便便的原因是大便带血，要观察血液是否与大便混合：如果血液覆于大便表层，或与肛裂、痔疮有关，多见于便秘；如果大便带血且与大便混合，说明肠道有损伤，也可能与肠道过敏、感染等有关，需及时就医。";
                }
            }
            else if([model.trait isEqualToString:@"HARD_DRY"])
            {
                if ([model.dungColor isEqualToString:@"RED"])
                {
                    self.popView.detailLabel.text = @"宝宝的便便发红，需先考虑是否因过量食用红色果蔬及食物等因素导致。此外，最有可能造成红色便便的原因是大便带血，要观察血液是否与大便混合：如果血液覆于大便表层，或与肛裂、痔疮有关，多见于便秘；如果大便带血且与大便混合，说明肠道有损伤，也可能与肠道过敏、感染等有关，需及时就医。";
                }
                else
                {
                    self.popView.detailLabel.text = @"宝宝便便干结同时伴有排便困难，称之为便秘。宝宝喝水不够、配方奶调配偏稠、食物加工过细过精、食物过敏、先天性肠道畸形等都可能引起便秘。建议通过改善饮食结构、适当补充益生菌及益生元、培养宝宝良好的排便习惯等方式来预防和纠正便秘。";
                }
            }
            else
            {
                if ([model.dungColor isEqualToString:@"RED"])
                {
                    self.popView.detailLabel.text = @"宝宝的便便发红，需先考虑是否因过量食用红色果蔬及食物等因素导致。此外，最有可能造成红色便便的原因是大便带血，要观察血液是否与大便混合：如果血液覆于大便表层，或与肛裂、痔疮有关，多见于便秘；如果大便带血且与大便混合，说明肠道有损伤，也可能与肠道过敏、感染等有关，需及时就医。";
                }
            }
        }];
    }
    else if (number == 1)
    {
        [self.popView showWithBlock:^(MMPopupView *popupView, BOOL finished){
            CGRect rect = self.popView.frame;
            rect.size.height += AUTO_MATE_HEIGHT(250);
            self.popView.frame = rect;
            self.popView.detailLabel.textColor = TXT_RED_COLOR;
            self.popView.detailLabel.font = [UIFont systemFontOfSize:14.0f];
            self.popView.detailLabel.text = @"";
            self.popView.detailLabel_1.text = @"";
            self.popView.detailLabel_2.text = @"";
            self.popView.titleLabel_1.text = @"";
            self.popView.titleLabel_2.text = @"";
            
            NSString *labelString = @"";
            if([model.headSizeDifference floatValue] > 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝头围为 %.2f cm,头围偏大",[model.babyHeadSize floatValue]];
                self.popView.titleLabel.text = labelString;
            }
            else if([model.headSizeDifference floatValue] < 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝头围为 %.2f cm,头围偏小",[model.babyHeadSize floatValue]];
                self.popView.titleLabel.text = labelString;
            }
            else
            {
                self.popView.titleLabel.text = @"";
            } 
            
            if([model.lengthDifference floatValue] > 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝身高为 %.2f cm,身高偏高",[model.babyLength floatValue]];
                self.popView.titleLabel_1.text = labelString;
            }
            else if([model.lengthDifference floatValue] < 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝身高为 %.2f cm,身高偏低",[model.babyLength floatValue]];
                self.popView.titleLabel_1.text = labelString;
            }
            else
            {
                self.popView.titleLabel_1.text = @"";
            }
            
            if([model.weightDifference floatValue] > 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝体重为 %.2f kg,体重偏重",[model.babyBodyWeight floatValue]];
                self.popView.titleLabel_2.text = labelString;
            }
            else if([model.weightDifference floatValue] < 0)
            {
                labelString = [NSString stringWithFormat:@"你的宝宝体重为 %.2f kg,体重偏轻",[model.babyBodyWeight floatValue]];
                self.popView.titleLabel_2.text = labelString;
            }
            else
            {
                self.popView.titleLabel_2.text = @"";
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"跳转到详情页");
    //    self.navigationController.navigationBar.hidden = NO;
    //
    //    XBJHealthRecordViewController *vc = [[XBJHealthRecordViewController alloc] init];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- FootViewDelegate
- (void)pushBabyInformationViewController
{
    self.navigationController.navigationBar.hidden = NO;
    BabyInformation *baby = [[BabyInformation alloc] init];
    [self.navigationController pushViewController:baby animated:YES];
}

-(void)upLoadmobliePhoneInformation
{
    NSString* openUDID = [OpenUDID value];
    NSString *customerId = [XBJAppHelper SQLUser].customerId;
    NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString* systemName = [self getCurrentDeviceModel];
    
    
    
    NSString *key = @"CFBundleInfoDictionaryVersion";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    [[XBJNetWork sharedInstance] upLoadMobilePhone:systemName deviceSysVersion:systemVersion appVersion:currentVersion uuid:openUDID customerId:customerId block:^(NSError *error) {
        if(error)
        {
            [self.navigationController.view makeToast:error.localizedDescription
                                             duration:1.0
                                             position:CSToastPositionCenter];
        }else{
            
        }
    }];
    
    
}
-(NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
