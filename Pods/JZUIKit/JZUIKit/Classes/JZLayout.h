//
//  JZLayout.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 margin:当前视图与父视图之间的约束
 top/left/bottom/right 平级视图之间的约束
 eg:
——————————————————————————————————————————————————————
|             |                                     |
|           margin                                  |
|             |                                     |
|             —                        —            |
|--margin---| A |---A.right/B.left---| B |--margin--|
|             —                        —            |
|             |                                     |
|             |                                     |
|         A.bottom/C.top                            |
|             |                                     |
|             |                                     |
|             —                                     |
|           | C |                                   |
|             —                                     |
|             |                                     |
|           margin                                  |
|             |                                     |
——————————————————————————————————————————————————————
*/

@interface JZLayout : NSObject

@property (weak, nonatomic) UIView *view;

// 与父视图之间的约束
@property (strong, nonatomic, readonly) JZLayout * (^margin)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property (strong, nonatomic, readonly) JZLayout * (^marginT)(CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^marginL)(CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^marginB)(CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^marginR)(CGFloat value);
// 平级视图之间的约束
@property (strong, nonatomic, readonly) JZLayout * (^top)(UIView *view, CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^left)(UIView *view, CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^bottom)(UIView *view, CGFloat value);
@property (strong, nonatomic, readonly) JZLayout * (^right)(UIView *view, CGFloat value);
// 自身约束
@property (strong, nonatomic, readonly) JZLayout * (^width)(CGFloat width);
@property (strong, nonatomic, readonly) JZLayout * (^greaterThanWidth)(CGFloat width);
@property (strong, nonatomic, readonly) JZLayout * (^lessThanWidth)(CGFloat width);
@property (strong, nonatomic, readonly) JZLayout * (^height)(CGFloat height);
@property (strong, nonatomic, readonly) JZLayout * (^greaterThanHeight)(CGFloat height);
@property (strong, nonatomic, readonly) JZLayout * (^lessThanHeight)(CGFloat height);
// 对齐方式
@property (strong, nonatomic, readonly) JZLayout * (^center)(UIView *view);
@property (strong, nonatomic, readonly) JZLayout * (^centerX)(UIView *view);
@property (strong, nonatomic, readonly) JZLayout * (^centerY)(UIView *view);
// 更新约束
@property (strong, nonatomic, readonly) JZLayout * (^update)(BOOL isUpdate);

@end

NS_ASSUME_NONNULL_END
