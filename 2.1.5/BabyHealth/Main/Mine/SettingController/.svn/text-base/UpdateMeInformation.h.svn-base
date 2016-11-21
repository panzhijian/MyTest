//
//  UpdateMeInformation.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/7.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateMeInformationDelegate <NSObject>

-(void)returnUpdateMeinformationValue:(NSString *)updateValue updateIndex:(NSInteger )updateIndex;

@end

@interface UpdateMeInformation : XBJBaseViewController

@property(nonatomic,weak)id<UpdateMeInformationDelegate>delegate;

@property(nonatomic,strong)NSString *updateTitle;

@property(nonatomic,strong)NSString *updateValue;

@property(nonatomic,assign)NSInteger updateIndex;

@property(nonatomic,strong)UITextField *updateText;

@end
