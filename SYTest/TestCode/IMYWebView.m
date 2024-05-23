//
//  IMYWebView.m
//  IMY_ViewKit
//
//  Created by ljh on 15/7/1.
//  Copyright (c) 2015年 IMY. All rights reserved.
//

#import "IMYWebView.h"
//#import "MSGiftEffectManager.h"
//#import "GiftAnimation.h"
//#import "MSGIftAnim.h"
//#import "SoundPlay.h"
//#import "MSGiftItem.h"
//#import "MSGIftDetailManager.h"
//#import <TargetConditionals.h>
//#import <dlfcn.h>

//解决循环引用问题
@interface IMYWebViewScriptMessageHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic, copy) void (^messageHandler)(WKScriptMessage *message);

@end

@implementation IMYWebViewScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.messageHandler) {
        self.messageHandler(message);
    }
}

@end




@interface IMYWebView() <WKNavigationDelegate,WKUIDelegate>

//@property (nonatomic, strong) MSGiftEffectManager *giftEffectMgr;
@property (retain, nonatomic) CALayer * rootLayer;

@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) IMYWebViewScriptMessageHandler *scriptMessageHandler;
@end

@implementation IMYWebView

@synthesize realWebView = _realWebView;
@synthesize scalesPageToFit = _scalesPageToFit;

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initMyself];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initMyself];
    }
    return self;
}

- (void)addScriptMessageHandlers
{
    //防止多次调用Crash
    [self removeScriptMessageHandlers];
    [((WKWebView*)self.realWebView).configuration.userContentController addScriptMessageHandler:self.scriptMessageHandler name:@"playGiftAnimation"];
}

- (void)removeScriptMessageHandlers {
    [((WKWebView*)self.realWebView).configuration.userContentController removeScriptMessageHandlerForName:@"playGiftAnimation"];
}

- (void)_initMyself{
    [self initWKWebView];
    self.scalesPageToFit = YES;
    [self.realWebView setFrame:self.bounds];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
    
//    @weakify(self)
    self.scriptMessageHandler.messageHandler = ^(WKScriptMessage *message) {
//        @strongify(self)
        [self didReceiveScriptMessage:message];
    };
    
    [self addScriptMessageHandlers];
}

- (void)initWKWebView{
//    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
//    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
//    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width viewport-fit=cover'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.allowsInlineMediaPlayback = YES;
    if (@available(iOS 10.0, *)) {
        wkWebConfig.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    }
    wkWebConfig.userContentController = wkUController;
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.bounds configuration:wkWebConfig];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    _realWebView = webView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
    }
    else if([keyPath isEqualToString:@"title"])
    {
        self.title = change[NSKeyValueChangeNewKey];
    }
}


#pragma mark- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    if(resultBOOL){
        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil)
        {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self callback_webViewDidStartLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self callback_webViewDidFinishLoad];
}

- (void)webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error{
    [self callback_webViewDidFailLoadWithError:error];
}

- (void)webView: (WKWebView *)webView didFailNavigation:(WKNavigation *) navigation withError: (NSError *) error{
    [self callback_webViewDidFailLoadWithError:error];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }
}

#pragma mark- WKUIDelegate
///--  还没用到
#pragma mark- CALLBACK IMYVKWebView Delegate

- (void)callback_webViewDidFinishLoad{
    if([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]){
        [self.delegate webViewDidFinishLoad:self];
    }
}

- (void)callback_webViewDidStartLoad{
    if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]){
        [self.delegate webViewDidStartLoad:self];
    }
}

- (void)callback_webViewDidFailLoadWithError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]){
        [self.delegate webView:self didFailLoadWithError:error];
    }
}

- (BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType{
    BOOL resultBOOL = YES;
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}

#pragma mark- 基础方法
-(UIScrollView *)scrollView{
    return [(id)self.realWebView scrollView];
}

- (id)loadRequest:(NSURLRequest *)request{
    self.originRequest = request;
    self.currentRequest = request;
    return [(WKWebView*)self.realWebView loadRequest:request];
}

- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    return [(WKWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
}

-(NSURLRequest *)currentRequest{
    return _currentRequest;
}

-(NSURL *)URL{
    return [(WKWebView*)self.realWebView URL];
}

-(BOOL)isLoading{
    return [self.realWebView isLoading];
}

-(BOOL)canGoBack{
    return [self.realWebView canGoBack];
}

-(BOOL)canGoForward{
    return [self.realWebView canGoForward];
}

- (id)goBack{
    return [(WKWebView*)self.realWebView goBack];
}

- (id)goForward{
    return [(WKWebView*)self.realWebView goForward];
}

- (id)reload{
    return [(WKWebView*)self.realWebView reload];
}

- (id)reloadFromOrigin{
    return [(WKWebView*)self.realWebView reloadFromOrigin];
}

- (void)stopLoading{
    [self.realWebView stopLoading];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler{
    return [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString{
    __block NSString* result = nil;
    __block BOOL isExecuted = NO;
    [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
        result = obj;
        isExecuted = YES;
    }];
    
    while (isExecuted == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return result;
}

-(void)setScalesPageToFit:(BOOL)scalesPageToFit{
    if(_scalesPageToFit == scalesPageToFit)
    {
        return;
    }
    
    WKWebView* webView = _realWebView;
    
    NSString *jScript = @"var meta = document.createElement('meta'); \
    meta.name = 'viewport'; \
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
    var head = document.getElementsByTagName('head')[0];\
    head.appendChild(meta);";
    
    if(scalesPageToFit){
        WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [webView.configuration.userContentController addUserScript:wkUScript];
    }else{
        NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
        for (WKUserScript *wkUScript in array){
            if([wkUScript.source isEqual:jScript]){
                [array removeObject:wkUScript];
                break;
            }
        }
        for (WKUserScript *wkUScript in array){
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
    }
    
    _scalesPageToFit = scalesPageToFit;
}

-(BOOL)scalesPageToFit{
    return _scalesPageToFit;
}

-(NSInteger)countOfHistory{
    WKWebView* webView = self.realWebView;
    return webView.backForwardList.backList.count;
}

-(void)gobackWithStep:(NSInteger)step{
    if(self.canGoBack == NO)
        return;
    
    if(step > 0){
        NSInteger historyCount = self.countOfHistory;
        if(step >= historyCount)
        {
            step = historyCount - 1;
        }
        
        WKWebView* webView = self.realWebView;
        WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
        [webView goToBackForwardListItem:backItem];
    }else{
        [self goBack];
    }
}

#pragma mark-  如果没有找到方法 去realWebView 中调用
-(BOOL)respondsToSelector:(SEL)aSelector{
    BOOL hasResponds = [super respondsToSelector:aSelector];
    if(hasResponds == NO){
        hasResponds = [self.delegate respondsToSelector:aSelector];
    }if(hasResponds == NO){
        hasResponds = [self.realWebView respondsToSelector:aSelector];
    }
    return hasResponds;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector{
    NSMethodSignature* methodSign = [super methodSignatureForSelector:selector];
    if(methodSign == nil){
        if([self.realWebView respondsToSelector:selector]){
            methodSign = [self.realWebView methodSignatureForSelector:selector];
        }else{
            methodSign = [(id)self.delegate methodSignatureForSelector:selector];
        }
    }
    return methodSign;
}

- (void)forwardInvocation:(NSInvocation*)invocation{
    if([self.realWebView respondsToSelector:invocation.selector]){
        [invocation invokeWithTarget:self.realWebView];
    }else{
        [invocation invokeWithTarget:self.delegate];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name caseInsensitiveCompare:@"playGiftAnimation"] == NSOrderedSame) {
        // 处理发消息回调方法
        if ([message.body isKindOfClass:[NSDictionary class]]) {
//            [self playGiftAnimation:message.body[@"giftId"]
//                          giftCount:message.body[@"giftCount"]];
        }
    }
}

//- (void)playGiftAnimation:(NSString *)giftId
//                giftCount:(NSString *)giftCount{
//    WeakSelf(self);
//    [MSGIftDetailManager getBlindBoxGiftDetailFromNetById:giftId
//                                                boxGiftId:nil
//                                                 toUserId:nil
//                                                 comefrom:@"user"
//                                                    block:^(MSGiftItem *giftItem) {
//        if (giftItem) {
//            NSString *imageUrlStr = [giftItem.giftImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
//            [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl options:SDWebImageContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL * imageURL) {
//                [weakself handleGift:giftItem sendCount:giftCount giftImage:image];
//            }];
//        }else {
//            [SVProgressHUD showErrorWithStatus:@"获取礼物失败"];
//        }
//    } fail:^{
//        [SVProgressHUD showErrorWithStatus:NetError];
//    }];
//}

//- (void)handleGift:(MSGiftItem *)giftItem
//         sendCount:(NSString *)sendCount
//         giftImage:(UIImage *)image
//{
//    // 交给礼物赠送类去处理，展示动画和连击
//    self.giftEffectMgr.currentGift = giftItem;
//    self.giftEffectMgr.sendCount = sendCount;
//    self.giftEffectMgr.circleButtonShow = NO;
////    self.giftEffectMgr.receiveGiftUserId = self._peerUid;
//    self.giftEffectMgr.currentGiftImage = image;
//    [self.giftEffectMgr setContentView:getCurrentViewController().view];
//
//    NSInteger count = [sendCount integerValue];
//    if ([[MSCallManager sharedManager].callModel callStatus] == MSSipCall_CallerReady && ![[MessageObject sharedInstance] isAudioRecording] && ![[MessageObject sharedInstance] isAudioPlaying]) {
//        if (count < 10) {
//            [[SoundPlay sharedInstance] playWavSoundWithSoundName:@"gift_send.mp3"];
//        }else{
//            [[SoundPlay sharedInstance] playWavSoundWithSoundName:@"喝彩.mp3"];
//        }
//    }
//    if (count == 1) {
//        GiftAnimation *giftAnimation = [[GiftAnimation alloc] init];
//        [giftAnimation xm_showGift:getCurrentViewController().view giftImage:image giftDirection:SendDir];
//    }else{
//        //播放粒子动画
//        [self playEmitterAnim:image birthRate:[sendCount integerValue]];
//    }
//}

//- (void)playEmitterAnim:(UIImage *)image birthRate:(NSInteger)birthRate
//{
//    [self xm_clearEmitterAnim];
//    self.rootLayer = [[MSGIftAnim alloc] initWithImage:image birthRate:birthRate animDirection:emitterBottom];
//    [getCurrentViewController().view.layer addSublayer:self.rootLayer];
//}

- (void)xm_clearEmitterAnim
{
    [self.rootLayer removeFromSuperlayer];
    self.rootLayer = nil;
}

//- (MSGiftEffectManager *)giftEffectMgr
//{
//    if (!_giftEffectMgr) {
//        _giftEffectMgr = [[MSGiftEffectManager alloc] init];
////        _giftEffectMgr.delegate = self;
//    }
//    return _giftEffectMgr;
//}


#pragma mark- 清理
- (void)dealloc{
    WKWebView* webView = _realWebView;
    webView.UIDelegate = nil;
    webView.navigationDelegate = nil;
    
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [webView removeObserver:self forKeyPath:@"title"];
    
    [self removeScriptMessageHandlers];
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [(WKWebView *)_realWebView loadHTMLString:@"" baseURL:nil];
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}

@end
