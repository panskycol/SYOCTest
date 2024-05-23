//
//  LiveAdWebView.h
//  Test
//
//  Created by Wudi_Mac on 2017/1/4.
//  Copyright © 2017年 Eddie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMYWebView.h"

@interface LiveAdWebView : UIView <IMYWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet IMYWebView *webView;
@property (nonatomic, strong) NSString *detailUrlStr;
@property (nonatomic, copy  ) void (^adLiveInfoClick)(NSString *userId);


- (void)loadWebView;
- (void)setUpBgView;

@end
