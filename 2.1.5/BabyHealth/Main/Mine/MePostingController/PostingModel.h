//
//  PostingModel.h
//  BabyHealth
//
//  Created by 林全天 on 16/7/11.
//  Copyright © 2016年 LinQuanTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostingModel : NSObject

///帖子ID
@property(nonatomic,assign)NSInteger articleId;

///帖子名称
@property(nonatomic,strong)NSString *articleName;

///帖子状态
@property(nonatomic,strong)NSString *articleState;

///浏览次数
@property(nonatomic,assign)NSInteger browseNum;

///评论次数
@property(nonatomic,assign)NSInteger commentNum;

///帖子内容
@property(nonatomic,strong)NSString *content;

///帖子创建时间
@property(nonatomic,strong)NSString *createTime;

///评论的人
@property(nonatomic,strong)NSString *nickName;

///评论的人头像
@property(nonatomic,strong)NSString *avatarImg;

///评论的人ID
@property(nonatomic,assign)NSInteger customerId;

///关联的用户对象
@property(nonatomic,strong)NSString *customer;

@property(nonatomic,assign)NSInteger commentId;
@property(nonatomic,assign)NSInteger praiseId;
@property(nonatomic,assign)BOOL readAble;


@end
