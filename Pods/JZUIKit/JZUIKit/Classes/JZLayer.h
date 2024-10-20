//
//  JZLayer.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ALGradientType) {
    ALGradientTypeLeftToRight,              //左到右渐变
    ALGradientTypeTopToBottom,              //上到下渐变
    ALGradientTypeLeftTopToRightBottom,     //左上到右下渐变
    ALGradientTypeLeftBottomToRightTop,     //左下到右上渐变
};

typedef struct {
    CGFloat topLeft;
    CGFloat topRight;
    CGFloat bottomLeft;
    CGFloat bottomRight;
}CornerRadius;

@interface JZLayer : NSObject

@property (weak, nonatomic) UIView *view;
@property (strong, nonatomic, readonly) JZLayer * (^border)(void);
@property (strong, nonatomic, readonly) JZLayer * (^borderWidth)(CGFloat width);
@property (strong, nonatomic, readonly) JZLayer * (^colorBorderHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZLayer * (^colorBorder)(UIColor *color);

@property (strong, nonatomic, readonly) JZLayer * (^corner)(CGFloat radius);
@property (strong, nonatomic, readonly) JZLayer * (^topCorner)(CGFloat radius);
@property (strong, nonatomic, readonly) JZLayer * (^bottomCorner)(CGFloat radius);
@property (strong, nonatomic, readonly) JZLayer * (^leftCorner)(CGFloat radius);
@property (strong, nonatomic, readonly) JZLayer * (^rightCorner)(CGFloat radius);
@property (strong, nonatomic, readonly) JZLayer * (^customCorner)(CornerRadius cornerRadius);
@property (strong, nonatomic, readonly) JZLayer * (^gradient)(NSString *start,CGFloat sAlpha,NSString *end,CGFloat eAlpha,ALGradientType type);
@property (strong, nonatomic, readonly) JZLayer * (^gradientBorder)(UIColor *startColor,UIColor *endColor,CGFloat radius,CGFloat width);

@end


NS_ASSUME_NONNULL_END
