//
//  JZColor.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZColor : UIColor 

+ (JZColor *)alColorWithHexString:(NSString *)color;
+ (JZColor *)alColorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
