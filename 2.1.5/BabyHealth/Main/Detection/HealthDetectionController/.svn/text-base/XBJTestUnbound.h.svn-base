//
//  XBJTestUnbound.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/5.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef void (^bindTesting)();
typedef void (^callPhone)();

@interface XBJTestUnbound : UIView

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;

@property (copy, nonatomic) bindTesting block;
@property (copy, nonatomic) callPhone callBlock;

@end
