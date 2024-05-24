//
//  NSDictionary+JZValueString.m
//  JinZuan
//
//  Created by Pan skycol on 2024/5/22.
//

#import "NSDictionary+JZValueString.h"

@implementation NSDictionary (JZValueString)

+ (NSDictionary *)convertToStringsInDictionary:(NSDictionary *)originalDict{

    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    [originalDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            // 递归转换嵌套的字典
            mutableDict[key] = [self convertToStringsInDictionary:(NSDictionary *)obj];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            // 转换数组中的元素
            NSArray *originalArray = (NSArray *)obj;
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:originalArray.count];
            [originalArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [mutableArray addObject:[self convertToStringsInDictionary:(NSDictionary *)obj]];
                } else {
                    [mutableArray addObject:[NSString stringWithFormat:@"%@", obj]];
                }
            }];
            mutableDict[key] = [mutableArray copy];
        } else {
            mutableDict[key] = [NSString stringWithFormat:@"%@", obj];
        }
    }];
    
    return [mutableDict copy];
}


- (NSDictionary *)safeStringsDictionary{
    
    return [NSDictionary convertToStringsInDictionary:self];
}

@end
