//
//  PostDetails.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/25.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "PostDetails.h"

@implementation PostDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    
    if(self.webUrl)
    {
        [self performSelector:@selector(createPostDetailsUI:) withObject:self.webUrl];
    }
}

- (void)createPostDetailsUI:(NSString *)url
{
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    statusView.backgroundColor = RGBF(0.9961, 0.4980, 0.5922);
    [self.view addSubview:statusView];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    self.webView.delegate = self;
    self.webView.backgroundColor = BG_COLOR;
    [self.view addSubview:self.webView];
    
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    [self.webView loadRequest:request];
    
    if (self.bridge) { return; }
    
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}

@end
