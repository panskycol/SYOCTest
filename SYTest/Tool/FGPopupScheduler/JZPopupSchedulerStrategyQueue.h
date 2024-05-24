//
//  JZPopupSchedulerStrategyQueue.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/23.
//

#import <Foundation/Foundation.h>
#import "JZPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JZPopupSchedulerStrategyQueue <NSObject>

/**
 向当前队列中添加弹窗对象，根据不同的JZPopupSchedulerStrategy，每个subList自己都需要重构的-addPopupView:方法
 
 @param view 弹窗对象
 @param Priority 优先级
 */
- (void)addPopupView:(id<JZPopupView>)view  Priority:(JZPopupStrategyPriority)Priority;

/**
 从当前队列删除指定的弹窗对象，根据不同的JZPopupSchedulerStrategy，每个subList自己都需要重构的-removePopupView:方法
 */
- (void)removePopupView:(id<JZPopupView>)view;

/**
 从当前队列删除指定的弹窗对象，根据不同的JZPopupSchedulerStrategy，每个subList自己都需要重构的-removePopupViewWithKey:方法
 */
- (void)removePopupViewWithKey:(NSString *)key;

/**
 从当前队列中进行-hitTest，返回对象作为当前的FirstFirstResponder，并执行显示操作
 */
- (BOOL)execute;

/**
 清除当前队列弹窗，
 */
- (void)clear;

/**
 返回当前队列是否存在弹窗
 */
- (BOOL)isEmpty;

/**
 返回是否能注册新的显示弹窗，如果当前已经有显示的弹窗返回NO
 */
- (BOOL)canRegisterFirstFirstPopupViewResponder;
@end

NS_ASSUME_NONNULL_END
