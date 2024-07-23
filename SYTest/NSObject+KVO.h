//
//  NSObject+KVO.h
//  SYTest
//
//  Created by Pan skycol on 2024/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface __NSObjectKVO : NSObject

@property (nonatomic, unsafe_unretained, nullable) id target;
@property (nonatomic, unsafe_unretained, nullable) id observer;
@property (nonatomic, copy, nullable) NSString *keyPath;

@end

@interface NSObject (KVO)

@property (nonatomic, strong) __NSObjectKVO *kvoInfo;

/// 添加观察者, 无需移除 (将会自动移除)
- (void)sj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
