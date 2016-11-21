//
//  XBJRecordView.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJRecordView.h"

@implementation XBJRecordView

- (XBJEditRecordView *)editView{
    if(!_editView){
        float width = SCREEN_WIDTH;
        float height = 178;
        _editView = [[[UINib nibWithNibName:@"XBJEditRecordView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        _editView.frame = CGRectMake(0, 0, width, height);
    }
    return _editView;
}

- (void)requestData{}

- (void)configureView{}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
