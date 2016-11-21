//
//  XBJRecordView.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBJEditRecordView.h"
#import "XBJNetWork.h"

typedef void (^showToast)(NSString *);
typedef void (^editPush)(id );

@interface XBJRecordView : UIView

@property (nonatomic, strong) XBJEditRecordView *editView;

@property (copy, nonatomic) showToast toastBlock;
@property (copy, nonatomic) editPush editBlock;

@property (assign, nonatomic) float zoom;/**< 缩放倍数 */

- (void)requestData;

- (void)configureView;

@end
