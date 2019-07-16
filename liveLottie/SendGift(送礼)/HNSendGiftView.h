//
//  HNSendGiftView.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//  送礼物视图

#import <UIKit/UIKit.h>
#import "HNLiveChatMsgModel.h"

// 用来记录动画结束时累加数量，将来在3秒内，还能继续累加
typedef void(^CompleteBlock)(BOOL finished, NSInteger finishCount);

@interface HNSendGiftView : UIView

@property (nonatomic, strong) HNLiveChatMsgModel *msgModel;

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, assign) NSInteger animaCount;  // 动画执行到了第几次
@property (nonatomic, assign) NSInteger oldAnimaCount;  // 上次动画执行到了第几次

@property (nonatomic, assign) CGRect originFrame;  // 记录原始坐标

@property (nonatomic, strong) NSString *identifier;


+ (HNSendGiftView *)sendGiftViewWithSuperView:(UIView *)superView
                                        Count:(NSInteger)count
                                     OldCount:(NSInteger)oldCount
                                   Identifier:(NSString *)identifier;

// index: 第几个视图
- (void)animateWithCompleteBlock:(CompleteBlock)completed
                       ViewIndex:(NSInteger)index;

@end
