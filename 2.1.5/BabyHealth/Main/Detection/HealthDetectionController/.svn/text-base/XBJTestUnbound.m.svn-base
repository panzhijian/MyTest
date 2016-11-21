//
//  XBJTestUnbound.m
//  BabyHealth
//
//  Created by jxmac2 on 16/7/5.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJTestUnbound.h"

@implementation XBJTestUnbound


- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSMutableArray *images = [NSMutableArray new];
        NSArray *names = @[@"TGPbg2.png",@"TGPbg3.png",@"TGPbg4.png",@"TGPbg5.png"];
    
    for(NSString *name in names){
        UIImage *image = [UIImage imageNamed:name];
        [images addObject:image];
    }
    self.cycleScrollView.localizationImagesGroup = images;
    self.cycleScrollView.showPageControl = NO;
    [self configureLabel];
    [self configureContactLabel];
    [self configureBindBtn];
}

- (void)configureLabel{
    NSString * string = @"本功能需要配合健康检测产品一起使用已有检测产品？";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
    NSRange range = NSMakeRange(string.length-7, 7);
    [attributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:color
                             range:range];
    self.label.attributedText = attributedString;
}

- (void)configureContactLabel{
    NSString * string = @"如有疑问可拨打0755-36307818或者加Ｑ338622234在线咨询";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    UIColor *color = [UIColor colorWithRed:254/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
    NSRange range1 = NSMakeRange(7, 13);
    NSRange range2 = NSMakeRange(23, 10);
    [attributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:color
                             range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                             value:color
                             range:range2];
    self.contactLabel.attributedText = attributedString;
}

- (void)configureBindBtn{
    self.bindBtn.layer.cornerRadius = self.bindBtn.bounds.size.height/2;
}
- (IBAction)bindAction:(id)sender {
    
    if(self.block){
        self.block();
    }
    
}
- (IBAction)callAction:(id)sender {
    
    if(self.callBlock){
        self.callBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
