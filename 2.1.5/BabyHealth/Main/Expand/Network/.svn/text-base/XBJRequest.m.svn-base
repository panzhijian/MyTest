//
//  XBJRequest.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJRequest.h"

@implementation XBJRequest

- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if(self){
        self.url = url;
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 20.0;
}

- (BOOL)cacheResponse{
    return NO;
}

// 接口地址
- (NSString *)apiMethodName{
    
    return self.url;
}

// 请求方式
- (LCRequestMethod)requestMethod{
    return LCRequestMethodPost;
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end
