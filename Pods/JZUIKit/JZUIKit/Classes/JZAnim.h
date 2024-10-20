//
//  JZAnim.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/10/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JZAnimRotation) {
    JZAnimRotationUpDown,
    JZAnimRotationLeftRight,
};

@interface JZAnim : NSObject

@property (weak, nonatomic) UIView *view; 
// 呼吸效果
@property (strong, nonatomic, readonly) JZAnim * (^blink)(void);
// 位移
@property (strong, nonatomic, readonly) JZAnim * (^move)(CGPoint fromPosition, CGPoint endPosition);
// 旋转
@property (strong, nonatomic, readonly) JZAnim * (^rotation)(JZAnimRotation rotationType);
// 缩放
@property (strong, nonatomic, readonly) JZAnim * (^scale)(CGFloat fromScale, CGFloat toScale);
// 抖动
@property (strong, nonatomic, readonly) JZAnim * (^shake)(void);

@end

NS_ASSUME_NONNULL_END
