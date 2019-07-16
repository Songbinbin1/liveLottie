//
//  HNCacheData.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNCacheData : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger oldCount;//记录上次动画结束时的礼物数量
@property (nonatomic, strong) NSString *giftName;

+ (HNCacheData *)createDataWithDate:(NSDate *)date Count:(NSInteger)count GiftName:(NSString *)giftName;

@end
