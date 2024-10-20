//
//  JZView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/30.
//

#import "JZView.h"
#import "JZColor.h"

@implementation JZView

+ (JZView *)view {
    JZView *view = [[JZView alloc] init];
    return view;
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

- (JZView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZView * (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h){
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZView * (^)(NSString *hexString,CGFloat alpha))bColorHex {
    return ^id(NSString *hexColor, CGFloat alpha){
        self.backgroundColor = [JZColor alColorWithHexString:hexColor alpha:alpha];
        return self;
    };
}

- (JZView * _Nonnull (^)(UIColor * _Nonnull))bColor {
    return ^id(UIColor *color){
        self.backgroundColor = color;
        return self;
    };

}

@end
