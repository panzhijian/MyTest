//
//  MeWebView.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MeWebView.h"

@implementation MeWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    
    if(self.webUrl)
    {
        [self performSelector:@selector(createContractViewControllerPDFUI:) withObject:self.webUrl];
    }
}

- (void)createContractViewControllerPDFUI:(NSString *)url
{
   
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(128), AUTO_MATE_WIDTH(750.0), AUTO_MATE_HEIGHT(1214))];
    web.scalesPageToFit = YES;
    [self.view addSubview:web];
    
    NSData *data = [NSData dataWithContentsOfFile:url];
    
    [web loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
}

@end
