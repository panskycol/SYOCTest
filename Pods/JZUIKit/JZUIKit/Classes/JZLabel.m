//
//  JZLabel.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import "JZLabel.h"
#import "JZUIMarco.h"
#import "JZFont.h"
#import "JZColor.h"

@implementation JZLabel

+ (JZLabel *)label {
    JZLabel *label = [[JZLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = JZDefaultTextColor;
    return label;
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

- (JZLabel * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZLabel * (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h){
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZLabel * (^)(NSString *text))txt {
    return ^id(NSString *text){
        self.text = text;
        return self;
    };
}

- (JZLabel * _Nonnull (^)(NSAttributedString * _Nonnull))attributedTxt {
    return ^id(NSAttributedString *aTxt) {
        self.attributedText = aTxt;
        return self;
    };
}

- (JZLabel * (^)(CGFloat))fntSize {
    return ^id(CGFloat size){
        self.font = [JZFont systemFontOfSize:size];
        return self;
    };
}

- (JZLabel * (^)(CGFloat))mFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont mediumFont:size];
        return self;
    };
}

- (JZLabel * (^)(CGFloat))bFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont boldFont:size];
        return self;
    };
}

- (JZLabel * _Nonnull (^)(UIFont * _Nonnull))fnt {
    return ^id(UIFont *font){
        self.font = font;
        return self;
    };
}

- (JZLabel * (^)(NSString *,CGFloat))txtColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.textColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZLabel * (^)(NSString *hexString,CGFloat alpha))bColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.backgroundColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZLabel * _Nonnull (^)(UIColor * _Nonnull))txtColor {
    return ^id(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

- (JZLabel * _Nonnull (^)(UIColor * _Nonnull))bColor {
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (JZLabel * _Nonnull (^)(NSTextAlignment))align {
    return ^id(NSTextAlignment align){
        self.textAlignment = align;
        return self;
    };
}

- (JZLabel * _Nonnull (^)(NSInteger))lines {
    return ^id(NSInteger lines){
        self.numberOfLines = lines;
        return self;
    };
}

@end
