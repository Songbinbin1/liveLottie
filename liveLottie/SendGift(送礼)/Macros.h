//
//  Macros.h
//  SunsetLive
//
//  Created by Sunwanwan on 2017/8/31.
//  Copyright © 2017年 HN. All rights reserved.
//  整个项目的一些宏定义处理

#ifndef Macros_h
#define Macros_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define _weakself __weak typeof(self) weakself = self
#define _strongSelf  __strong __typeof(weakself)strongSelf = weakself
//单利；

#define SingletonDefine     +(instancetype)shareInstance;

#define SingletonIMP        +(instancetype)shareInstance \
{                                     \
static id instance = nil;   \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{      \
instance = [[self alloc]init];\
});                               \
return instance;                  \
}

// 颜色
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0f green:((hex & 0xFF00) >> 8) / 255.0f blue:(hex & 0xFF) / 255.0f alpha:a]
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 等比例缩放系数
#define KEY_WINDOW    ([[[UIApplication sharedApplication] delegate] window])
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define navigation_HEIGHT  self.navigationController.navigationBar.frame.size.height
#define statusBar_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define RATIO_HEIGHT SCREEN_HEIGHT/667
#define RATIO_WIDTH SCREEN_WIDTH/375
#define Handle(x)        ((x)*SCREEN_SCALE)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)

#define X(z) ((float)(z)/750*[UIScreen mainScreen].bounds.size.width)
#define Y(z) ((float)(z)/1334*[UIScreen mainScreen].bounds.size.height)
// 系统默认字体设置和自选字体设置
#define IsIphone6P          SCREEN_WIDTH>=414
#define ScrenScale           (IsIphone6P ? 1 : 1)

#define SystemFontSize10 [UIFont systemFontOfSize:10]
#define SystemFontSize11 [UIFont systemFontOfSize:11]
#define SystemFontSize12 [UIFont systemFontOfSize:12]
#define SystemFontSize13 [UIFont systemFontOfSize:13]
#define SystemFontSize14 [UIFont systemFontOfSize:14]
#define SystemFontSize15 [UIFont systemFontOfSize:15]
#define SystemFontSize16 [UIFont systemFontOfSize:16]
#define SystemFontSize17 [UIFont systemFontOfSize:17]
#define SystemFontSize18 [UIFont systemFontOfSize:18]
#define BigSystemFontSize18 [UIFont systemFontOfSize:18 weight:UIFontWeightMedium]

#define SystemFontSize20 [UIFont systemFontOfSize:20]
#define BigSystemFontSize20  [UIFont systemFontOfSize:20 weight:UIFontWeightMedium]
#define SystemFontSize(fontsize) [UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize) [UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize) [UIFont fontWithName:fontname size:fontsize]

//获取图片资源
#define GetImage(imageName)    [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define imageDomain(imageName) [NSString stringWithFormat:@"%@/upload/%@", REQUEST,imageName]



// ihonex适配
//iPhoneX / iPhoneXS
#define   HN_isIphoneX_XS     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define   HN_isIphoneXR_XSMax    (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
//异性全面屏
#define   HN_isFullScreen    (HN_isIphoneX_XS || HN_isIphoneXR_XSMax)

#define FF_IS_IPHONE_X_P (SCREEN_WIDTH == 414)
#define FF_IS_IPHONEX (SCREEN_HEIGHT == 812)

#define FF_STATUSBAR_HEIGHT (HN_isFullScreen ? 44 : 20)
#define FF_TABBAR_HEIGHT (HN_isFullScreen ? 83 : 49)
#define FF_KEYBOARD_HEIGHT (HN_isFullScreen ? 291 : 216)

#define FF_IPHONEX_HOME_INDICATOR_PORTRAIT 34
#define FF_IPHONEX_HOME_INDICATOR_LANDSCAPE 21

#define FF_VIEW_BOTTOM_MARGIN (HN_isFullScreen ? FF_IPHONEX_HOME_INDICATOR_PORTRAIT : 0)
// 网络状态
#define NetWork_MobileNet  @"MobileNet" //3G|4G
#define NetWork_WIFI       @"WIFI" //WIFI
#define NetWork_NONET      @"NONET" //NONET
#define NetworkChangeNotification @"NetworkChangeNotification"

#pragma mark --------------------------protocal----------------------------

// 通用控件左右间隔
#define kSpaceToLeftOrRight Handle(10)

// 底部条高度
#define kBottomViewHeight 48

// 导航条高度
#define  kNavigationHeight (HN_isFullScreen ? 88 : 64)

#define ChatToolsHeight  49             // 聊天工具框高度
#define EmojiKeyboard_Height   238   // 表情键盘的高度
#define LiveChatToolsHeight 64          // 直播间聊天工具栏高度

#pragma mark ------------------------- 项目相关 ------------------------------------

#define CODE            [[responseObject objectForKey:@"c"] integerValue]
#define ERROR           [MBProgressHUD showError:@"加载失败"]
#define MBErrorMsg      [MBProgressHUD showError:responseObject[@"m"] toView:self.view]
#define MBShow          [MBProgressHUD showHUDAddedTo:self.view animated:YES]
#define MBHidden        [MBProgressHUD hideHUDForView:self.view animated:YES]
#define SuccessCode     200

#define kWebSocketUrl  @"websocketUrl"
#define Type(name)     [messageDict[@"type"] isEqualToString:name] 

#define HNNotificationUdpdateArticle  @"notificationUdpdateArticle"
#define kChangeTotalUnread  @"changeUnread"
#define kGETChallenge       @"GETCHALLENGE"
#define kUnReadKey          @"total_unread"   // 发未读消息通知时unserInfo里的key值
#define UnreadMessageCount  @"unread_count"   // 保存在本地的未读消息总数

#define kSearchHistoryData @"searchHistory"

#define kSkinType       @"skinType"       // 美颜类型
#define kSkincareValue  @"skincareValue"  // 美颜值
#define kWhiteningValue @"whiteningValue" // 美白值
#define kRuddyValue     @"ruddyValue"     // 红润值

#pragma mark ------------------------  用户相关 ------------------------------------

#define kACCOUNT  @"account"

#define kUserID   [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
#define kUDID     [[NSUserDefaults standardUserDefaults]objectForKey:@"UDID"]
#define kTOKEN    [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]?:@""
#define HNwatchNum    30*60
#define UserDefault [NSUserDefaults standardUserDefaults]

#pragma mark -------------------------  工程配置相关 --------------------

#define myAvatar [[NSUserDefaults standardUserDefaults]objectForKey:@"myAvatar"]

#define kCoinName @"红币"//[[NSUserDefaults standardUserDefaults]objectForKey:@"coin"]
#define kDotName  @"红豆"// [[NSUserDefaults standardUserDefaults]objectForKey:@"dot"]
#define kIDName   @"红号"//[[NSUserDefaults standardUserDefaults]objectForKey:@"account_name"]
#define kFreeSeeTime [[NSUserDefaults standardUserDefaults]objectForKey:@"free_time"]  // 免费观看时间
#define kSayLevel [[NSUserDefaults standardUserDefaults]objectForKey:@"say_level"]  // 发言等级
#define HNWatch_Time     [[NSUserDefaults standardUserDefaults]objectForKey:@"HNWatch_Time"]
#define kAppName  @"夕阳红直播"
#define kAppIcon  GetImage(@"main_logo")

// 获取本地版本号
#define kBundleVersionNumber [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 获取本地数字版本号
#define VersionNumber [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]

#define kGiftVersionTime  [[NSUserDefaults standardUserDefaults]objectForKey:@"gift_version_time"]  // 礼物版本更新时间

#define DefaultHeaderImage GetImage(@"home_head_default")

#define CString(k)  [[HNSkinThemeManager shareSkinThemeManager] skinColorStringWithKey:k]
#define ImageString(k)  [[HNSkinThemeManager shareSkinThemeManager] skinImageNameWithKey:k]
#define CurrentThemeIsWhite [[[HNSkinThemeManager shareSkinThemeManager] getAppSkinTheme] isEqualToString:@"white"]

// 主色调
#define MainColor        @"MainColor"

// 背景色
#define BgColor          @"BgColor"

// 分割线
#define  LineColor       @"LineColor"

// 标题颜色
#define TitleColor       @"TitleColor"

// 副标题颜色
#define SubtitleColor    @"SubtitleColor"

// 内容颜色
#define ContentColor     @"ContentColor"

// 白色文字
#define WhiteColor       @"WhiteColor"

// 按钮可点击状态
#define BtnBgColor       UIColorFromRGBA(243, 46, 23, 1)

// 按钮可点击状态
#define MainRedColor     UIColorFromRGBA(243, 46, 23, 1)
// iPhone4S

#define IS_iPhone_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone5 iPhone5s iPhoneSE

#define IS_iPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone6 7 8

#define IS_iPhone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhone6plus  iPhone7plus iPhone8plus

#define IS_iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhoneX

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)



#endif /* Macros_h */
