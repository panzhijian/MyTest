//
//  XBJUploadRequest.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJUploadRequest.h"

@implementation XBJUploadRequest

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

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        for(int i=0;i<_images.count;i++){
            UIImage *image = _images[i];
            NSData *data = UIImageJPEGRepresentation(image, 0.3);
            NSString *name = @"files";
            NSString *formKey = @"files";
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        }
    };
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}


@end
