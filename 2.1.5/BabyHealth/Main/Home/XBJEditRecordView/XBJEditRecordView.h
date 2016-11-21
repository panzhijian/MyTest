//
//  XBJEditRecordView.h
//  BabyHealth
//
//  Created by jxmac2 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "MMPopupView.h"

typedef void (^editBlock)();
typedef void (^deleteBlock)();

@interface XBJEditRecordView : MMPopupView
@property (weak, nonatomic) IBOutlet UIButton *cancerBtn;

@property (copy, nonatomic) editBlock edit_block;
@property (copy, nonatomic) deleteBlock delete_block;

@end
