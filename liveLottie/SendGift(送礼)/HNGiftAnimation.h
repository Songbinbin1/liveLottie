//
//  HNGiftAnimation.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//  送礼的动画任务块

#import <Foundation/Foundation.h>
#import "HNSendGiftView.h"

@interface HNGiftAnimation : NSOperation

@property (nonatomic, strong) HNSendGiftView *giftView;
@property (nonatomic, strong) UIView *superView;

@property (nonatomic, strong) NSString *userId; // 用户的唯一标识符


// 最后一个回调： 结束时礼物的累计数
+ (instancetype)animaOperationWithUserId:(NSString *)uid
                                   count:(NSInteger)count
                                oldCount:(NSInteger)oldCount
                               superView:(UIView *)superView
                                 chatMsg:(HNLiveChatMsgModel *)msgModel
                           finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;

@end
