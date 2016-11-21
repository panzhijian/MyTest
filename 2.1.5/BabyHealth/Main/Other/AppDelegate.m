//
//  AppDelegate.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "BabyHealthViewController.h"
#import "MessageViewController.h"
#import "HomeViewController.h"
#import "TestingViewController.h"
#import "XBJReportViewController.h"
#import "PostDetails.h"

#import "RetrieveViewController.h"
#import "UsersModel.h"
#import "QIAODBMangerEx.h"
#import "MessageModel.h"

#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"

#import "NSString+Date.h"
#import <UMMobClick/MobClick.h>

#define SUPPORT_IOS8 1
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()
{
    BabyHealthViewController *_baby;
    NSDictionary *_receiveUserInfo;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//        [Fabric with:@[[Crashlytics class]]];
    
    [UMSocialData setAppKey:UMENG_KEY];
    UMConfigInstance.appKey = UMENG_KEY;
    [MobClick startWithConfigure:UMConfigInstance];
    
    //        // begain  modify 潘志健  10-12  添加应用统计功能
        UMConfigInstance.appKey = UMENG_KEY;
        UMConfigInstance.channelId = @"App Store";
        [MobClick startWithConfigure:UMConfigInstance];
    
    
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [MobClick setAppVersion:version];
    
    //    //end  modify  潘志健 10-12
    
    //打开调试log的开关
    // [UMSocialData openLog:YES];
    
    
    // begain  modify 潘志健  10-11
    //设置微信AppId，设置分享url，默认使用友盟的网址
    //  [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    
    [UMSocialWechatHandler setWXAppId:@"wx966d40fb269c4f2b" appSecret:@"119b109b3aed2b347e5ba07fba393359" url:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    //end  modify  潘志健 10-11
    
    
    
    // begain  modify 潘志健  10-11
    //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
    // [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105609330" appKey:@"KEY3kg78fjmdLDDtwOU" url:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    //end  modify  潘志健 10-11
    
    
    
    
    
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" secret:@"04b48b094faeb16683c32669824ebdad" RedirectURL:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    
    
    // begain  modify 潘志健  10-11
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    //    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    
    //end  modify  潘志健 10-11
    
    
    
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //创建数据
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [application registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:BAIDU_PUSH_KEY pushMode:BPushModeProduction withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
    }
    
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:-1];
    
    
    //begin 2016.9.27 时攀 请求更新
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:GET_UPAPP parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([[responseObject objectForKey:@"result"] isEqualToString:@"SUCCESS"])
        {
            for(NSDictionary *dict in [responseObject objectForKey:@"data"])
            {
                if ([dict[@"lauchState"] isEqualToString:@"true"]) {
                    [self creatUPNotification];
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"检查更新没有开启");
    }];
    //end 2016.9.27 时攀 请求更新
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    
    //创建通知类型数据库
    QIAODBMangerEx *birthQiao = [[QIAODBMangerEx alloc] initWithFirst:@"BabyHealth" tableName:@"MessageModel" modelClass:[MessageModel class]  autoincrement:YES];
    birthQiao = nil;
    
    
    //判断是否登录过，未登录进入GuideViewController页面
    //登录过进入BabyHealthViewController页面
    if([users.customerId integerValue] > 0)
    {
        _baby = [[BabyHealthViewController alloc] init];
        self.window.rootViewController = _baby;
    }
    else
    {
        GuideViewController *guide = [[GuideViewController alloc] init];
        UINavigationController *guideNav = [[UINavigationController alloc] initWithRootViewController:guide];
        self.window.rootViewController = guideNav;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    return YES;
}


#pragma make - 2016.9.27 时攀  本地更新...不要 - - -立即更新
//begin  2016-9.27 时攀 本地更新模块
-(void)creatUPNotification
{
    NSString * upURL =@"http://itunes.apple.com/lookup?id=1143765129";
    //检测更新
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:upURL  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*responseObject是个字典{}，有两个key
         KEYresultCount = 1//表示搜到一个符合你要求的APP
         results =（）//app信息,其中有 trackName （名称）trackViewUrl =（下载地址）version （可显示的版本号）等等
         */
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSDictionary *dic = [arr firstObject];
        NSString *versionStr = [dic objectForKey:@"version"];//版本号
        NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];//下载地址
        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
        
        //NSString* buile = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];build号
        NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@" CFBundleShortVersionString"]; //值CFBundleShortVersionString和APPstore下载下来的值一致,CFBundleVersion是build号
        
        
        
        //取得系统时间
        NSDate *now= [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        components = [calendar components:unitFlags fromDate:now];
        NSInteger hour = [components hour];
        NSInteger min = [components minute];
        NSInteger sec = [components second];
        NSInteger week = [components weekday];
        NSLog(@"现在是%ld：%ld：%ld,周%ld",hour,min,sec,week);
        
//        thisVersion = @"1.1";
        
        if ([self compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]){
            
            //直接弹框显示
            NSString *message = [NSString stringWithFormat:@"我是宝宝版本(%@)更新",versionStr];
            self.alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:message delegate:self cancelButtonTitle:@"退出应用" otherButtonTitles:@"升级", nil];
            [self.alertView show];
            self.alertView.tag = 1001;
            
            //            //创建版本更新本地通知提醒
            //            NSArray *notArr =[[UIApplication sharedApplication]scheduledLocalNotifications];
            //            for (int i=0; i<notArr.count; i++) {
            //
            //                UILocalNotification * locNot = notArr[i];
            //                if ([[locNot.userInfo objectForKey:@"message"] isEqualToString:@"APP更新"]) {
            //                    [[UIApplication sharedApplication] cancelLocalNotification:locNot];
            //                }
            //
            //            }
            //
            //            UILocalNotification * notification=[[UILocalNotification alloc] init];
            //
            //
            //            if (notification!=nil)
            //            {
            //
            //                notification.timeZone=[NSTimeZone defaultTimeZone];
            //
            //
            //                //
            //                //                notification.fireDate = [NSDate dateWithTimeIntervalSince1970:10];//执行的周期8*60*60
            //                //                notification.repeatInterval=kCFCalendarUnitMinute;//循环通知的周期
            //
            //
            //                notification.alertBody=[NSString stringWithFormat:@"我是宝宝最新版本%@上线了,快去看看吧~",versionStr];//弹出的提示信息
            //                notification.applicationIconBadgeNumber=0; //应用程序的右上角小数字
            //                notification.soundName= UILocalNotificationDefaultSoundName;//本地化通知的声音
            //                notification.alertAction = NSLocalizedString(@"打开应用查看更新", nil);  //滑块显示的文字
            //                notification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"APP更新",@"message",versionStr,@"version",nil];
            //                notification.alertTitle = @"我是宝宝版本更新~"; //设置通知中心的标题
            //                notification.hasAction = YES;//决定滑块文字是否显示
            //
            //                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //                [formatter setDateFormat:@"HH:mm:ss"];
            //
            //                if (hour>0&&hour<=12) {
            //                    NSDate *date = [formatter dateFromString:@"10:00:00"];
            //                    //通知发出的时间
            //                    notification.fireDate = date;
            //                }
            //                else
            //                {
            //                    NSDate *date = [formatter dateFromString:@"16:36:00"];
            //                    //通知发出的时间
            //                    notification.fireDate = date;
            //                }
            //
            //                if (week==5) {
            //                    notification.repeatInterval = kCFCalendarUnitDay;
            //                    NSLog(@"启动通知");
            //                    [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
            //                }
            //
            //            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
        
    }];
    
    
}
//比较版本的方法，Version来比较的
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    
    if (AppVersion==nil) {
        return littleSunResult;
    }
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"收到本地通知");
    [application setApplicationIconBadgeNumber:0];
    
    if (application.applicationState == UIApplicationStateActive) {
        return;
    }else if (application.applicationState == UIApplicationStateInactive)
    {
        //        if ([notification.userInfo[@"message"] isEqualToString:@"APP更新"])
        //        {
        //            NSString *message = [NSString stringWithFormat:@"我是宝宝版本(%@)更新",notification.userInfo[@"version"]];
        //            self.alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:message delegate:self cancelButtonTitle:@"退出应用" otherButtonTitles:@"升级", nil];
        //            [self.alertView show];
        //             self.alertView.tag = 1001;
        //
        //        }
        
    }else if(application.applicationState == UIApplicationStateBackground){
        NSLog(@"在后台");
    }
}
//end  2016-9.27 时攀 本地更新模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //begin 时攀 alert代理使用 2016.10.21
    NSURL * url = [NSURL URLWithString:@"https:itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8"];
    if (alertView.tag==1001) {
        
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:url];
        }
        else if(buttonIndex==0)
        {
            [self exitApplication];
        }
        
    }else if(alertView.tag==1002||alertView.tag==1003)
    {
//        NSDictionary *userInfo = objc_getAssociatedObject(alertView, @"userInfo");
        if ([_receiveUserInfo[@"type"] integerValue] == 2) {
            if (buttonIndex==1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_receiveUserInfo[@"key"]]]];
            }
        }
    }
    //end 时攀 alert代理使用 2016.10.21
}
- (void)exitApplication {
    
    UIWindow *window = self.window;
    //    UIView * currentView = window.rootViewController.view;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        //        CGRect rect;
        //        rect = window.frame;
        //        rect.size = CGSizeMake(rect.size.width*0.5, rect.size.height*0.5);
        //        window.center = CGPointMake( window.frame.size.width*0.5,  window.frame.size.height*0.5);
        //        window.frame = rect;
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result =  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // 打印到日志 textView 中
    _receiveUserInfo=userInfo;
    NSLog(@"********** iOS7.0之后 background **********");
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive)
    {
        // 根视图是nav 用push 方式跳转
        NSLog(@"applacation is unactive ===== %@",userInfo);
        /*
         // 根视图是普通的viewctr 用present跳转
         [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //alert关联传值 时攀 2016.10.21
        alertView.tag = 1002;
//        objc_setAssociatedObject(alertView, @"userInfo",userInfo,OBJC_ASSOCIATION_ASSIGN);
        [alertView show];
    }
    else
    {
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1003;
//        objc_setAssociatedObject(alertView, @"userInfo",userInfo,OBJC_ASSOCIATION_ASSIGN);
        [alertView show];
    }
    
    _baby.selectedViewController.navigationController.navigationBar.hidden = NO;
    
    if([userInfo[@"type"] integerValue] == 0 || [userInfo[@"type"] integerValue] == 1)
    {
        
        if([userInfo[@"key"] integerValue] > 0)
        {
            //请求成功后将数据更新到本地
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
            
            UsersModel *users = [[qiao selectAllFromTable] lastObject];
            
            PostDetails *post = [[PostDetails alloc] init];
            post.webUrl = [NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",[userInfo[@"key"] integerValue],[users.customerId integerValue]];
            post.navTitle = @"帖子";
            [_baby setSelectedIndex:0];
            [_baby.selectedViewController pushViewController:post animated:YES];
        }
        else
        {
            MessageViewController *message = [[MessageViewController alloc]init];
            [_baby setSelectedIndex:0];
            [_baby.selectedViewController pushViewController:message animated:YES];
        }
    }
    else if ([userInfo[@"type"] integerValue] == 2)//更新
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userInfo[@"key"]]]];
    }
    else if([userInfo[@"type"] integerValue] == 3)
    {
        _baby.tabBarController.selectedIndex = 1;
    }
    else if ([userInfo[@"type"] integerValue] == 4)
    {
        _baby.tabBarController.selectedIndex = 0;
    }
    else if ([userInfo[@"type"] integerValue] == 5)
    {
        XBJReportViewController *vc = [[XBJReportViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [_baby setSelectedIndex:1];
        [_baby.selectedViewController pushViewController:vc animated:YES];
    }
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"MessageModel" modelClass:[MessageModel class]];
    
    MessageModel *model = [[MessageModel alloc] init];
    model.count = userInfo[@"aps"][@"alert"];
    model.time = [NSString stringDateFromDate:[NSDate date] withFormat:SHORT_DATE_TIME_FORMAT_1];
    [qiao insertDataWithModel:model];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        
        // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
        }
    }];
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    _receiveUserInfo=userInfo;

    
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1002;
//        objc_setAssociatedObject(alertView, @"userInfo",userInfo,OBJC_ASSOCIATION_ASSIGN);
        [alertView show];
    }
    else
    {
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"我是宝宝团队" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1003;
//        objc_setAssociatedObject(alertView, @"userInfo",userInfo,OBJC_ASSOCIATION_ASSIGN);
        [alertView show];
    }
    
    _baby.selectedViewController.navigationController.navigationBar.hidden = NO;
    
    if([userInfo[@"type"] integerValue] == 0 || [userInfo[@"aps"][@"type"] integerValue] == 1)
    {
        if([userInfo[@"key"] integerValue] > 0)
        {
            //请求成功后将数据更新到本地
            QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
            
            UsersModel *users = [[qiao selectAllFromTable] lastObject];
            
            PostDetails *post = [[PostDetails alloc] init];
            post.webUrl = [NSString stringWithFormat:@"hhttp://120.76.194.105:8087/web/index.php?r=artical/detail&article_id=%ld&customer_id=%ld",[userInfo[@"key"] integerValue],[users.customerId integerValue]];
            post.navTitle = @"帖子";
            [_baby setSelectedIndex:0];
            [_baby.selectedViewController pushViewController:post animated:YES];
        }
        else
        {
            MessageViewController *message = [[MessageViewController alloc]init];
            [_baby setSelectedIndex:0];
            [_baby.selectedViewController pushViewController:message animated:YES];
        }
    }
    else if ([userInfo[@"type"] integerValue] == 2)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",userInfo[@"key"]]]];
    }
    else if([userInfo[@"type"] integerValue] == 3)
    {
        _baby.tabBarController.selectedIndex = 1;
    }
    else if ([userInfo[@"type"] integerValue] == 4)
    {
        _baby.tabBarController.selectedIndex = 0;
    }
    else if ([userInfo[@"type"] integerValue] == 5)
    {
        XBJReportViewController *vc = [[XBJReportViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [_baby setSelectedIndex:1];
        [_baby.selectedViewController pushViewController:vc animated:YES];
    }
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"MessageModel" modelClass:[MessageModel class]];
    
    MessageModel *model = [[MessageModel alloc] init];
    model.count = userInfo[@"aps"][@"alert"];
    model.time = [NSString stringDateFromDate:[NSDate date] withFormat:SHORT_DATE_TIME_FORMAT_1];
    [qiao insertDataWithModel:model];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-.BabyHealth" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BabyHealth" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BabyHealth.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
