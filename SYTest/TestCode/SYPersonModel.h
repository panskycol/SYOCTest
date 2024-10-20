//
//  SYPersonModel.h
//  SYTest
//
//  Created by Pan skycol on 2024/7/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYPersonModel : NSObject

@property (nonatomic, assign) int age;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, copy) void(^testCycleBlock)(void);

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
