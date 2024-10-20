//
//  JZButton.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import "JZButton.h"
#import "JZColor.h"
#import "JZFont.h"
#import "JZUIMarco.h"

#define JZButton_GridentColor_Left JZRGBA(186, 70, 255, 1)
#define JZButton_GridentColor_Right JZRGBA(114, 23, 255, 1)
#define JZButton_GridentColors [NSArray arrayWithObjects:(id)JZButton_GridentColor_Left.CGColor, (id)JZButton_GridentColor_Right.CGColor, nil];

@interface JZButton ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *highLightColors;
@property (nonatomic, strong) CAGradientLayer *gradientlayer;
@property (nonatomic, assign) NSTimeInterval responseInterval;
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation JZButton 

+ (JZButton *)button {
    return [JZButton buttonWithType:UIButtonTypeCustom];
}

+ (JZButton *)gridentBtnInFrame:(CGRect)frame {
    JZButton *button = [JZButton buttonWithType:UIButtonTypeCustom];
    NSArray *colors = [NSArray arrayWithObjects:(id)JZButton_GridentColor_Left.CGColor, (id)JZButton_GridentColor_Right.CGColor, nil];
    button.frame = frame;
    button.colors = colors;
    button.highLightColors = colors;
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.colors.count > 0) {
        self.gradient(self.colors, self.highLightColors, self.frame.size.height/2);
    }
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

- (JZAnim *)anim {
    if (!_anim) {
        _anim = [[JZAnim alloc] init];
        _anim.view = self;
    }
    return _anim;
}

- (JZAnim *)imageAnim {
    if (!_anim) {
        _anim = [[JZAnim alloc] init];
        _anim.view = self.imageView;
    }
    return _anim;
}

- (JZButton * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))title {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))hTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateHighlighted];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))sTitle {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateSelected];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSAttributedString * _Nonnull))attributedTitle {
    return ^id(NSAttributedString *aTitle) {
        self.titleLabel.attributedText = aTitle;
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))titleInset {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.titleEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}

- (JZButton * _Nonnull (^)(UIControlContentHorizontalAlignment))contentAlign {
    return ^id(UIControlContentHorizontalAlignment align) {
        self.contentHorizontalAlignment = align;
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))img {
    return ^id(NSString *imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))hImg {
    return ^id(NSString *imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))sImg {
    return ^id(NSString *imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull))bgImg {
    return ^id(NSString *imageName) {
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))imgInset {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}

- (JZButton * _Nonnull (^)(JZButtonContentLayoutStyle, CGFloat))contentLayout {
    return ^id(JZButtonContentLayoutStyle style, CGFloat space) {
        // 仅支持居中模式下的调整 ==> UIControlContentHorizontalAlignmentCenter
        CGFloat imageWith = self.imageView.image.size.width;
        CGFloat imageHeight = self.imageView.image.size.height;
        CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
        CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
        switch (style) {
            case JZButtonContentLayoutStyleTop:
            {
                imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
                break;
            }
            case JZButtonContentLayoutStyleLeft:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
                break;
            }
            case JZButtonContentLayoutStyleBottom:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
                break;
            }
            case JZButtonContentLayoutStyleRight:
            {
                imageEdgeInsets = UIEdgeInsetsMake(0, (labelWidth+space/2.0), 0, -(labelWidth+space/2.0));
                labelEdgeInsets = UIEdgeInsetsMake(0, -(imageWith+space/2.0), 0, (imageWith+space/2.0));
                break;
            }
            default:
                break;
        }
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull, CGFloat))bColorHex {
    return ^id(NSString *hexString,CGFloat alpha) {
        JZColor *color = [JZColor alColorWithHexString:hexString alpha:alpha];
        self.backgroundColor = color;
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSString * _Nonnull, CGFloat,UIControlState))txtColorHex {
    return ^id(NSString *hexString, CGFloat alpha,UIControlState state) {
        JZColor *color = [JZColor alColorWithHexString:hexString alpha:alpha];
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (JZButton * _Nonnull (^)(UIColor * _Nonnull))bColor {
    return ^id(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };

}

- (JZButton * _Nonnull (^)(UIColor * _Nonnull, UIControlState))txtColor {
    return ^id(UIColor *color,UIControlState state) {
        [self setTitleColor:color forState:state];
        return self;
    };

}

- (JZButton * _Nonnull (^)(CGFloat))fntSize {
    return ^id(CGFloat size) {
        self.titleLabel.font = [JZFont systemFontOfSize:size];
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat))mFntSize {
    return ^id(CGFloat size) {
        self.titleLabel.font = [JZFont mediumFont:size];
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat))bFntSize {
    return ^id(CGFloat size) {
        self.titleLabel.font = [JZFont boldFont:size];
        return self;
    };
}

- (JZButton * _Nonnull (^)(UIFont * _Nonnull))fnt {
    return ^id(UIFont *font) {
        self.titleLabel.font = font;
        return self;
    };

}

- (JZButton * _Nonnull (^)(NSArray * _Nonnull, NSArray * _Nonnull, CGFloat))gradient {
    return ^id(NSArray *colors, NSArray *hColors, CGFloat cornerRadius) {
        self.colors = colors;
        self.highLightColors = hColors;
        if (colors.count > 1) {
            [self.gradientlayer removeFromSuperlayer];
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = self.bounds;
            [gradientLayer setColors:colors];
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1,0);
            gradientLayer.locations = @[@0.3, @1.0];
            [self.layer insertSublayer:gradientLayer atIndex:0];
            self.gradientlayer = gradientLayer;
        } else {
            self.backgroundColor = colors.firstObject;
        }
        self.layerMgr.corner(cornerRadius);
        return self;
    };
}

- (JZButton * _Nonnull (^)(UIView * _Nonnull, CGFloat))shadow {
    return ^id(UIView *containerView, CGFloat cornerRadius) {
        CALayer *shadowLayer = [CALayer layer];
        shadowLayer.frame = CGRectMake(FX(self)+3, FY(self), FW(self)-6, FH(self));
        shadowLayer.cornerRadius = cornerRadius;
        shadowLayer.backgroundColor = [UIColor blackColor].CGColor;
        shadowLayer.shadowOpacity = 0.5;
        shadowLayer.shadowRadius = cornerRadius;
        shadowLayer.shadowColor = JZGlobalColor.CGColor;
        shadowLayer.shadowOffset = CGSizeMake(0, 4);
        [containerView.layer insertSublayer:shadowLayer atIndex:0];
        return self;
    };
}

- (JZButton * _Nonnull (^)(CGFloat))corner {
    return ^id(CGFloat cornerRadius) {
        self.layerMgr.corner(cornerRadius);
        return self;
    };
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        if (self.highLightColors.count > 1) {
            [self.gradientlayer setColors:self.highLightColors];
        }
    }else{
        if (self.colors.count > 1) {
            [self.gradientlayer setColors:self.colors];
        }
    }
}

- (JZButton * _Nonnull (^)(id _Nonnull, SEL _Nonnull))action {
    return ^id(id target, SEL action) {
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        return self;
    };
}

- (JZButton * _Nonnull (^)(NSTimeInterval))resInterval {
    return ^id(NSTimeInterval interval) {
        self.responseInterval = interval;
        return self;
    };
}

#pragma mark - override

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.responseInterval <= 0) {
        [super sendAction:action to:target forEvent:event];
        return;
    }
    
    if (self.isIgnoreEvent) {
        return;
    }
    
    [super sendAction:action to:target forEvent:event];
    
    self.isIgnoreEvent = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.responseInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isIgnoreEvent = NO;
    });
}

@end
