//
//  HNSendGiftView.m
//  SunsetLive
//
//  Created by Sunwanwan on 2017/9/13.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNSendGiftView.h"
#import "HNAnimaLab.h"
#import "Masonry.h"
#import "Macros.h"
#import "InitializationUIMethod.h"
@interface HNSendGiftView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) HNAnimaLab *countLab; // 礼物个数

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval hideDuration;

@property (nonatomic, assign) NSInteger queueIndex; // 区分在哪个队列中，动画位置不同。

@property (nonatomic, copy) CompleteBlock completeBlock;

@end

@implementation HNSendGiftView

+ (HNSendGiftView *)sendGiftViewWithSuperView:(UIView *)superView
                                        Count:(NSInteger)count
                                     OldCount:(NSInteger)oldCount
                                   Identifier:(NSString *)identifier
{
    HNSendGiftView *view = [[HNSendGiftView alloc] init];
    view.oldAnimaCount = oldCount;
    view.identifier = identifier;
    view.animaCount = count;
    view.duration = 0.2;
    view.hideDuration = 0.5;
    view.alpha = 0;

    [superView addSubview:view];
    
    return view;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setUI];
    }
    return self;
}

#pragma mark ------  动画处理

// index: 第几个视图
- (void)animateWithCompleteBlock:(CompleteBlock)completed
                       ViewIndex:(NSInteger)index
{
    self.queueIndex = index;
    
    CGFloat yPosition = self.frame.origin.y;
    if (index == 1)
    {
        yPosition = self.frame.origin.y +  self.frame.size.height + Handle(10);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 1;
            self.frame = CGRectMake(0, yPosition, self.frame.size.width, self.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [self callbackShakeLabel];
        }];
    });
    
    self.completeBlock = completed;
}

//使用回调块实现不断抖动
- (void)callbackShakeLabel
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideGiftView) object:nil];
    
    if (self.oldAnimaCount < self.animaCount) {
        
        self.oldAnimaCount ++;
        
        _weakself;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakself.countLab.text = [NSString stringWithFormat:@"X %ld",(long)self.oldAnimaCount];
            
            [weakself.countLab startAnimWithDuration:weakself.duration CompleteBlock:^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakself callbackShakeLabel];
                });
            }];
        });
    }
    else
    {
        [self performSelector:@selector(hideGiftView) withObject:nil afterDelay:self.hideDuration];
    }
}

//隐藏礼物view，在2.0S后销毁该view
- (void)hideGiftView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            NSInteger tempCount = 0;//该变量的作用：避免在hide期间，_animCount增加但还没有抖动。
            if (self.oldAnimaCount > 0)
            {
                tempCount = self.oldAnimaCount;
            }
            else
            {
                tempCount = self.animaCount;
            }
            
            if (self.completeBlock)
            {
                self.completeBlock(YES,tempCount);
            }
            
            [self destroyed];
        }];
    });
}

//销毁该view，并重置所有状态
- (void)destroyed {
    
    [self reset];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

// 重置所有状态
- (void)reset {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.frame = _originFrame;
        self.countLab.text = @"";
    });
    
    self.animaCount = 1;
    self.completeBlock = nil;
}

#pragma mark - 数据刷新处理

- (void)setMsgModel:(HNLiveChatMsgModel *)msgModel
{
    _msgModel = msgModel;
    
//    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:msgModel.avatar] placeholderImage:DefaultHeaderImage];
    self.headerImg.image = [UIImage imageNamed:@"icon_fans@3x"];
    self.nameLab.text = msgModel.nick;
    self.detailLab.text = [NSString stringWithFormat:@"送了一个%@",msgModel.g_name];
     self.iconImg.image = [UIImage imageNamed:@"jinggao@3x"];
//    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:[HNTools pictureStr:msgModel.g_icon]]];
//    self.iconImg.image = GetImage(msgModel.g_icon);
    
}

#pragma mark - 点击事件处理

- (void)clickSendGiftViewHeader
{
    DLog(@"---  点击了送礼物视图");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jhClickFlyViewHeaderImage"
                                                        object:self.msgModel.uid];
}

#pragma mark - setUI

- (void)setUI
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerImg];
    [self.bgView addSubview:self.nameLab];
    [self.bgView addSubview:self.detailLab];
    [self.bgView addSubview:self.iconImg];
    [self addSubview:self.countLab];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kSpaceToLeftOrRight);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_offset(Handle_width(448 / 2));
    }];
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(Handle_width(35), Handle_height(35)));
        make.left.mas_offset(Handle(2));
    }];
    

    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImg.mas_top);
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(Handle(10));
        make.width.mas_lessThanOrEqualTo(Handle_width(270 / 2));
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom);
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(Handle_width(35), Handle_height(35)));
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.bgView.mas_right).mas_offset(Handle(10));
    }];
}

#pragma mark - getter

- (UIView *)bgView
{
    if(!_bgView)
    {
        _bgView = InsertView(nil, CGRectZero, UIColorFromHEXA(0x000000, 0.5));
        _bgView.layer.cornerRadius = Handle(20);
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)headerImg
{
    if(!_headerImg)
    {
        _headerImg = InsertImageView(nil, CGRectZero, DefaultHeaderImage);
        _headerImg.layer.cornerRadius = Handle(35 / 2);
        _headerImg.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSendGiftViewHeader)];
        [_headerImg addGestureRecognizer:ges];
    }
    return _headerImg;
}

- (UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize12, [UIColor whiteColor]);
    }
    return _nameLab;
}

- (UILabel *)detailLab
{
    if(!_detailLab)
    {
        _detailLab = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize12, UIColorFromHEXA(0xffd600, 1.0));
    }
    return _detailLab;
}

- (UIImageView *)iconImg
{
    if(!_iconImg)
    {
        _iconImg = InsertImageView(nil, CGRectZero, GetImage(@""));
        _iconImg.userInteractionEnabled=YES;
    }
    return _iconImg;
}

- (HNAnimaLab *)countLab
{
    if (!_countLab)
    {
        _countLab = [[HNAnimaLab alloc] init];
        _countLab.font = SystemFontSize(30);
        _countLab.borderColor = UIColorFromHEXA(0xfee020, 1.0);
        _countLab.textColor = UIColorFromHEXA(0xffd600, 1.0);
    }
    return _countLab;
}

@end
