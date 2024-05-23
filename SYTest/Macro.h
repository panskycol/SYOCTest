//
//  Macro.h
//  Kitty
//
//  Created by Wudi_Mac on 2019/5/16.
//  Copyright © 2019 User. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

// 系统控件Frame
#define UI_NAVIGATION_TITLE_FONT        [UIFont systemFontOfSize:19]
#define UI_NAVIGATION_BAR_WIDTH         200
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TAB_BAR_HEIGHT               ([MSAdapter xm_tabBarHeight])
#define UI_STATUS_BAR_HEIGHT            ([MSAdapter xm_statusBarHeight])
#define UI_TOP_HEIGHT                   (UI_STATUS_BAR_HEIGHT + UI_NAVIGATION_BAR_HEIGHT)
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_HOME_INDICATOR_HEIGHT        ([MSAdapter xm_homeIndicator])
//iOS14，状态栏的高度发生了变化
#define UI_NEW_STATUS_BAR_HEIGHT        ([MSAdapter xm_newStatusBarHeight])
#define UI_NEW_TOP_HEIGHT               (UI_NEW_STATUS_BAR_HEIGHT + UI_NAVIGATION_BAR_HEIGHT)

// API封装
#define FX(view)    view.frame.origin.x
#define FY(view)    view.frame.origin.y
#define FW(view)    view.frame.size.width
#define FH(view)    view.frame.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HEXColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#define IMG(x)  [UIImage imageNamed:x]
#define FBottom(view) (FY(view) + FH(view))
#define FRight(view) (FX(view) + FW(view))
#define UD  [NSUserDefaults standardUserDefaults]
#define RECT(x,y,width,height) CGRectMake(x, y, width, height)
#define SETIMAGE(IMAGENAME)    [UIImage imageNamed:IMAGENAME]
#define PLACEHOLDERIMAGE [UIImage imageNamed:@"xm_ms_common_def_header.png"]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref) isEqualToString:@"(null)"]))
#define StrNilToEmpty(_ref)  _ref == nil ? @"" : _ref
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
#define IsSafeArray(array) (array && [array isKindOfClass:[NSArray class]] && array.count > 0)
#define IsSafeDict(dict) (dict && [dict isKindOfClass:[NSDictionary class]] && dict.count > 0)
#define WeakSelf(type) __weak typeof(type) weak##type = type
#define StrongSelf(type) __strong typeof(type) strongSelf = type
#define ResourcePath(path)  [[NSBundle mainBundle] pathForResource:path ofType:nil]
#define ImageWithPath(path) [UIImage imageWithContentsOfFile:ResourcePath(path)]
#define GlobalPlaceHodelImage [UIImage imageNamed:@"xm_ms_common_def_header.png"]
#define kMSGlobalCustomLRMargin 13  //通用的边距
#define isCGRectNaN(rect) (isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height))
#define ALPHA    @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz#"
#define Switch_HighlightedTextColor  0
#define UP_INTERVAL 3.5

//appstore显示的版本号
#define VersionForAppStore @"5.0.8"

//主题颜色
//#define GlobalColor RGBA(249, 222, 73, 1) // 黄色
#define GlobalColor RGBA(144, 75, 255, 1)   // 紫色

//滑动菜单颜色
#define ScrollMenuTitleUnSelectedColor GlobalGrayColor
#define ScrollMenuTitleSelectedColor [UIColor blackColor]
#define ScrollMenuIndicatorColor RGBA(178, 123, 255, 1)

//cell 按下色
#define GlobalHighlightedColor RGBA(237, 237, 237, 1)
//控制器背景色
//#define GlobalBgColor RGBA(242, 242, 242, 1)
#define GlobalBgColor [UIColor whiteColor]

#define XMPageFontSize  20

//二级文字颜色
#define GlobalBlackColor RGBA(33, 26, 14, 1)
#define GlobalGrayColor RGBA(153, 153, 153, 1)

#define GlobalHigColor [UIColor colorWithRed:178.0/255.0 green:123.0/255.0 blue:255.0/255.0 alpha:1.0]
//中度
#define GlobalMidColor [UIColor colorWithRed:149.0/255.0 green:72.0/255.0 blue:255.0/255.0 alpha:1.0]

#define GlobalTextGrayColor [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0]

//滑动菜单未选中时的颜色
#define GlobalColor178 [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0]

//大部分首页字体大小(微信同步)
#define kDetailTextFontSize 17

// 打招呼按钮大小
#define  accostViewH  58
#define  topOrBottomHeight   18  //资料页cell顶部/底部高度
#define  titleLabHeight      16  //title标题
#define  DetailTextLineSpacing  2.5 //文本的行间距（和微信朋友圈一样）
#define  DiscoverAndMyInfoCellHeight 56.0 //发现页和我的页面cell高度

// 设备信息
#define IOS4 ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) // 判断是否是IOS4的系统
#define IOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f) // 判断是否是IOS5及以上的系统
#define iPhone ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]==YES)
#define iPad ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]==YES)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f) // 判断是否是IOS6的系统
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) // 判断是否是IOS7的系统
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) // 判断是否是IOS8的系统
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f) // 判断是否是IOS8的系统
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0f) // 判断是否是IOS10的系统
#define IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0f) // 判断是否是IOS10的系统
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) // 判断是否是IOS7以下的系统
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone8 ([[DeviceHardwareInfo deviceString] hasPrefix:@"iPhone 8"] ? YES : NO)
#define iPhone10 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone11ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iphoneX(iphone10)以后的设备（有底部的安全距离）
#define iPhoneX \
    ({BOOL isPhoneX = NO;\
        if (@available(iOS 11.0, *)) {\
            isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
        }\
    (isPhoneX);})

#define kSafeAreaTop \
({CGFloat safeAreaTop = 0.0;\
        if (iPhoneX) {\
            safeAreaTop = 18.0;\
        }\
    (safeAreaTop);})
#define TalkBarBottomSafeArea (iPhoneX?17:0)
#define bottomSafeAreaHeight  (iPhoneX?34:0)
#define TalkBarOriginHeight (95 + TalkBarBottomSafeArea)
#define SINGLE_LINE_BOUNDS  (1 / [UIScreen mainScreen].scale)
// 定时推送
#define LocalPushFirstDay       @"LocalPushFirstDay"
#define LocalPushSecondDay       @"LocalPushSecondDay"
#define LocalPushForthDay       @"LocalPushForthDay"

#pragma mark - 文本
//消息中系统提示
#define SYSTEMTIP            @"接收到对方发送的3条消息或互相关注后，才可与TA电话私聊"
#define MSG_STATUS_BLACK     @"对方表示不想听你说话╮(╯▽╰)╭"
#define MSG_STATUS_VERSION   @"对方版本过低，不支持此功能"
#define MSG_STATUS_FREEZE    @"你的账号已被冻结"
//通用文本设置
#define TEXT_APPTITLE (ISMSAPP?@"爱聊提示您":@"温馨提示您")
#define TEXT_ABOUTAPP (ISMSAPP?@"关于爱聊":@"关于我们")
#define TEXT_EVALUATE (ISMSAPP?@"给爱聊评价":@"评价APP")
#define TEXT_SECRETARY (ISMSAPP?@"爱聊小秘书":@"小秘书")
#define TEXT_ID (ISMSAPP?@"爱聊号":@"ID")
#define TEXT_GOLD (ISMSAPP?@"爱聊金币":@"金币")
#define TEXT_ANSWER (ISMSAPP?@"请打开爱聊接听":@"请打开APP接听")
#define TEXT_SETPWD (ISMSAPP?@"为您的爱聊账号设置一个登录密码":@"为您的账号设置一个登录密码")
#define TEXT_PRIVILEGE (ISMSAPP?@"爱聊特权":@"特权")
#define TEXT_MEMBER (ISMSAPP?@"爱聊会员":@"会员")
#define TEXT_SHARE (ISMSAPP?@"分享爱聊":@"分享APP")
#define TEXT_NOTI (ISMSAPP?@"请打开系统通知，否则无法使用爱聊":@"请打开系统通知，否则无法使用APP")
#define TEXT_NOTI1 (ISMSAPP?@"只有开启通知功能才能正常使用爱聊软件。":@"只有开启通知功能才能正常使用软件。")
#define TEXT_WELCOME (ISMSAPP?@"欢迎加入爱聊":@"欢迎加入")
#define TEXT_GET (ISMSAPP?@"我刚刚在爱聊里抢到了":@"我刚刚在直播里抢到了")
#define TEXT_GET1 (ISMSAPP?@"我在爱聊中一共抢到了":@"我在直播中一共抢到了")
#define TEXT_ENTER (ISMSAPP?@"进入爱聊":@"进入APP")
#define TEXT_MAKEFRIENDS (ISMSAPP?@"爱聊速成宝典":@"交友速成宝典")
#define TEXT_ONLINE (ISMSAPP?@"保持爱聊在线，不错过每一次缘分":@"保持APP在线，不错过每一次缘分")
#define TEXT_DISTURB (ISMSAPP?@"开启该功能后，手机在设置的时间段收到爱聊的任何消息都不会有声音和振动提醒。":@"开启该功能后，手机在设置的时间段收到本APP的任何消息都不会有声音和振动提醒。")
#define TEXT_RECOMMEND (ISMSAPP?@"推荐爱聊":@"推荐APP")
#define TEXT_NEWMESSAGENOTI (ISMSAPP?@"关闭后爱聊不会给您发新消息通知。":@"关闭后APP不会给您发新消息通知。")
#define TEXT_MESSAGENOTICON (ISMSAPP?@"关闭后，当收到爱聊消息时，通知提示将不显示消息内容":@"关闭后，当收到APP消息时，通知提示将不显示消息内容")
#define TEXT_MESSAGENOTICON1 (ISMSAPP?@"若关闭，当收到爱聊消息时，通知提示将不显示发信人和内容摘要。":@"若关闭，当收到APP消息时，通知提示将不显示发信人和内容摘要。")
#define TEXT_MESSAGENOTICON2 (ISMSAPP?@"当爱聊运行时，你可以设置是否需要声音或者振动提醒。":@"当APP运行时，你可以设置是否需要声音或者振动提醒。")
//替换APP名称
#define TEXT_PRIVACYMIC ([NSString stringWithFormat:@"请在iPhone的\"设置-隐私-麦克风\"选项中，允许%@访问您的麦克风",APPDISPLAYNAME])
#define TEXT_CAMERAPERTITLE ([NSString stringWithFormat:@"%@需要访问你的相机",APPDISPLAYNAME])
#define TEXT_CAMERAPERDESC ([NSString stringWithFormat:@"要直播视频，%@需要访问你的相机权限。点击\"设置\"前往系统设置允许%@访问你的相机",APPDISPLAYNAME,APPDISPLAYNAME])
#define TEXT_MICPERTITLE ([NSString stringWithFormat:@"%@需要访问你的麦克风",APPDISPLAYNAME])
#define TEXT_MICPERDESC ([NSString stringWithFormat:@"要直播视频，%@需要访问你的麦克风权限。点击\"设置\"前往系统设置允许%@访问你的麦克风",APPDISPLAYNAME,APPDISPLAYNAME])
//权限提示
#define TEXT_CAMERA ([NSString stringWithFormat:@"%@需要访问你的相机权限。点击\"设置\"前往系统设置允许%@访问你的相机",APPDISPLAYNAME,APPDISPLAYNAME])
#define TEXT_MIC ([NSString stringWithFormat:@"%@需要访问你的麦克风。点击\"设置\"前往系统设置允许%@访问你的麦克风",APPDISPLAYNAME,APPDISPLAYNAME])
#define TEXT_PHOTO ([NSString stringWithFormat:@"%@需要访问你的相册权限。点击\"设置\"前往系统设置允许%@访问你的相册",APPDISPLAYNAME,APPDISPLAYNAME])
#define TEXT_OTHER ([NSString stringWithFormat:@"%@需要访问你的相关权限。点击\"设置\"前往系统设置允许%@访问",APPDISPLAYNAME,APPDISPLAYNAME])

#define TEXT_VOICECALL_ON_TITLE    @"语音接听已开启"
#define TEXT_VOICECALL_OFF_TITLE   @"语音接听已关闭"

#define TEXT_VIDEOCALL_ON_TITLE    @"视频接听已开启"
#define TEXT_VIDEOCALL_OFF_TITLE   @"视频接听已关闭"

#define TEXT_REMARKNAME_FOLLOW   @"关注后设置备注名更有意义哦~"

#define MoreActionRemark   @"设置备注名"

#define NetError @"网络异常，请检查网络"
#define SignTipTag       10001
#define SignTitleTag       10002
#define SignTextTag        10003
#define UserIdTag          10004
#define SignTipRewardTip   10005

#define CertImageTag       10013
#define CertLabelTag       10014
#define CertTipLabelTag    10015
#define CertArrowTag       10016
#define NobleStatusTag     20019
#define NobleTipTag        20020
#define NobleIconTag       20021
#define NobleArrowIconTag  20022
#define BaseInfoTag        20023
#define MyTagTag           20024
#define HobbyTag           20025
#define TitleTag           20026
#define FamilyStatusTag    20027
#define RingArrowIconTag   20028
#define RingTipLabelTag    20029
#define RingImageTag       20030
#define CarArrowIconTag    20031
#define CarTipLabelTag     20032
#define CarImageTag        20033
#define AvatarFrameImageTag         20034
#define AvatarFrameArrowIconTag     20035
#define AvatarFrameTipLabelTag      20036

#define kML375Scale(value) (UI_SCREEN_WIDTH/375.0 * value)
#define CellTitleFont      [UIFont systemFontOfSize:14.0]
#define CellTitleColor     RGBA(154, 154, 154, 1)
#define XMMsgListCellRedColor RGB(235, 78, 61)
#define CellSubTitleFont      [UIFont systemFontOfSize:15.0]
#define getQuickMsg     [NSString stringWithFormat:@"http://message%@/get_quick_message.php",g_http_url]
#define getMessageHost(x) [NSString stringWithFormat:@"http://message%@/%@",g_http_url,x]
#define getUserHost(x) [NSString stringWithFormat:@"http://user%@/%@",g_http_url,x]

#define KSysAccostTag @"system_accost_tag"
#define KSysAccostGirlReply @"saccost_girl_replay"
#define KSysAccostBoyReply @"saccost_boy_replay"

//判断是否是系统用户
#define isSystemUserId(userId) (userId.integerValue <= 10000)
//判断是否是CP系统用户
#define isCPSystemUserId(userId) (userId.integerValue == 9002)

typedef NS_ENUM(NSInteger, CHATROOMTYPE) {
    FAMILYTYPE = 0,//
    G_ROOMTYPE = 1,    //官方聊天室
    N_ROOMTYPE = 2,     //普通聊天室
    GN_ROOMTYPE = 3      //官方/普通聊天室 不区分
};

typedef NS_ENUM(NSInteger, INIT_STYLE) {
    BigPic_Module = 0,//展示最近，列表需要家族聊天项
    Chat_Module = 1,//展示最近，列表需要家族聊天项
    Family_Module = 2,//展示最近，列表不需要家族聊天项
    Friends_Module,//展示亲密,列表不需要家族聊天项
    Ring_Module
};

typedef NS_ENUM(NSInteger, NETWORK_STATUS) {
    NKUnknown          = -1,
    NKNotReachable     = 0,
    NKViaWWAN = 1,
    NKViaWiFi = 2,
};

typedef NS_ENUM(NSInteger, LIVEPLAN) {
    LPZegoLive     = 1,
    LPQNLive          = 0,
    LPAgoraLive     = 2,
};

typedef NS_ENUM(NSInteger, ZEGOPULLMETHOD) {
    ZegoRTC  = 1,
    ZegoL3   = 2,
    ZegoCDN  = 3
};

#define XMTICK   NSDate *startTime = [NSDate date];
#define XMTOCK   NSLog(@"*********Time: %f", -[startTime timeIntervalSinceNow]);

#define kGetTopicListUrl [NSString stringWithFormat:@"http://blognew%@/story_list.php",g_http_url]
#define kGetTopicInitUrl [NSString stringWithFormat:@"http://blognew%@/story_init.php",g_http_url]
#define kGetBlogAdUrl [NSString stringWithFormat:@"http://webad%@/ad_blog.php",g_http_url]
#define kEmojiImageGifHostUrl [UserInfoManager dynamicEmojiUrlPrefix].length?[UserInfoManager dynamicEmojiUrlPrefix]:@"https://img1.liang520.com/vhuaboss/images/dynamic_emoji/"

#define XMStartTime() NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970] * 1000;
#define XMEndTime()   NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970] * 1000; NSLog(@"*****took time: %.0f ms", endTime-startTime);

// 辅助函数：将角度转换为弧度
static CGFloat DEGREES_TO_RADIANS(CGFloat degrees) {
    return degrees * M_PI / 180.0;
}

#endif /* Macro_h */
