//
//  JZImageView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import "JZImageView.h"

@implementation JZImageView

+ (JZImageView *)imageView {
    return [[JZImageView alloc] init];
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

- (JZImageView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZImageView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZImageView * _Nonnull (^)(NSString * _Nonnull))img {
    return ^id(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}

- (JZImageView * _Nonnull (^)(NSArray<NSString *> * _Nonnull))animImgs {
    return ^id(NSArray<NSString *> *imageNames) {
        NSMutableArray *images = [NSMutableArray array];
        [imageNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *image = [UIImage imageNamed:obj];
            if (image) {
                [images addObject:image];
            }
        }];
        self.animationImages = images;
        return self;
    };
}

- (JZImageView * _Nonnull (^)(NSString * _Nonnull, NSInteger))formatAnimImgs {
    return ^id(NSString *prefix, NSInteger count) {
        NSMutableArray *images = [NSMutableArray array];
        for (NSInteger i = 0; i < count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%zd",prefix,i];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) {
                [images addObject:image];
            }
        }
        self.animationImages = images;
        return self;
    };
}

- (JZImageView * _Nonnull (^)(NSTimeInterval))duration {
    return ^id(NSTimeInterval interval) {
        self.animationDuration = interval;
        return self;
    };
}

- (JZImageView * _Nonnull (^)(NSInteger))rCount {
    return ^id(NSInteger count) {
        self.animationRepeatCount = count;
        return self;
    };
}

- (JZImageView * _Nonnull (^)(void))start {
    return ^id(void) {
        [self startAnimating];
        return self;
    };
}

- (JZImageView * _Nonnull (^)(void))stop {
    return ^id() {
        [self stopAnimating];
        return self;
    };
}

@end
