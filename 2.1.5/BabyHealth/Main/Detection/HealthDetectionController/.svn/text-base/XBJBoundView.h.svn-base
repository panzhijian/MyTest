//
//  XBJBoundView.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/6.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^testingBind)();
typedef void (^testingReport)();
typedef void (^testingCensus)();
typedef void (^testingCall)();

@interface XBJBoundView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint; /**< <#(注释)#> */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;       /**< 次数 */
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;          /**< 绑定送样 */
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;        /**< 检测报告 */
@property (weak, nonatomic) IBOutlet UIButton *censusBtn;        /**< 检测统计 */

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;   
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@property (copy, nonatomic) testingBind   bindBlock;
@property (copy, nonatomic) testingReport reportBlock;
@property (copy, nonatomic) testingCensus censusBlock;
@property (copy, nonatomic) testingCall callBlock;

@end
