//
//  SYToolManager.h
//  SYTest
//
//  Created by Pan skycol on 2024/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYToolManager : NSObject

+ (NSDictionary *)convertToStringsInDictionary:(NSDictionary *)originalDict;


+ (id)getDictOrArrByJsonStr:(NSString *)jsonStr;

@end

NS_ASSUME_NONNULL_END
