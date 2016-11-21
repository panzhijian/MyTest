//
//  XBJBindModel.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBJBindModel : NSObject

@property (nonatomic, copy) NSString *code; /**< 编号 */
@property (nonatomic, copy) NSString *time; /**< 时间 */
@property (nonatomic, copy) NSString *contactName; /**< 联系人 */
@property (nonatomic, copy) NSString *mobile;      /**< 手机号码 */
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *color;        /**< 颜色 */
@property (nonatomic, copy) NSString *trait;        /**< 性状 */
@property (nonatomic, copy) NSString *date;       /**< 当前系统时间/关联成长记录时间 */

@end
