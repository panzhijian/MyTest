//
//  ModifyMobliePhoneController.h
//  BabyHealth
//
//  Created by USER on 16/10/19.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^modifyMobilePhone)(NSString *mobliePhone);

@interface ModifyMobliePhoneController : XBJBaseViewController
@property (copy,nonatomic) modifyMobilePhone modifyMobilePhoneBlock;
@end
