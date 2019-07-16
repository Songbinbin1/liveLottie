//
//  HNAnimationManager.m
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNAnimationManager.h"
#import "HNCacheData.h"
#import "HNGiftAnimation.h"
#import "Macros.h"
@interface HNAnimationManager ()

@property (nonatomic, assign) NSInteger count;

/// 队列1
@property (nonatomic,strong) NSOperationQueue *queue1;
/// 队列2
@property (nonatomic,strong) NSOperationQueue *queue2;

/// 操作缓存池
@property (nonatomic,strong) NSCache *operationCache;
/// 维护用户礼物信息
@property (nonatomic,strong) NSCache *userGiftInfos;

@property (nonatomic, assign) int isInQueue1;

@property (nonatomic, assign) BOOL isHaveOperationCache;  // 判断是否有缓存

@end

@implementation HNAnimationManager

+ (instancetype)sharedAnimationManager
{
    static HNAnimationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HNAnimationManager alloc] init];
        manager.count = 0;
        manager.isInQueue1 = 0;
    });
    return manager;
}

- (void)animaWithMsgModel:(HNLiveChatMsgModel *)msgModel finishedBlock:(void(^)(BOOL result, NSInteger finishCount))finishedBlock
{
    _weakself;
    NSString *index = [NSString stringWithFormat:@"%d",_isInQueue1];
    
    //拼接key存入NSCache
    NSString *key = [NSString stringWithFormat:@"%@%@",msgModel.nick,msgModel.g_name];
    
    // 在有用户礼物信息时
    if ([self.userGiftInfos objectForKey:key])
    {
        HNCacheData *cacheGiftData = [self.userGiftInfos objectForKey:key];
        double timeInterval = [[NSDate date]  timeIntervalSinceDate:cacheGiftData.date];
        if (timeInterval > 3)
        {
            //超过3s，连击失效
            cacheGiftData.count = 1;
            cacheGiftData.oldCount = 0;
            [self.operationCache removeObjectForKey:key];
            
            self.isHaveOperationCache = NO;
        }
        else
        {
            cacheGiftData.count += 1;
        }
        
        cacheGiftData.date = [NSDate date];
        [self.userGiftInfos setObject:cacheGiftData forKey:key];
        
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:key] != nil)
        {
            HNGiftAnimation *animObj = [self.operationCache objectForKey:key];
            animObj.giftView.animaCount = cacheGiftData.count;
            
            self.isHaveOperationCache = YES;
            
            return ;
        }
        
        //没有操作，创建
        
        HNGiftAnimation *animaObj = [HNGiftAnimation animaOperationWithUserId:index count:cacheGiftData.count oldCount:cacheGiftData.oldCount superView:self.superView chatMsg:msgModel finishedBlock:^(BOOL result, NSInteger finishCount) {
            
            [weakself.operationCache removeObjectForKey:key];
            
            // 回调
            if (self.isHaveOperationCache == YES)
            {
                if (finishedBlock)
                {
                    finishedBlock(result,finishCount - cacheGiftData.oldCount);
                }
            }
            else
            {
                if (finishedBlock)
                {
                    finishedBlock(result,finishCount);
                }
            }
            
            //存储结束时的count
            HNCacheData *cacheGiftData = [weakself.userGiftInfos objectForKey:key];
            cacheGiftData.oldCount = finishCount;
            if (cacheGiftData != nil)
            {
                [weakself.userGiftInfos setObject:cacheGiftData forKey:key];
            }
        }];
        
        // 将操作添加到缓存池
        [self.operationCache setObject:animaObj forKey:key];
        
        if (_isInQueue1 == 1)
        {
            _isInQueue1 = 0;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                animaObj.giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.4 - Handle_height(30), Handle(180), Handle_height(40));
                
                animaObj.giftView.originFrame = animaObj.giftView.frame;
            });
            
            [self.queue1 addOperation:animaObj];
        }
        else
        {
            _isInQueue1 = 1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                animaObj.giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.5, Handle(180), Handle_height(40));
                
                animaObj.giftView.originFrame = animaObj.giftView.frame;
            });
            
            [self.queue2 addOperation:animaObj];
        }
    }
    else
    {
        // 没有用户礼物时， 不存在该操作，直接创建
        HNGiftAnimation *animObj = [HNGiftAnimation animaOperationWithUserId:index count:1 oldCount:0 superView:self.superView chatMsg:msgModel finishedBlock:^(BOOL result, NSInteger finishCount) {
            
            [weakself.operationCache removeObjectForKey:key];
            
            if (finishedBlock)
            {
                finishedBlock(result, finishCount);
            }
            
            HNCacheData *cacheGiftData = [weakself.userGiftInfos objectForKey:key];
            cacheGiftData.oldCount = finishCount;
            if (cacheGiftData != nil)
            {
                [weakself.userGiftInfos setObject:cacheGiftData forKey:key];
            }
        }];
        
        // 将礼物数量存起来
        HNCacheData *cacheData = [HNCacheData createDataWithDate:[NSDate date] Count:1 GiftName:msgModel.g_name];
        [self.userGiftInfos setObject:cacheData forKey:key];
        
        // 将操作添加到缓存池
        [self.operationCache setObject:animObj forKey:key];
        
        if (_isInQueue1 == 1)
        {
            _isInQueue1 = 0;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                animObj.giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.4 - Handle_height(30), Handle(180), Handle_height(40));
                
                animObj.giftView.originFrame = animObj.giftView.frame;
                
            });
            
            [self.queue1 addOperation:animObj];
        }
        else
        {
            _isInQueue1 = 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                animObj.giftView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.5, Handle(180), Handle_height(40));
                
                animObj.giftView.originFrame = animObj.giftView.frame;
                
            });
            
            [self.queue2 addOperation:animObj];
        }
    }
}

#pragma mark - getter

- (NSOperationQueue *)queue1
{
    if (_queue1==nil)
    {
        _queue1 = [[NSOperationQueue alloc] init];
        _queue1.maxConcurrentOperationCount = 1;
        
    }
    return _queue1;
}

- (NSOperationQueue *)queue2
{
    if (_queue2==nil)
    {
        _queue2 = [[NSOperationQueue alloc] init];
        _queue2.maxConcurrentOperationCount = 1;
    }
    return _queue2;
}

- (NSCache *)operationCache
{
    if (_operationCache==nil)
    {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

- (NSCache *)userGiftInfos
{
    if (_userGiftInfos == nil)
    {
        _userGiftInfos = [[NSCache alloc] init];
    }
    return _userGiftInfos;
}

- (void)cancelAllOperations
{
    [self.queue1 cancelAllOperations];
    self.queue1 = nil;
    
    [self.queue2 cancelAllOperations];
    self.queue2 = nil;
    
    [self.userGiftInfos removeAllObjects];
    self.userGiftInfos = nil;
    
    [self.operationCache removeAllObjects];
    self.operationCache = nil;
}

@end
