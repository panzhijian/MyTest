//
//  XBJAppHelper.m
//  BabyHealth
//
//  Created by 陈亚 on 16/7/12.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import "XBJAppHelper.h"
#import "AppDelegate.h"
#import "UMSocial.h"


@implementation XBJAppHelper

+ (NSString *)sinoBritishConversion:(NSString *)chinese{
    if([chinese isEqualToString:@"水样"]){
        return @"WATERY";
    }else if([chinese isEqualToString:@"很稀"]){
        return @"DILUTE";
    }else if([chinese isEqualToString:@"粘稠"]){
        return @"VISCOUS";
    }else if([chinese isEqualToString:@"一般"]){
        return @"COMMONLY";
    }else if([chinese isEqualToString:@"较干"]){
        return @"RELATIVELY_DRY";
    }else if([chinese isEqualToString:@"干硬"]){
        return @"HARD_DRY";
//    }else if([chinese isEqualToString:@"水便"]){
//        return @"WATER_DUNG";
//    }else if([chinese isEqualToString:@"软便"]){
//        return @"SOFT_DRY";
    }
    
    else if([chinese isEqualToString:@"灰白色"]){
        return @"GRAY";
    }else if([chinese isEqualToString:@"绿色"]){
        return @"GREEN";
    }else if([chinese isEqualToString:@"黄色"]){
        return @"YELLOW";
    }else if([chinese isEqualToString:@"棕色"]){
        return @"BROWN";
    }else if([chinese isEqualToString:@"黑褐色"]){
        return @"BLACK";
    }else if([chinese isEqualToString:@"红色"]){
        return @"RED";
    }else if([chinese isEqualToString:@"正常"]){
        return @"NORMAL";
    }else if([chinese isEqualToString:@"异常"]){
        return @"ABNORMAL";
    }
    else if([chinese isEqualToString:@"异常"]){
        return @"ABNORMAL";
    }
    else if([chinese isEqualToString:@"视具体情况而定"]){
        return @"ACTUAL_SITUATION";
    }
    
    
    return nil;
}

+ (NSString *)britishSinoConversion:(NSString *)english{
    if([english isEqualToString:@"WATERY"]){
        return @"水样";
    }else if([english isEqualToString:@"DILUTE"]){
        return @"很稀";
    }else if([english isEqualToString:@"VISCOUS"]){
        return @"粘稠";
    }else if([english isEqualToString:@"COMMONLY"]){
        return @"一般";
    }else if([english isEqualToString:@"RELATIVELY_DRY"]){
        return @"较干";
    }else if([english isEqualToString:@"HARD_DRY"]){
        return @"干硬";
//    }else if([english isEqualToString:@"WATER_DUNG"]){
//        return @"水便";
//    }else if([english isEqualToString:@"SOFT_DRY"]){
//        return @"软便";
    }
    
    
    else if([english isEqualToString:@"GRAY"]){
        return @"灰白色";
    }else if([english isEqualToString:@"GREEN"]){
        return @"绿色";
    }else if([english isEqualToString:@"YELLOW"]){
        return @"黄色";
    }else if([english isEqualToString:@"BROWN"]){
        return @"棕色";
    }else if([english isEqualToString:@"BLACK"]){
        return @"黑褐色";
    }else if([english isEqualToString:@"RED"]){
        return @"红色";
    }
    
    else if([english isEqualToString:@"NORMAL"]){
        return @"正常";
    }else if([english isEqualToString:@"ABNORMAL"]){
        return @"异常";
    }
    else if([english isEqualToString:@"ACTUAL_SITUATION"]){
        return @"视具体情况而定";
    }
    
    else if([english isEqualToString:@"NEGATIVE"]){
        return @"阴性";
    }else if([english isEqualToString:@"POSITIVE"]){
        return @"阳性";
    }
    
    else if([english isEqualToString:@"UNKNOWN"]){
        return @"未查见";// 寄生虫
    }else if([english isEqualToString:@"KNOWN"]){
        return @"查见";
    }
    
    return nil;
}

+ (UIColor *)britishColorConversion:(NSString *)english{
    if(!english) return [UIColor lightGrayColor];
    
    if([english isEqualToString:@"GRAY"]){
        return [UIColor lightGrayColor];
    }else if([english isEqualToString:@"GREEN"]){
        return [UIColor colorWithRed:91/255.0 green:149/255.0 blue:3/255.0 alpha:1.0];
    }else if([english isEqualToString:@"YELLOW"]){
        return [UIColor colorWithRed:245/255.0 green:183/255.0 blue:17/255.0 alpha:1.0];
    }else if([english isEqualToString:@"BROWN"]){
        return [UIColor colorWithRed:204/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    }else if([english isEqualToString:@"BLACK"]){
        return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    }else if([english isEqualToString:@"RED"]){
        return [UIColor colorWithRed:254/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }else if([english isEqualToString:@"OTHER"]){//重叠的颜色
        return [UIColor colorWithRed:255/255.0 green:115/255.0 blue:141/255.0 alpha:1.0];
    }
    return [UIColor lightGrayColor];
}

// 性状->颜色
+ (UIColor *)traitColorConversion:(NSString *)trait{
    if(!trait) return [UIColor lightGrayColor];
    
    if([trait isEqualToString:@"WATERY"]){
        return [UIColor colorWithRed:91/255.0 green:149/255.0 blue:3/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"DILUTE"]){
        return [UIColor colorWithRed:252/255.0 green:216/255.0 blue:17/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"WATER_DUNG"]){
        return [UIColor colorWithRed:180/255.0 green:255/255.0 blue:17/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"VISCOUS"]){
        return [UIColor colorWithRed:245/255.0 green:183/255.0 blue:17/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"SOFT_DRY"]){
        return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    }else if([trait isEqualToString:@"COMMONLY"]){
        return [UIColor colorWithRed:204/255.0 green:102/255.0 blue:0/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"RELATIVELY_DRY"]){
        return [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }else if([trait isEqualToString:@"HARD_DRY"]){
        return [UIColor colorWithRed:65/255.0 green:6/255.0 blue:6/255.0 alpha:1.0];
    }

    return [UIColor lightGrayColor];
}

// 英->NSNumber
+ (NSNumber *)britishNumberConversion:(NSString *)english{
    if(!english) return @8888;

    if([english isEqualToString:@"GRAY"]){
        return @40;
    }else if([english isEqualToString:@"GREEN"]){
        return @120;
    }else if([english isEqualToString:@"YELLOW"]){
        return @160;
    }else if([english isEqualToString:@"BROWN"]){
        return @200;
    }else if([english isEqualToString:@"BLACK"]){
        return @240;
    }else if([english isEqualToString:@"RED"]){
        return @80;
        
    }// 性状部分
//    else if([english isEqualToString:@"WATERY"]){
//        return @320;
//    }else if([english isEqualToString:@"DILUTE"]){
//        return @280;
//    }else if([english isEqualToString:@"WATER_DUNG"]){
//        return @240;
//    }else if([english isEqualToString:@"VISCOUS"]){
//        return @200;
//    }else if([english isEqualToString:@"SOFT_DRY"]){
//        return @160;
//    }else if([english isEqualToString:@"COMMONLY"]){
//        return @120;
//    }else if([english isEqualToString:@"RELATIVELY_DRY"]){
//        return @80;
//    }else if([english isEqualToString:@"HARD_DRY"]){
//        return @40;
//    }
    else if([english isEqualToString:@"WATERY"]){
        return @240;
    }else if([english isEqualToString:@"DILUTE"]){
        return @200;
    }else if([english isEqualToString:@"VISCOUS"]){
        return @160;
    }else if([english isEqualToString:@"COMMONLY"]){
        return @120;
    }else if([english isEqualToString:@"RELATIVELY_DRY"]){
        return @80;
    }else if([english isEqualToString:@"HARD_DRY"]){
        return @40;
    }

    else if([english isEqualToString:@"NORMAL"]){
        return @40;
    }else if([english isEqualToString:@"ABNORMAL"]){
        return @80;
    }
    
    else if([english isEqualToString:@"UNKNOWN"]){
        return @40;// 寄生虫
    }else if([english isEqualToString:@"KNOWN"]){
        return @80;
    }

    
    
    return @8888;
    
}

+ (NSNumber *)chineseColorToNumber:(NSString *)chinese{
    if(!chinese) return @8888;
    
    if([chinese isEqualToString:@"灰白色"]){
        return @320;
    }else if([chinese isEqualToString:@"黄色"]){
        return @280;
    }else if([chinese isEqualToString:@"棕黄色"]){
        return @240;
    }else if([chinese isEqualToString:@"黄绿色"]){
        return @200;
    }else if([chinese isEqualToString:@"褐色"]){
        return @160;
    }else if([chinese isEqualToString:@"红色"]){
        return @120;
    }else if([chinese isEqualToString:@"柏油样"]){
        return @80;
    }else if([chinese isEqualToString:@"酱色"]){
        return @40;
    }
    return @8888;
}

+ (UIColor *)chineseColorToColor:(NSString *)chinese{
    if(!chinese) return [UIColor whiteColor];
    
    if([chinese isEqualToString:@"灰白色"]){
        return RGB(242,242,242);
    }else if([chinese isEqualToString:@"黄色"]){
        return RGB(255,241,0);
    }else if([chinese isEqualToString:@"棕黄色"]){
        return RGB(222,102,28);
    }else if([chinese isEqualToString:@"黄绿色"]){
        return RGB(171,205,3);
    }else if([chinese isEqualToString:@"褐色"]){
        return RGB(113,59,18);
    }else if([chinese isEqualToString:@"红色"]){
        return RGB(230,0,18);
    }else if([chinese isEqualToString:@"柏油样"]){
        return RGB(39,50,56);
    }else if([chinese isEqualToString:@"酱色"]){
        return RGB(156,30,23);
    }
    return [UIColor whiteColor];
}

+ (NSNumber *)chineseTraitToValue:(NSString *)chinese{
    if(!chinese) return @8888;
//    else if([chinese isEqualToString:@"水样"]){
//        return @320;
//    }else if([chinese isEqualToString:@"很稀"]){
//        return @280;
//    }else if([chinese isEqualToString:@"水便"]){
//        return @240;
//    }else if([chinese isEqualToString:@"粘稠"]){
//        return @200;
//    }else if([chinese isEqualToString:@"软便"]){
//        return @160;
//    }else if([chinese isEqualToString:@"一般"]){
//        return @120;
//    }else if([chinese isEqualToString:@"较干"]){
//        return @80;
//    }else if([chinese isEqualToString:@"干硬"]){
//        return @40;
//    }

    else if([chinese isEqualToString:@"水样"]){
        return @240;
    }else if([chinese isEqualToString:@"很稀"]){
        return @200;
    }else if([chinese isEqualToString:@"粘稠"]){
        return @160;
    }else if([chinese isEqualToString:@"一般"]){
        return @120;
    }else if([chinese isEqualToString:@"较干"]){
        return @80;
    }else if([chinese isEqualToString:@"干硬"]){
        return @40;
    }
    return @8888;
}

+ (float)topConstraintsWith:(float)H Ycount:(NSInteger)count{

    return 10+((H-25)/count)/2;
}

+ (float)rowHeightWith:(float)H Ycount:(NSInteger)count{

    return (H-25)/count;
}

+ (float)tableHeightWith:(float)H Ycount:(NSInteger)count{
    
    return ((H-25)/count)*(H-1);
}

+ (float)stateLabelTopWith:(float)H Ycount:(NSInteger)count topCount:(NSInteger)topCount{
    
    return ((H-25)/count)*(topCount)-11+10;
}


+ (UIImage *)screenImageWithSize:(CGSize )imgSize
{
//    UIGraphicsBeginImageContext(imgSize);
    //解决截屏模糊问题 时攀
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
}

+ (void)shareIn:(UIViewController *)vc shareText:(NSString *)text{
    NSString * url =@"https://itunes.apple.com/cn/app/wo-shi-bao-bao/id1143765129?mt=8";
    
    [UMSocialData defaultData].extConfig.title = @"我是宝宝";
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    
    [UMSocialData defaultData].extConfig.qqData.title = @"我是宝宝";
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UMENG_KEY
                                      shareText:text
                                     shareImage:[self screenImageWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ]
                                       delegate:nil];
    
}

+ (UsersModel *)SQLUser
{
    QIAODBMangerEx *qiao = [[QIAODBMangerEx alloc] initWithDataBase:@"BabyHealth" tableName:@"Users" modelClass:[UsersModel class]];
    UsersModel *users = [[qiao selectAllFromTable] lastObject];
    return users;
}

@end
