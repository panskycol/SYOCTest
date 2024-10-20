//
//  JZLabel.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZLabel : UILabel

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout; 

@property (strong, nonatomic, readonly) JZLabel * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZLabel * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
// text
@property (strong, nonatomic, readonly) JZLabel * (^txt)(NSString *text);
@property (strong, nonatomic, readonly) JZLabel * (^attributedTxt)(NSAttributedString *aTxt);
// font
@property (strong, nonatomic, readonly) JZLabel * (^fntSize)(CGFloat size); 
@property (strong, nonatomic, readonly) JZLabel * (^mFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZLabel * (^bFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZLabel * (^fnt)(UIFont *font);

// color
@property (strong, nonatomic, readonly) JZLabel * (^txtColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZLabel * (^bColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZLabel * (^txtColor)(UIColor *color);
@property (strong, nonatomic, readonly) JZLabel * (^bColor)(UIColor *color);

// layout
@property (strong, nonatomic, readonly) JZLabel * (^align)(NSTextAlignment align);
@property (strong, nonatomic, readonly) JZLabel * (^lines)(NSInteger lines);

+ (JZLabel *)label;

@end

NS_ASSUME_NONNULL_END
