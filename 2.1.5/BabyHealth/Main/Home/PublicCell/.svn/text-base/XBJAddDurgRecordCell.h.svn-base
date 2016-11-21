//
//  XBJAddDurgRecordCell.h
//  BabyHealth
//
//  Created by 陈亚 on 16/7/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBJAddDurgRecordCell : UITableViewCell<UITextFieldDelegate>

typedef void (^drugNameBlock)();
typedef void (^drugCountBlock)();

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@property (nonatomic, strong) NSMutableDictionary *drugDic;
@property (copy, nonatomic) drugNameBlock nameBlock;
@property (copy, nonatomic) drugCountBlock countBlock;

@end
