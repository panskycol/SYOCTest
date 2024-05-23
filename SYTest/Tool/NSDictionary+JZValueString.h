//
//  NSDictionary+JZValueString.h
//  JinZuan
//
//  Created by Pan skycol on 2024/5/22.
//
//  把字典内所有的value值都改为字符串类型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JZValueString)

/// 把字典内所有的value值都改为字符串类型
+ (NSDictionary *)convertToStringsInDictionary:(NSDictionary *)originalDict;
/// 把字典内所有的value值都改为字符串类型
- (NSDictionary *)safeStringsDictionary;

@end

NS_ASSUME_NONNULL_END
