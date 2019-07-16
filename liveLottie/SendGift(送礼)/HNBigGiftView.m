//
//  HNBigGiftView.m
//  AnimationOfBigGift
//
//  Created by Red-bird on 16/10/12.
//  Copyright © 2016年 Red-bird-OfTMZ. All rights reserved.
//

#import "HNBigGiftView.h"
#import "Masonry.h"
#import "InitializationUIMethod.h"
@implementation HNBigGiftView

-(instancetype)initWithFrame:(CGRect)frame lottieName:(NSString *)lottieName withTimeinterval:(CGFloat)interval withTimes:(int)times
{
    if (self = [super initWithFrame:frame]) {
        [self createViewUIWithFrame:frame lottieName:lottieName withTimeinterval:interval withTimes:times];
    }
    return self;
}

- (void)createViewUIWithFrame:(CGRect)frame lottieName:(NSString *)lottieName withTimeinterval:(CGFloat)interval withTimes:(int)times
{
    
    [self addSubview:self.backColorView];
    _exploreAnimation = [LOTAnimationView animationNamed:lottieName];
    _exploreAnimation.cacheEnable = NO;
    _exploreAnimation.frame = self.bounds;
    _exploreAnimation.contentMode = UIViewContentModeScaleAspectFill;
//    _exploreAnimation.animationSpeed = 1.2;
    
    [self addSubview:_exploreAnimation];
    
    [_exploreAnimation  playWithCompletion:^(BOOL animationFinished) {
        if ([self.delegate respondsToSelector:@selector(cleanView)]) {
            [self.delegate cleanView];
        }
    }];
//    [self addSubview:self.animalView];
    [self addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(180);
    }];
//    _animalView.animationImages = animalArray;
//
//    _animalView.animationDuration = interval*animalArray.count;
//
//    _animalView.animationRepeatCount = times;
//    // 开启动画
//    [_animalView startAnimating];
//
//    [self performSelector:@selector(clearAinimationImageMemory) withObject:nil afterDelay:interval * animalArray.count];// 性能优化的重点来了，此处我在执行完序列帧以后我执行了一个清除内存的操作
    
}
// 清除animationImages所占用内存
- (void)clearAinimationImageMemory {
    
    [_animalView stopAnimating];
    _animalView.animationImages = nil;
    
    if ([self.delegate respondsToSelector:@selector(cleanView)]) {
        [self.delegate cleanView];
    }
    
}

- (UIImageView *)animalView
{
    if (!_animalView) {
        _animalView = [[UIImageView alloc]initWithFrame:self.frame];
        _animalView.contentMode = UIViewContentModeScaleAspectFit;
        _animalView.userInteractionEnabled=YES;
    }
    return _animalView;
}

-(UIView *)backColorView
{
    if (!_backColorView) {
        _backColorView = [[UIView alloc]initWithFrame:self.frame];
        _backColorView.backgroundColor = [UIColor clearColor];
    }
    return _backColorView;
}
- (UILabel *)infoLabel{
    
    if(!_infoLabel){
        
        _infoLabel = InsertLabel(nil, CGRectZero, NSTextAlignmentCenter, @"", [UIFont systemFontOfSize:15], [UIColor whiteColor]);
    }
    
    return _infoLabel;
}
@end
