//
//  IMBSampleInformation.m
//  BabyHealth
//
//  Created by USER on 16/10/14.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "IMBSampleInformation.h"

@implementation IMBSampleInformation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)agreeBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        self.agreeImage.image = [UIImage imageNamed:@"login_tick"];
    }else{
        self.agreeImage.image = [UIImage imageNamed:@"login_untick"];
    }
}

@end
