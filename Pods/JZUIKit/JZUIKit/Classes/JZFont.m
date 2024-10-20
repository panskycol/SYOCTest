//
//  JZFont.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import "JZFont.h"

@implementation JZFont

+ (UIFont *)mediumFont:(CGFloat)size {
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)boldFont:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size];
}

@end
