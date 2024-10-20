//
//  JZLayer.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/22.
//

#import "JZLayer.h"
#import "JZUIMarco.h"
#import "JZColor.h"
#import "JZFont.h"

@implementation JZLayer

- (JZLayer * _Nonnull (^)(void))border {
    return ^id(void) {
        [self.view.layer setBorderWidth:0.5];
        [self.view.layer setBorderColor:JZGlobalBorderColor.CGColor];
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))borderWidth {
    return ^id(CGFloat width) {
        [self.view.layer setBorderWidth:width];
        return self;
    };
}

- (JZLayer * _Nonnull (^)(NSString * _Nonnull, CGFloat))colorBorderHex {
    return ^id(NSString *hexString,CGFloat alpha) {
        JZColor *color = [JZColor alColorWithHexString:hexString alpha:alpha];
        [self.view.layer setBorderWidth:0.5];
        [self.view.layer setBorderColor:color.CGColor]; 
        return self;
    };
}

- (JZLayer * _Nonnull (^)(UIColor * _Nonnull))colorBorder {
    return ^id(UIColor *color) {
        [self.view.layer setBorderWidth:0.5];
        [self.view.layer setBorderColor:color.CGColor];
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))corner {
    return ^id(CGFloat radius) {
        self.view.layer.cornerRadius = radius;
        self.view.layer.masksToBounds = YES;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))topCorner {
    return ^id(CGFloat radius) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        self.view.layer.mask = maskLayer;
        self.view.layer.masksToBounds = YES;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))bottomCorner {
    return ^id(CGFloat radius) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        self.view.layer.mask = maskLayer;
        self.view.layer.masksToBounds = YES;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))leftCorner {
    return ^id(CGFloat radius) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        self.view.layer.mask = maskLayer;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CGFloat))rightCorner {
    return ^id(CGFloat radius) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        self.view.layer.mask = maskLayer;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(CornerRadius))customCorner {
    return ^id(CornerRadius cornerRadius) {
        CGFloat minX = self.view.layer.bounds.origin.x;
        CGFloat minY = self.view.layer.bounds.origin.y;
        CGFloat maxX = self.view.layer.bounds.size.width;
        CGFloat maxY = self.view.layer.bounds.size.height;
        
        CGFloat topLeftCenterX = minX +  cornerRadius.topLeft;
        CGFloat topLeftCenterY = minY + cornerRadius.topLeft;
        
        CGFloat topRightCenterX = maxX - cornerRadius.topRight;
        CGFloat topRightCenterY = minY + cornerRadius.topRight;
        
        CGFloat bottomLeftCenterX = minX +  cornerRadius.bottomLeft;
        CGFloat bottomLeftCenterY = maxY - cornerRadius.bottomLeft;
        
        CGFloat bottomRightCenterX = maxX -  cornerRadius.bottomRight;
        CGFloat bottomRightCenterY = maxY - cornerRadius.bottomRight;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(topLeftCenterX, topLeftCenterY) radius:cornerRadius.topLeft startAngle:M_PI endAngle:3*M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(topRightCenterX, topRightCenterY) radius:cornerRadius.topRight startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(bottomRightCenterX, bottomRightCenterY) radius:cornerRadius.bottomRight startAngle:0 endAngle:M_PI/2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(bottomLeftCenterX, bottomLeftCenterY) radius:cornerRadius.bottomLeft startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        self.view.layer.mask = maskLayer;
        return self;
    };
}

- (JZLayer * _Nonnull (^)(NSString * _Nonnull, CGFloat, NSString * _Nonnull, CGFloat, ALGradientType))gradient {
    return ^id(NSString *start,CGFloat sAlpha,NSString *end,CGFloat eAlpha,ALGradientType type) {
        JZColor *startColor = [JZColor alColorWithHexString:start alpha:sAlpha];
        JZColor *endColor = [JZColor alColorWithHexString:end alpha:eAlpha];
        CGRect rect = self.view.bounds;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        switch (type) {
            case ALGradientTypeLeftToRight: {
                gradientLayer.startPoint = CGPointMake(0, 0);
                gradientLayer.endPoint = CGPointMake(1, 0);
                break;
            }
            case ALGradientTypeTopToBottom: {
                gradientLayer.startPoint = CGPointMake(0, 0);
                gradientLayer.endPoint = CGPointMake(0, 1);
                break;
            }
            case ALGradientTypeLeftTopToRightBottom: {
                gradientLayer.startPoint = CGPointMake(0, 0);
                gradientLayer.endPoint = CGPointMake(1, 1);
                break;
            }
            case ALGradientTypeLeftBottomToRightTop: {
                gradientLayer.startPoint = CGPointMake(0, 1);
                gradientLayer.endPoint = CGPointMake(1, 0);
                break;
            }
            default:
                break;
        }
        gradientLayer.frame = rect;
        [self.view.layer insertSublayer:gradientLayer atIndex:0];
        return self;
    };
}

- (JZLayer * _Nonnull (^)(UIColor * _Nonnull, UIColor * _Nonnull, CGFloat, CGFloat))gradientBorder {
    return ^id(UIColor *startColor,UIColor *endColor,CGFloat radius,CGFloat width) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.view.bounds;
        gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.lineWidth = width;
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds cornerRadius:8].CGPath;
        maskLayer.fillColor = [UIColor clearColor].CGColor;
        maskLayer.strokeColor = [UIColor blackColor].CGColor;
        gradientLayer.mask = maskLayer;
        [self.view.layer addSublayer:gradientLayer];
        return self;
    };
}

@end
