//
//  HNBigGiftView.h
//  AnimationOfBigGift
//
//  Created by Red-bird on 16/10/12.
//  Copyright © 2016年 Red-bird-OfTMZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>
@protocol HNBigGiftViewDelegate <NSObject>

- (void)cleanView;

@end


@interface HNBigGiftView : UIView

@property (nonatomic, strong) UIView              *alpthView;       //!< 透视图
@property (nonatomic, strong) UIImageView         *animalView;      //!< 加载帧动画的图
@property (nonatomic, strong) UIView              *backColorView;   //!< 底部透明图片
@property(nonatomic ,strong)  UILabel *infoLabel; //!<礼物说明文字
@property (nonatomic, weak) id<HNBigGiftViewDelegate>delegate;      //!< 代理
@property (strong, nonatomic)  LOTAnimationView *exploreAnimation;

/**
 *  创建一个动画视图，在传入的图片数组里面存储的对象是经过压缩处理的图片
 *
 *  @param frame       坐标
 *  @param lottieName 传进的执行动画
 *  @param interval    每张图片的显示时间
 *  @param times       播放次数
 *
 *  @return 返回
 */
- (instancetype)initWithFrame:(CGRect)frame
             lottieName:(NSString *)lottieName
             withTimeinterval:(CGFloat)interval
                    withTimes:(int)times;


@end
