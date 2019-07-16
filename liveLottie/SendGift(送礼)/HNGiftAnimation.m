//
//  HNGiftAnimation.m
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNGiftAnimation.h"
#import "Macros.h"
@interface HNGiftAnimation ()

@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic,copy) void(^finishedBlock)(BOOL result,NSInteger finishCount);
@property (nonatomic, getter = isExecuting) BOOL executing;  // 是否执行

@end

@implementation HNGiftAnimation

@synthesize finished = _finished;
@synthesize executing = _executing;

+ (instancetype)animaOperationWithUserId:(NSString *)uid
                                   count:(NSInteger)count
                                oldCount:(NSInteger)oldCount
                               superView:(UIView *)superView
                                 chatMsg:(HNLiveChatMsgModel *)msgModel
                           finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock
{
    HNGiftAnimation *obj = [[HNGiftAnimation alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        obj.giftView = [HNSendGiftView sendGiftViewWithSuperView:superView Count:count OldCount:oldCount Identifier:uid];
        obj.giftView.msgModel = msgModel;
        obj.superView = superView;
    });
    
    obj.finishedBlock = finishedBlock;
    
    return obj;
}

- (void)start
{
    if ([self isCancelled])
    {
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    _weakself;
    @autoreleasepool
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakself.giftView.originFrame = weakself.giftView.frame;
            [weakself.superView addSubview:weakself.giftView];
            
            [weakself.giftView animateWithCompleteBlock:^(BOOL finished, NSInteger finishCount) {
                
                weakself.finished = finished;
                weakself.finishedBlock(finished, finishCount);
                
            } ViewIndex:[self.giftView.identifier integerValue]];
        });
    }
   
}

#pragma mark -  手动触发 KVO
- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

@end
