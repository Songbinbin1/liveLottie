//
//  HNAnimationManager.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNGiftAnimation.h"

@interface HNAnimationManager : NSObject

@property (nonatomic, strong) UIView *superView;

+ (instancetype)sharedAnimationManager;

/// 取消所有 队列操作
- (void)cancelAllOperations;

/// 动画操作 : 需要UserID和回调
- (void)animaWithMsgModel:(HNLiveChatMsgModel *)msgModel finishedBlock:(void(^)(BOOL result, NSInteger finishCount))finishedBlock;

@end
