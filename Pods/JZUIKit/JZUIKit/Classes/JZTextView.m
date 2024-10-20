//
//  JZTextView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import "JZTextView.h"
#import "JZUIMarco.h"
#import "JZFont.h"
#import "JZColor.h"
#import "JZLabel.h"
#import <Masonry/Masonry.h>

#define placeHolderColor (@"B2B2B2")
#define placeHolderFontSize (self.font.pointSize>0?:12.0)

@interface JZTextView ()

@property (strong, nonatomic) JZLabel *placeHolderLb;

@end

@implementation JZTextView

+ (JZTextView *)textView {
    JZTextView *textView = [[JZTextView alloc] init];
    return textView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self makePlaceHolderLabel];
    }
    return self;
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

- (JZTextView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZTextView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZTextView * _Nonnull (^)(id<UITextViewDelegate> _Nonnull))delegateTarget {
    return ^id(id<UITextViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(NSString * _Nonnull))txt {
    return ^id(NSString *text) {
        self.text = text;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(NSAttributedString * _Nonnull))attributedTxt {
    return ^id(NSAttributedString *aTxt) {
        self.attributedText = aTxt;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(NSString * _Nonnull))pHolder {
    return ^id(NSString *placeholder) {
        self.placeHolderLb.txt(placeholder);
        return self;
    };
}

- (JZTextView * _Nonnull (^)(NSAttributedString * _Nonnull))attributedPHolder {
    return ^id(NSAttributedString *aPHolder) {
        self.placeHolderLb.attributedTxt(aPHolder);
        return self;
    };
}

- (JZTextView * (^)(CGFloat))fntSize {
    return ^id(CGFloat size){
        self.font = [JZFont systemFontOfSize:size];
        self.placeHolderLb.fntSize(size);
        return self;
    };
}

- (JZTextView * (^)(CGFloat))mFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont mediumFont:size];
        self.placeHolderLb.fntSize(size);
        return self;
    };
}

- (JZTextView * (^)(CGFloat))bFntSize {
    return ^id(CGFloat size){
        self.font = [JZFont boldFont:size];
        self.placeHolderLb.fntSize(size);
        return self;
    };
}

- (JZTextView * _Nonnull (^)(UIFont * _Nonnull))fnt {
    return ^id(UIFont *font){
        self.font = font;
        self.placeHolderLb.fnt(font);
        return self;
    };

}

- (JZTextView * (^)(NSString *,CGFloat))txtColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.textColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZTextView * (^)(NSString *hexString,CGFloat alpha))bColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.backgroundColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZTextView * _Nonnull (^)(UIColor * _Nonnull))txtColor {
    return ^id(UIColor *color){
        self.textColor = color;
        return self;
    };

}

- (JZTextView * _Nonnull (^)(UIColor * _Nonnull))bColor {
    return ^id(UIColor *color){
        self.backgroundColor = color;
        return self;
    };

}

- (JZTextView * _Nonnull (^)(NSTextAlignment))align {
    return ^id(NSTextAlignment align){
        self.placeHolderLb.align(align);
        self.textAlignment = align;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(BOOL))editAble {
    return ^id(BOOL editable) {
        self.editable = editable;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(BOOL))selectAble {
    return ^id(BOOL selectable) {
        self.selectable = selectable;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(UIDataDetectorTypes))detectorTypes {
    return ^id(UIDataDetectorTypes types) {
        self.dataDetectorTypes = types;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(BOOL))allowsEditTxtAttrs {
    return ^id(BOOL allow) {
        self.allowsEditingTextAttributes = allow;
        return self;
    };
}

- (JZTextView * _Nonnull (^)(NSDictionary<NSAttributedStringKey,id> * _Nonnull))typingAttrs {
    return ^id(NSDictionary<NSAttributedStringKey,id> *typingAttributes) {
        self.typingAttributes = typingAttributes;
        return self;
    };
}

- (void)makePlaceHolderLabel {
    if (self.placeHolderLb == nil) {
        JZLabel *placeHolderLb = JZLabel.label;
        placeHolderLb.txtColorHex(placeHolderColor, 1)
        .fntSize(placeHolderFontSize)
        .align(NSTextAlignmentLeft)
        .lines(0);
        self.placeHolderLb = placeHolderLb;
        [self insertSubview:self.placeHolderLb atIndex:0];
        NSNumber *width = [NSNumber numberWithFloat:(self.frame.size.width - 10)];
        [self.placeHolderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.left.equalTo(self).offset(5);
            make.width.equalTo(width);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceholderLabel)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }
}

- (void)updatePlaceholderLabel {
    if (self.text.length) {
        [self.placeHolderLb removeFromSuperview];
    } else {
        [self insertSubview:self.placeHolderLb atIndex:0];
        NSNumber *width = [NSNumber numberWithFloat:(self.frame.size.width - 10)];
        [self.placeHolderLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.left.equalTo(self).offset(5);
            make.width.equalTo(width);
        }];
    }
}

@end
