//
//  HNAnimaLab.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//  礼物动画上的lab

#import <UIKit/UIKit.h>

typedef void(^ShakeLabelCompleteBlock)(void);

@interface HNAnimaLab : UILabel

// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;


// 累计数字， 抖动动画
- (void)startAnimWithDuration:(NSTimeInterval)duration CompleteBlock:(ShakeLabelCompleteBlock)completed;

@end
