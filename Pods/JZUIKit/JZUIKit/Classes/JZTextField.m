//
//  JZTextField.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import "JZTextField.h"
#import "JZUIMarco.h"
#import "JZFont.h"
#import "JZColor.h"

@implementation JZTextField

+ (JZTextField *)textField {
    JZTextField *textField = [[JZTextField alloc] init];
    return textField;
}

- (JZLayout *)layout {
    if (!_layout) {
        _layout = [[JZLayout alloc] init];
        _layout.view = self;
    }
    return _layout;
}

- (JZLayer *)layerMgr {
    if (!_layerMgr) {
        _layerMgr = [[JZLayer alloc] init];
        _layerMgr.view = self;
    }
    return _layerMgr;
}

- (JZTextField * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZTextField * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZTextField * _Nonnull (^)(id<UITextFieldDelegate> _Nonnull))delegateTarget {
    return ^id(id<UITextFieldDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(NSString * _Nonnull))txt {
    return ^id(NSString *text) {
        self.text = text;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(NSAttributedString * _Nonnull))attributedTxt {
    return ^id(NSAttributedString *aTxt) {
        self.attributedText = aTxt;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(NSString * _Nonnull))pHolder {
    return ^id(NSString *placeHolder) {
        self.placeholder = placeHolder;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(NSAttributedString * _Nonnull))attributedPHolder {
    return ^id(NSAttributedString *aPlaceHolder) {
        self.attributedPlaceholder = aPlaceHolder;
        return self;
    };
}

- (JZTextField * (^)(CGFloat))fntSize {
    return ^id(CGFloat size){
        self.font = [JZFont systemFontOfSize:size];
        return self;
    };
}

- (JZTextField * (^)(CGFloat))mFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont mediumFont:size];
        return self;
    };
}

- (JZTextField * (^)(CGFloat))bFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont boldFont:size];
        return self;
    };
}

- (JZTextField * _Nonnull (^)(BOOL))fontAdjusts {
    return ^id(BOOL adjusts) {
        self.adjustsFontSizeToFitWidth = adjusts;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(CGFloat))minFntSize {
    return ^id(CGFloat size) {
        self.minimumFontSize = size;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UIFont * _Nonnull))fnt {
    return ^id(UIFont *font){
        self.font = font;
        return self;
    };

}

- (JZTextField * (^)(NSString *,CGFloat))txtColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.textColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZTextField * (^)(NSString *hexString,CGFloat alpha))bColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.backgroundColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UIColor * _Nonnull))txtColor {
    return ^id(UIColor *color){
        self.textColor = color;
        return self;
    };

}

- (JZTextField * _Nonnull (^)(UIColor * _Nonnull))bColor {
    return ^id(UIColor *color){
        self.backgroundColor = color;
        return self;
    };

}

- (JZTextField * _Nonnull (^)(NSTextAlignment))align {
    return ^id(NSTextAlignment align){
        self.textAlignment = align;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UITextBorderStyle))style {
    return ^id(UITextBorderStyle style) {
        self.borderStyle = style;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UIKeyboardType))keyBoard {
    return ^id(UIKeyboardType type) {
        self.keyboardType = type;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UIReturnKeyType))returnType {
    return ^id(UIReturnKeyType type) {
        self.returnKeyType = type;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(BOOL))clearOnBegin {
    return ^id(BOOL flag) {
        self.clearsOnBeginEditing = flag;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(UITextFieldViewMode))clearMode {
    return ^id(UITextFieldViewMode mode) {
        self.clearButtonMode = mode;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(BOOL))allowsEditTxtAttrs {
    return ^id(BOOL allow) {
        self.allowsEditingTextAttributes = allow;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(NSDictionary<NSAttributedStringKey,id> * _Nonnull))typingAttrs {
    return ^id(NSDictionary<NSAttributedStringKey,id> *typingAttributes) {
        self.typingAttributes = typingAttributes;
        return self;
    };
}

- (JZTextField * _Nonnull (^)(id _Nonnull, SEL _Nonnull, UIControlEvents))action {
    return ^id(id target, SEL action, UIControlEvents event) {
        [self addTarget:target action:action forControlEvents:event];
        return self;
    };
}

@end
