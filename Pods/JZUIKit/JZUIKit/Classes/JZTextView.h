//
//  JZTextView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZTextView : UITextView

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZTextView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZTextView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZTextView * (^delegateTarget)(id<UITextViewDelegate> delegate);
// text
@property (strong, nonatomic, readonly) JZTextView * (^txt)(NSString *text);
@property (strong, nonatomic, readonly) JZTextView * (^attributedTxt)(NSAttributedString *aTxt);
@property (strong, nonatomic, readonly) JZTextView * (^pHolder)(NSString *text);
@property (strong, nonatomic, readonly) JZTextView * (^attributedPHolder)(NSAttributedString *aTxt);
// font
@property (strong, nonatomic, readonly) JZTextView * (^fntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextView * (^mFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextView * (^bFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextView * (^fnt)(UIFont *font);

// color
@property (strong, nonatomic, readonly) JZTextView * (^txtColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZTextView * (^bColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZTextView * (^txtColor)(UIColor *color);
@property (strong, nonatomic, readonly) JZTextView * (^bColor)(UIColor *color);

// layout
@property (strong, nonatomic, readonly) JZTextView * (^align)(NSTextAlignment align);
@property (strong, nonatomic, readonly) JZTextView * (^editAble)(BOOL editable);
@property (strong, nonatomic, readonly) JZTextView * (^selectAble)(BOOL selectable);
@property (strong, nonatomic, readonly) JZTextView * (^detectorTypes)(UIDataDetectorTypes types);
@property (strong, nonatomic, readonly) JZTextView * (^allowsEditTxtAttrs)(BOOL allow);
@property (strong, nonatomic, readonly) JZTextView * (^typingAttrs)(NSDictionary<NSAttributedStringKey, id> *typingAttributes);

+ (JZTextView *)textView;

@end

NS_ASSUME_NONNULL_END
