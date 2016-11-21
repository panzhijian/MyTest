//
//  GrowInformationCell.m
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "GrowInformationCell.h"

@implementation GrowInformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(createGrowInformationCell)];
    }
    return self;
}

- (void)createGrowInformationCell
{
    self.contentView.backgroundColor = BG_COLOR;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(750), AUTO_MATE_HEIGHT(100))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(20), AUTO_MATE_HEIGHT(32), AUTO_MATE_WIDTH(AUTO_MATE_WIDTH(200)), AUTO_MATE_HEIGHT(30))];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = ME_TXT_COLOR;
    [bgView addSubview:self.titleLabel];
    
    self.textFiled = [[UITextField alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(200), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(528), AUTO_MATE_HEIGHT(100))];
    self.textFiled.textColor = CELL_TXT_COLOR;
    self.textFiled.textAlignment = NSTextAlignmentRight;
    self.textFiled.delegate = self;
    [bgView addSubview:self.textFiled];
    
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(AUTO_MATE_WIDTH(0), AUTO_MATE_HEIGHT(0), AUTO_MATE_WIDTH(AUTO_MATE_WIDTH(64)), AUTO_MATE_HEIGHT(32))];
    self.textFiled.rightView = self.rightImage;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.indexRow == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@" 结束");
}

@end
