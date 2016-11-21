//
//  CommunityViewController.h
//  BabyHealth
//
//  Created by 林全天 on 16/6/27.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "MBProgressHUD.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@interface CommunityViewController : UIViewController<UIWebViewDelegate,WebViewJavascriptBridgeBaseDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIWebView *upWebView;

@property(nonatomic,strong)JSContext *context;

@property(nonatomic,strong)MBProgressHUD *webHud;

@property(nonatomic,strong)WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)WebViewJavascriptBridge *upBridge;

@end
