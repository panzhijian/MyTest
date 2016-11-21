//
//  UIViewController+SetupNavigationItem.m
//  WisdomCommunity
//
//  Created by jianhao on 16/2/18.
//  Copyright © 2016年 jianhao. All rights reserved.
//

#import "UIViewController+SetupNavigationItem.h"

@implementation UIViewController (SetupNavigationItem)

- (void)setupBackBarButtonWithTitle:(NSString *)title
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    UIImage * image = [UIImage imageNamed:@"nav_icon_back"];
    [backItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    if (title) {
        backItem.title = title;
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 9.0) {
            NSInteger horizontal = 0;
            if (title.length == 1) {
                horizontal = -5;
            }
            [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(horizontal, 0) forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)setupBackItemForWebView {
    UIButton *leftButton = [self barButtonWithTitle:nil color:nil normal:@"nav_icon_back" highLight:nil action:@selector(backAction:) target:self];
    CGRect frame = leftButton.frame;
    frame.size.width = 34;
    leftButton.frame = frame;
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = - 16;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
}

- (UIButton *)addLeftBarButtonWithTitle:(NSString *)title
                                  color:(UIColor *)color
                                 normal:(NSString *)normalImage
                              highLight:(NSString *)highlightImage
                                 action:(SEL)action
                                 target:(id)target {
    UIButton *leftButton = [self barButtonWithTitle:title color:color normal:normalImage highLight:highlightImage action:action target:target];
//    leftButton.backgroundColor = [UIColor redColor];
    if(!title){
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    }
    else if(title&&normalImage){
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [array addObject:leftItem];
    self.navigationItem.leftBarButtonItems = array;
    return leftButton;
}

//- (UIButton *)addRightBarButtonWithTitle:(NSString *)title
//                                  action:(SEL)action
//                                  target:(id)target {
//    return [self addRightBarButtonWithTitle:title normal:nil highLight:nil action:action target:target];
//}
//
//- (UIButton *)addRightBarButtonWithNormal:(NSString *)normalImage
//                                highLight:(NSString *)highlightImage
//                                   action:(SEL)action
//                                   target:(id)target {
//    return [self addRightBarButtonWithTitle:nil normal:normalImage highLight:highlightImage action:action target:target];
//}

- (UIButton *)addRightBarButtonWithTitle:(NSString *)title
                                   color:(UIColor *)color
                                  normal:(NSString *)normalImage
                               highLight:(NSString *)highlightImage
                                  action:(SEL)action
                                  target:(id)target {
    UIButton *rightButton = [self rightBarButtonWithTitle:title color:color normal:normalImage highLight:highlightImage action:action target:target];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
//    rightButton.backgroundColor = [UIColor redColor];
    if (!self.navigationItem.rightBarButtonItems) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [array addObject:rightBtnItem];
    self.navigationItem.rightBarButtonItems = array;
    
    return rightButton;
}

- (UIButton *)barButtonWithTitle:(NSString *)title
                           color:(UIColor *)color
                          normal:(NSString *)normalImage
                       highLight:(NSString *)highlightImage
                          action:(SEL)action
                          target:(id)target {
    UIButton *button = [[UIButton alloc] init];
    CGFloat buttonWidth = 0;
    CGFloat buttonHeight = 40;
    if (title) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(0.0, 1.0);
        shadow.shadowColor = [UIColor whiteColor];
        UIColor *textColor = color?color:[UIColor blackColor];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor, NSShadowAttributeName:shadow, NSFontAttributeName:[UIFont systemFontOfSize:15.0]}];
        [button setAttributedTitle:attrString forState:UIControlStateNormal];
        CGSize textSize = [attrString boundingRectWithSize:CGSizeMake(100, 100) options:0 context:nil].size;
        buttonWidth += textSize.width+5;
    }
    if (normalImage) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        UIImage *image = [UIImage imageNamed:normalImage];
        [button setImage:image forState:UIControlStateNormal];
        buttonWidth += 40;
    }
    if (highlightImage) {
        [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }
    if(action){
        [button addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    }
    button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    return button;
}

- (UIButton *)rightBarButtonWithTitle:(NSString *)title
                           color:(UIColor *)color
                          normal:(NSString *)normalImage
                       highLight:(NSString *)highlightImage
                          action:(SEL)action
                          target:(id)target {
    UIButton *button = [[UIButton alloc] init];
    CGFloat buttonWidth = 0;
    CGFloat buttonHeight = 0;
    if (title) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(0.0, 1.0);
        shadow.shadowColor = [UIColor whiteColor];
        UIColor *textColor = color?color:[UIColor blackColor];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:textColor, NSFontAttributeName:[UIFont systemFontOfSize:15.0]}];
        [button setAttributedTitle:attrString forState:UIControlStateNormal];
        CGSize textSize = [attrString boundingRectWithSize:CGSizeMake(100, 100) options:0 context:nil].size;
        buttonWidth += textSize.width+5;
        buttonHeight += textSize.height;
    }
    if (normalImage) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        UIImage *image = [UIImage imageNamed:normalImage];
        [button setImage:image forState:UIControlStateNormal];
        buttonWidth += image.size.width;
        if (image.size.height > buttonHeight) {
            buttonHeight = image.size.height;
        }
    }
    if (highlightImage) {
        [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }
    if(action){
        [button addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    }
    if(buttonWidth< 30) buttonWidth = 30;
    if(buttonHeight<30) buttonHeight = 30;
    button.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    return button;
}


- (BOOL)navigationShouldPopOnBackButton {
    [self backAction:self.navigationItem.backBarButtonItem];
    return NO;
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
