//
//  HNCacheData.m
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNCacheData.h"

@implementation HNCacheData

+ (HNCacheData *)createDataWithDate:(NSDate *)date Count:(NSInteger)count GiftName:(NSString *)giftName
{
    HNCacheData *data = [HNCacheData new];
    data.date = date;
    data.count = count;
    data.giftName = giftName;
    data.oldCount = 0;
    return data;
}

@end
