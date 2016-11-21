//
//  CommunityViewController.m
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "CommunityViewController.h"
#import "QIAODBMangerEx.h"
#import "UsersModel.h"
#import "UMSocial.h"

@interface CommunityViewController ()
{
    UsersModel *users;
}
@end

@implementation CommunityViewController

- (NSString *)_evaluateJavascript:(NSString *)javascriptCommand
{
    return @"message";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

//    self.webHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    statusView.backgroundColor = RGBF(0.9961, 0.4980, 0.5922);
    [self.view addSubview:statusView];
    
    // 主页面
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    self.webView.delegate = self;
    self.webView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.webView];
    
    // 发帖页
    self.upWebView = [[UIWebView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    self.upWebView.delegate = self;
    self.webView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.upWebView];
    
}

- (void)setUmengWithUrl:(NSString *)url shareText:(NSString *)shareText
{
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    NSString * url1=url;
    
    [UMSocialData defaultData].extConfig.title = @"我是宝宝";
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url1;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url1;
    
    [UMSocialData defaultData].extConfig.qqData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.qqData.url = url1;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_KEY
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                       delegate:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.webHud show:YES];
    [[NSURLCache sharedURLCache ] removeAllCachedResponses];
    
    //读取数据库
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    users = [[qiao selectAllFromTable] lastObject];
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=index/index&customer_id=%ld",[users.customerId integerValue]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [self.webView loadRequest:request];
    
    //    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    //定义好JS要调用的方法, share就是调用的share方法名
    //    context[@"share"] = ^() {
    //        NSArray *args = [JSContext currentArguments];
    //        for (JSValue *jsVal in args) {
    //            NSLog(@"%@", jsVal.toString);
    //        }
    //        [self setUmengWithUrl:@"123213" shareText:@"123123213"];
    //    };
    
    [self bindingWebView];
    [self bindingUpWebView];
}

// 绑定主页面
- (void)bindingWebView {

    if (self.bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate:self];
    // 分享--------
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [self setUmengWithUrl:data[@"umengUrl"] shareText:data[@"context"]];
    }];
    // 发帖--------
    [self.bridge registerHandler:@"toAddArticle" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self addArtical];
    }];
    [self.bridge registerHandler:@"openUrl" handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
    [self.bridge registerHandler:@"alertPhoto" handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}

// 绑定发帖页
- (void)bindingUpWebView {
    
    if (self.upBridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    self.upBridge = [WebViewJavascriptBridge bridgeForWebView:_upWebView];
    [self.upBridge setWebViewDelegate:self];
    // 返回主页面
    [self.upBridge registerHandler:@"toMainView" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self cancleArtical];
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@,%@",webView,error);
}


// 点击发帖按钮 弹出发帖页
- (void)addArtical {
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.76.194.105:8087/web/index.php?r=artical/add&customer_id=%ld",[users.customerId integerValue]]];
    [self.upWebView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    
    
    // 主页面左移100像素，发帖页左移屏幕宽度
    [UIView animateWithDuration:0.4 animations:^{
        
        CGRect frame = self.webView.frame;
        CGRect frame2 = self.upWebView.frame;
        frame.origin.x = -100;
        frame2.origin.x= 0;
        self.webView.frame = frame;
        self.upWebView.frame = frame2;
    }];
}

// 隐藏发帖页，显示主页面
- (void)cancleArtical {

    // 恢复主页面与发帖页origin
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.webView.frame;
        CGRect frame2 = self.upWebView.frame;
        frame.origin.x = 0;
        frame2.origin.x = SCREEN_WIDTH;
        self.webView.frame = frame;
        self.upWebView.frame = frame2;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
