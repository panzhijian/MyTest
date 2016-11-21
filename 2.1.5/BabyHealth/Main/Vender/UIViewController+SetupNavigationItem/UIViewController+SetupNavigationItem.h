//
//  UIViewController+SetupNavigationItem.h
//  WisdomCommunity
//
//  Created by jianhao on 16/2/18.
//  Copyright © 2016年 jianhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SetupNavigationItem)

- (void)setupBackBarButtonWithTitle:(NSString *)title;

- (void)setupBackItemForWebView;

- (UIButton *)addLeftBarButtonWithTitle:(NSString *)title
                                  color:(UIColor *)color
                                 normal:(NSString *)normalImage
                              highLight:(NSString *)highlightImage
                                 action:(SEL)action
                                 target:(id)target;

- (UIButton *)addRightBarButtonWithTitle:(NSString *)title
                                   color:(UIColor *)color
                                  normal:(NSString *)normalImage
                               highLight:(NSString *)highlightImage
                                  action:(SEL)action
                                  target:(id)target;

//- (UIButton *)addRightBarButtonWithTitle:(NSString *)title
//                                  action:(SEL)action
//                                  target:(id)target;
//
//- (UIButton *)addRightBarButtonWithNormal:(NSString *)normalImage
//                                highLight:(NSString *)highlightImage
//                                   action:(SEL)action
//                                   target:(id)target;

@end
