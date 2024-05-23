//
//  LiveAdWebView.m
//  Test
//
//  Created by Wudi_Mac on 2017/1/4.
//  Copyright © 2017年 Eddie. All rights reserved.
//

#import "LiveAdWebView.h"
//#import "MSWebViewLoginInCheck.h"

@implementation LiveAdWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"LiveAdWebView" owner:nil options:nil];
        self = [nibArr lastObject];
        self.frame = frame;
    }
    return self;
}

- (void)setUpBgView
{
//    self.bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
}

- (void)loadWebView
{
    if ([self.detailUrlStr length] > 0) {
//        NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrlStr]];
//        NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.detailUrlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
//        NSString *usString=UserAgentString();
//        NSString *token = [UserInfoManager getLoginToken];
//        NSString *userid = [UserInfoManager getLoginUserId];
//        [request setValue:token forHTTPHeaderField:@"X-API-TOKEN"];
//        [request setValue:userid forHTTPHeaderField:@"X-API-USERID"];
//        [request setValue:usString forHTTPHeaderField:@"User-Agent"];
//        NSString * userGa = UserAgentString();
//        [request setValue:userGa forHTTPHeaderField:@"X-API-UA"];
        
        NSString *urlString = @"https://m.pinlian520.com/activity/live_redpacket/index.php?act_id=186&roomid=lcyxr7159154088-MNBYQN&version=5.9.2";
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.webView.delegate = self;
        [self.webView loadRequest:request];
    }
}

- (IBAction)closeAction:(UIButton *)sender {
    [self removeFromSuperview];
}

- (BOOL)webView:(IMYWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType
{
    
//    if (![MSWebViewLoginInCheck checkWebLogin:request webView:webView]) {
//        return NO;
//    }
        
//    if (navigationType == WKNavigationTypeLinkActivated)
//    {
//        NSURL *url = [request URL];
//        NSString *strUrl = [NSString stringWithString:[url absoluteString]];
//        NSArray *paraArr = [strUrl componentsSeparatedByString:@"?"];
//        NSString *linkIndexStrTemp = [paraArr firstObject];
//        if([linkIndexStrTemp isEqualToString:MSRouterLiveTag])
//        {
//            NSString * keyValueString =[paraArr lastObject];
//            NSString * userId =getUrlValueByKey(keyValueString, @"userid");
//            //进入直播
//            if (self.adLiveInfoClick) {
//                self.adLiveInfoClick(userId);
//            }
//        }else
//        {
//            if([getCurrentViewController() xm_parseUrlAndRedirect:strUrl]){
//                return NO;
//            }
//        }
//    }
//    
//    if (![MSWebViewLoginInCheck checkUA:request webView:webView]) {
//        return NO;
//    }
    
    return YES;
}

@end
