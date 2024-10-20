//
//  JZFont.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZFont : UIFont

/// 中号字体
/// @param size 字体尺寸
+ (UIFont *)mediumFont:(CGFloat)size;

/// 粗体
/// @param size 字体尺寸
+ (UIFont *)boldFont:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
