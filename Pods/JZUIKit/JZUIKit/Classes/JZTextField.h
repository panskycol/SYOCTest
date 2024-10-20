//
//  JZTextField.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZTextField : UITextField

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZTextField * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZTextField * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZTextField * (^delegateTarget)(id<UITextFieldDelegate> delegate);
// text
@property (strong, nonatomic, readonly) JZTextField * (^txt)(NSString *text);
@property (strong, nonatomic, readonly) JZTextField * (^attributedTxt)(NSAttributedString *aTxt);
@property (strong, nonatomic, readonly) JZTextField * (^pHolder)(NSString *text);
@property (strong, nonatomic, readonly) JZTextField * (^attributedPHolder)(NSAttributedString *aTxt);
// font
@property (strong, nonatomic, readonly) JZTextField * (^fntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextField * (^mFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextField * (^bFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextField * (^fontAdjusts)(BOOL adjusts);
@property (strong, nonatomic, readonly) JZTextField * (^minFntSize)(CGFloat size);
@property (strong, nonatomic, readonly) JZTextField * (^fnt)(UIFont *font);

// color
@property (strong, nonatomic, readonly) JZTextField * (^txtColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZTextField * (^bColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZTextField * (^txtColor)(UIColor *color);
@property (strong, nonatomic, readonly) JZTextField * (^bColor)(UIColor *color);

// layout
@property (strong, nonatomic, readonly) JZTextField * (^align)(NSTextAlignment align);
@property (strong, nonatomic, readonly) JZTextField * (^style)(UITextBorderStyle borderStyle);
@property (strong, nonatomic, readonly) JZTextField * (^keyBoard)(UIKeyboardType keyboardType);
@property (strong, nonatomic, readonly) JZTextField * (^returnType)(UIReturnKeyType returnKeyType);
@property (strong, nonatomic, readonly) JZTextField * (^clearOnBegin)(BOOL clear);
@property (strong, nonatomic, readonly) JZTextField * (^clearMode)(UITextFieldViewMode mode);
@property (strong, nonatomic, readonly) JZTextField * (^allowsEditTxtAttrs)(BOOL allow);
@property (strong, nonatomic, readonly) JZTextField * (^typingAttrs)(NSDictionary<NSAttributedStringKey, id> *typingAttributes);
// action
@property (strong, nonatomic, readonly) JZTextField * (^action)(id target, SEL action, UIControlEvents event);

+ (JZTextField *)textField;

@end

NS_ASSUME_NONNULL_END
