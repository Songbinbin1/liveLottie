//
//  ViewController.m
//  liveLottie
//
//  Created by 宋彬彬 on 2019/7/15.
//  Copyright © 2019年 宋彬彬. All rights reserved.
//

#import "ViewController.h"
#import "HNAnimationManager.h"
#import "HNBigGiftView.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *gifBtnArr;  // 底部按钮视图数组
///点击手势
@property(strong, nonatomic) UITapGestureRecognizer *touchAnimationTap;
//
@property (strong, nonatomic)  LOTAnimationView *exploreAnimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _gifBtnArr = [NSMutableArray new];
    [_gifBtnArr addObject:@"chat_voice"];
    [_gifBtnArr addObject:@"MatchWaitingLoading"];
    [_gifBtnArr addObject:@"recognizer"];
    [_gifBtnArr addObject:@"love_like"];
    //    [_gifBtnArr addObject:@"2"];
    //    [_gifBtnArr addObject:@"3"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    _exploreAnimation = [LOTAnimationView animationNamed:@"love_dislike"];
    //    _exploreAnimation.cacheEnable = NO;
    //    _exploreAnimation.frame = self.view.bounds;
    //    _exploreAnimation.contentMode = UIViewContentModeScaleAspectFill;
    //    _exploreAnimation.animationSpeed = 1.2;
    
    [self.view addSubview:_exploreAnimation];
    //-----------------------
    _touchAnimationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchExploerView)];
    [self.view addGestureRecognizer:_touchAnimationTap];

}

-(void)touchExploerView{
    
    HNLiveChatMsgModel *msgModel = [HNLiveChatMsgModel new];
    msgModel.g_name = @"1234";
    msgModel.g_icon =  @"1234";
    msgModel.g_id =  @"1234";
    
    
    HNAnimationManager *manger = [HNAnimationManager sharedAnimationManager];
    manger.superView = self.view;
    [manger animaWithMsgModel:msgModel finishedBlock:^(BOOL result, NSInteger finishCount ) {
        
        
    }];
    [_gifBtnArr addObject:@"love_dislike"];
    [self continueReplaceShowBigGiftView];
    
    
    //   LOTAnimationView *exploreAnimation = [LOTAnimationView animationNamed:@"MatchWaitingLoading"];
    //    exploreAnimation.cacheEnable = NO;
    //    exploreAnimation.frame = self.view.bounds;
    //    exploreAnimation.contentMode = UIViewContentModeScaleAspectFill;
    //    exploreAnimation.animationSpeed = 1.2;
    //
    //    [self.view addSubview:exploreAnimation];
    //
    //    [exploreAnimation  playWithCompletion:^(BOOL animationFinished) {
    //
    //    }];
    
   
}

- (void)cleanView
{
    [self.exploreAnimation removeFromSuperview];
    self.exploreAnimation = nil;
    if (self.gifBtnArr.count>0) {
        [self.gifBtnArr removeObjectAtIndex:0];
        [self  continueReplaceShowBigGiftView];
    }
}
// 再次进行大礼物动画的播放
- (void)continueReplaceShowBigGiftView
{
    if (self.gifBtnArr.count>0) {
        if(!_exploreAnimation.isAnimationPlaying || !_exploreAnimation){
            _exploreAnimation = [LOTAnimationView animationNamed:self.gifBtnArr.firstObject];
            _exploreAnimation.cacheEnable = NO;
            _exploreAnimation.frame = self.view.bounds;
            _exploreAnimation.contentMode = UIViewContentModeScaleAspectFit;
            //    _exploreAnimation.animationSpeed = 1.2;
            
            [self.view addSubview:_exploreAnimation];
            
            [_exploreAnimation  playWithCompletion:^(BOOL animationFinished) {
                [self cleanView];
            }];
        }
        
        //        [self.view insertSubview:self.bigGiftView atIndex:0];
    }
}
@end
