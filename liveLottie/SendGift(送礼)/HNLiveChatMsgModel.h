//
//  HNLiveChatMsgModel.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/11.
//  Copyright © 2017年 HN. All rights reserved.
//
//typedef enum : NSUInteger {
//    OrdinaryMsgType, //普通消息
//    SystemMsgType ,   //系统消息
//    GiftMsgType,   //警告消息
//    TipsMsgType,   //警告消息
//    WarningMsgType   //警告消息
//} HNMsgType;
#import <Foundation/Foundation.h>

@interface HNLiveChatMsgModel : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *msg_content;

//@property (nonatomic, assign) HNMsgType msgType;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *g_name;
@property (nonatomic, strong) NSString *g_icon;
@property (nonatomic, strong) NSString *g_count;

@property (nonatomic, strong) NSMutableAttributedString *attributedScount;

@property (nonatomic, strong) NSString *g_id;
@property (nonatomic, strong) NSString *g_num; // 礼物个数

@property (nonatomic, strong) NSString *is_banned_say;  // 是否禁言
@property (nonatomic, strong) NSString *is_field_control; // 是否设置场控
//@property (nonatomic, assign) CGFloat cellHeight;
//@property (nonatomic, strong) UIImageView *iconImg;
-(void)calculationcellHeight;

@end
