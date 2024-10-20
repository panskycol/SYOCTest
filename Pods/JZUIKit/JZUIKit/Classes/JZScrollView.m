//
//  JZScrollView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import "JZScrollView.h"

@implementation JZScrollView

+ (JZScrollView *)scrollView {
    JZScrollView *scrollView = [[JZScrollView alloc] initWithFrame:CGRectZero];
    return scrollView;
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

- (JZScrollView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(id<UIScrollViewDelegate> _Nonnull))delegateTarget {
    return ^id(id<UIScrollViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat, CGFloat))cOffset {
    return ^id(CGFloat x, CGFloat y) {
        self.contentOffset = CGPointMake(x, y);
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat, CGFloat))cSize {
    return ^id(CGFloat w, CGFloat h) {
        self.contentSize = CGSizeMake(w, h);
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))cInset {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.contentInset = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))directLock {
    return ^id(BOOL enabled) {
        self.directionalLockEnabled = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))bouncesEnabled {
    return ^id(BOOL enabled) {
        self.bounces = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))bounceV {
    return ^id(BOOL enabled) {
        self.alwaysBounceVertical = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))bounceH {
    return ^id(BOOL enabled) {
        self.alwaysBounceHorizontal = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))showHIndicator {
    return ^id(BOOL show) {
        self.showsHorizontalScrollIndicator = show;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))showVIndicator {
    return ^id(BOOL show) {
        self.showsVerticalScrollIndicator = show;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))delayTouches {
    return ^id(BOOL delay) {
        self.delaysContentTouches = delay;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))canCancelTouches {
    return ^id(BOOL enabled) {
        self.canCancelContentTouches = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat))minScale {
    return ^id(CGFloat scale) {
        self.minimumZoomScale = scale;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat))maxScale {
    return ^id(CGFloat scale) {
        self.maximumZoomScale = scale;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(CGFloat))zScale {
    return ^id(CGFloat scale) {
        self.zoomScale = scale;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))scrollTop {
    return ^id(BOOL enabled) {
        self.scrollsToTop = enabled;
        return self;
    };
}

- (JZScrollView * _Nonnull (^)(BOOL))scrollPage {
    return ^id(BOOL enabled) {
        self.pagingEnabled = enabled;
        return self;
    };
}


@end
