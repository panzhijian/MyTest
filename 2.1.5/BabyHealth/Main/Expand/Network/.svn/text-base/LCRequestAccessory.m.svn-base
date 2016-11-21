//
//  LCRequestAccessory.m
//  ShellMoney
//
//  Created by beike on 6/9/15.
//  Copyright (c) 2015 beik. All rights reserved.
//

#import "LCRequestAccessory.h"
#import "MBProgressHUD.h"

@interface LCRequestAccessory ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation LCRequestAccessory

+ (LCRequestAccessory *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init{
    self = [super init];
    if (self) {
     
    }
    return self;
}



- (void)requestWillStart:(id)request {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    _hud.bezelView.backgroundColor=Juhua_BackGround_COLOR;

    [window addSubview:_hud];
    _hud.label.text = @"正在加载";
    [_hud.label setTextColor:[UIColor whiteColor]];

    [_hud showAnimated:YES];
}

- (void)requestWillStop:(id)request {
    
    [_hud hideAnimated:YES ];
    [_hud hideAnimated:YES afterDelay:0.2 ];


}

- (void)requestDidStop:(id)request{
//    [self.hud hide:NO];
}

@end
