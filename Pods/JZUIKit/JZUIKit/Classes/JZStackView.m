//
//  JZStackView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/10/12.
//

#import "JZStackView.h"

@implementation JZStackView

- (JZLayout *)layout {
    if (!_layout) {
        _layout = [[JZLayout alloc] init];
        _layout.view = self;
    }
    return _layout; 
}

- (JZStackView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZStackView * _Nonnull (^)(UILayoutConstraintAxis))direction {
    return ^id(UILayoutConstraintAxis axis) {
        self.axis = axis;
        return self;
    };
}

- (JZStackView * _Nonnull (^)(UIStackViewDistribution))dist {
    return ^id(UIStackViewDistribution dist) {
        self.distribution = dist;
        return self;
    };
}

- (JZStackView * _Nonnull (^)(UIStackViewAlignment))align {
    return ^id(UIStackViewAlignment align) {
        self.alignment = align;
        return self;
    };
}

- (JZStackView * _Nonnull (^)(CGFloat))space {
    return ^id(CGFloat spacing) {
        self.spacing = spacing;
        return self;
    };
}

- (JZStackView * _Nonnull (^)(NSArray<UIView *> * _Nonnull))arrageViews {
    return ^id(NSArray<UIView *> *views) {
        [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addArrangedSubview:obj];
        }];
        return self;
    };
}

+ (JZStackView *)stackView {
    JZStackView *stackView = [[JZStackView alloc] init];
    return stackView;
}

+ (JZStackView *)equalSpacingStackViewH {
    JZStackView *stackView = [[JZStackView alloc] init];
    stackView.direction(UILayoutConstraintAxisHorizontal)
    .dist(UIStackViewDistributionEqualSpacing)
    .align(UIStackViewAlignmentCenter);
    return stackView;
}

+ (JZStackView *)equalSpacingStackViewV {
    JZStackView *stackView = [[JZStackView alloc] init];
    stackView.direction(UILayoutConstraintAxisVertical)
    .dist(UIStackViewDistributionEqualSpacing)
    .align(UIStackViewAlignmentCenter);
    return stackView;
}

+ (JZStackView *)fillEquallyStackViewH {
    JZStackView *stackView = [[JZStackView alloc] init];
    stackView.direction(UILayoutConstraintAxisHorizontal)
    .dist(UIStackViewDistributionFillEqually)
    .align(UIStackViewAlignmentCenter);
    return stackView;
}

+ (JZStackView *)fillEquallyStackViewV {
    JZStackView *stackView = [[JZStackView alloc] init];
    stackView.direction(UILayoutConstraintAxisVertical)
    .dist(UIStackViewDistributionFillEqually)
    .align(UIStackViewAlignmentCenter);
    return stackView;
}

@end
 
