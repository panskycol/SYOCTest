//
//  JZScrollView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZScrollView : UIScrollView

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZScrollView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZScrollView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZScrollView * (^delegateTarget)(id<UIScrollViewDelegate> delegate);
// content
@property (strong, nonatomic, readonly) JZScrollView * (^cOffset)(CGFloat x, CGFloat y);
@property (strong, nonatomic, readonly) JZScrollView * (^cSize)(CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZScrollView * (^cInset)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
// setting
@property (strong, nonatomic, readonly) JZScrollView * (^directLock)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^bouncesEnabled)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^bounceV)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^bounceH)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^showHIndicator)(BOOL show);
@property (strong, nonatomic, readonly) JZScrollView * (^showVIndicator)(BOOL show);
@property (strong, nonatomic, readonly) JZScrollView * (^delayTouches)(BOOL delay);
@property (strong, nonatomic, readonly) JZScrollView * (^canCancelTouches)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^minScale)(CGFloat scale);
@property (strong, nonatomic, readonly) JZScrollView * (^maxScale)(CGFloat scale);
@property (strong, nonatomic, readonly) JZScrollView * (^zScale)(CGFloat scale);
@property (strong, nonatomic, readonly) JZScrollView * (^scrollTop)(BOOL enabled);
@property (strong, nonatomic, readonly) JZScrollView * (^scrollPage)(BOOL enabled);

+ (JZScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
