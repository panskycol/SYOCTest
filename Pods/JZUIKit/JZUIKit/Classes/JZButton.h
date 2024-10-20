//
//  JZButton.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"
#import "JZAnim.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JZButtonContentLayoutStyle) {
    JZButtonContentLayoutStyleTop,    // image在上，label在下
    JZButtonContentLayoutStyleLeft,   // image在左，label在右
    JZButtonContentLayoutStyleBottom, // image在下，label在上
    JZButtonContentLayoutStyleRight   // image在右，label在左
};

@interface JZButton : UIButton

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;
@property (strong, nonatomic) JZAnim *anim;
@property (strong, nonatomic) JZAnim *imageAnim;

@property (strong, nonatomic, readonly) JZButton * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZButton * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
// title
@property (strong, nonatomic, readonly) JZButton * (^title)(NSString *title);
@property (strong, nonatomic, readonly) JZButton * (^hTitle)(NSString *title);
@property (strong, nonatomic, readonly) JZButton * (^sTitle)(NSString *title);
@property (strong, nonatomic, readonly) JZButton * (^attributedTitle)(NSAttributedString *aTitle);
@property (strong, nonatomic, readonly) JZButton * (^titleInset)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property (strong, nonatomic, readonly) JZButton * (^contentAlign)(UIControlContentHorizontalAlignment align);
// image
@property (strong, nonatomic, readonly) JZButton * (^img)(NSString *imageName);
@property (strong, nonatomic, readonly) JZButton * (^hImg)(NSString *imageName);
@property (strong, nonatomic, readonly) JZButton * (^sImg)(NSString *imageName);
@property (strong, nonatomic, readonly) JZButton * (^bgImg)(NSString *imageName);
@property (strong, nonatomic, readonly) JZButton * (^imgInset)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property (strong, nonatomic, readonly) JZButton * (^contentLayout)(JZButtonContentLayoutStyle style, CGFloat spacing);
// color
@property (strong, nonatomic, readonly) JZButton * (^bColorHex)(NSString *hexString, CGFloat alpha);
@property (strong, nonatomic, readonly) JZButton * (^txtColorHex)(NSString *hexString, CGFloat alpha, UIControlState state);
@property (strong, nonatomic, readonly) JZButton * (^bColor)(UIColor *color);
@property (strong, nonatomic, readonly) JZButton * (^txtColor)(UIColor *color, UIControlState state);

// font
@property (strong, nonatomic, readonly) JZButton * (^fntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZButton * (^mFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZButton * (^bFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZButton * (^fnt)(UIFont *font);

// layer
@property (strong, nonatomic, readonly) JZButton * (^gradient)(NSArray *colors, NSArray *hColors, CGFloat cornerRadius);
@property (strong, nonatomic, readonly) JZButton * (^shadow)(UIView *containerView, CGFloat cornerRadius);
@property (strong, nonatomic, readonly) JZButton * (^corner)(CGFloat cornerRadius);
// action
@property (strong, nonatomic, readonly) JZButton * (^action)(id target, SEL action);
@property (strong, nonatomic, readonly) JZButton * (^resInterval)(NSTimeInterval interval);

+ (JZButton *)button;
+ (JZButton *)gridentBtnInFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
