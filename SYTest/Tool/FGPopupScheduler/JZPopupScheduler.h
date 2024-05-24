//
//  JZPopupViewScheduler.h
//  FGPopViewScheduler
//
//  Created by FoneG on 2021/6/22.
//

#import <Foundation/Foundation.h>
#import "JZPopupSchedulerConstant.h"
#import "JZPopupView.h"

NS_ASSUME_NONNULL_BEGIN

/***
 
 实现的功能：
 1.可以让所有的弹窗排队展示，不至于全部重叠在一起
 2.信令过来优先级高的视图，可以选择优先展示，原来的弹窗可以选择保留或者丢弃
 3.自己创建UIAlertController也可以加入到队列中去排队：JZPopupViewPlaceHolder
 4.自己添加的功能：可以根据key删除指定的还没展示的弹窗
 5.添加弹窗进入队列时可以设置优先级，内部会插入到链表的对应位置（内部队列使用链表实现）
 
 */

@interface JZPopupScheduler : NSObject

/// 根据指定的策略生成一个弹窗控制队列
/// @param pps 策略类型

/**
 根据指定的策略生成一个弹窗控制队列
 
 @param pss  FIFO、LIFO、Priority
 @return 返回指定策略的调度器，需要外部持有生命周期
 */
- (instancetype)initWithStrategy:(JZPopupSchedulerStrategy)pss;

/**
 获取一个指定调取策略全局的弹窗调度器
 */
+ (JZPopupScheduler *)JZPopupSchedulerGetForPSS:(JZPopupSchedulerStrategy)pss;

/**
 向队列插入一个弹窗，JZPopupScheduler会根据设置的策略状态来控制在队列中插入的位置,  如果条件允许（通过-hitTest），将会通过-showPopupViewWithAnimation or -showPopupView 显示。 支持线程安全
 
 @param view 弹窗实例
 */
- (void)add:(id<JZPopupView>)view;

/**
 向队列插入一个弹窗，JZPopupScheduler会根据设置的策略状态来控制在队列中插入的位置, 支持线程安全  (JZPopupViewStrategy逻辑已经被删除，替换枚举类型： JZPopupViewSwitchBehavior )
 
 @param view 弹窗实例
 @param psp 当选择优先级调度策略时，会根据 JZPopupStrategyPriority来判断弹窗插入的位置
 */
- (void)add:(id<JZPopupView>)view Priority:(JZPopupStrategyPriority)psp;


/**
把弹窗种队列种移除, 不会触发<JZPopupView>的-dismissPopupViewW or -dismissPopupViewWithAnimation: 方法，支持线程安全
 
@param view 弹窗实例
 */
- (void)remove:(id<JZPopupView>)view;


- (void)removeAlertViewWithKey:(NSString *)key;

/**
 移除队列中所有的弹窗队列，显示的弹窗将会触发<JZPopupView>的-dismissPopupViewW or -dismissPopupViewWithAnimation: 方法,  并优先执行-dismissPopupViewWithAnimation:方法。 支持线程安全
 */
- (void)removeAllPopupViews;

/**
 向调度器主动发送一个执行显示弹窗的命令, 支持线程安全
 
 */
- (void)registerFirstPopupViewResponder;

/**
 返回当前调度器是否拥有已经显示的弹窗, 如果canRegisterFirstPopupViewResponder为true，-registerFirstPopupViewResponder将执行无效
 */
@property (nonatomic, assign, readonly) BOOL canRegisterFirstPopupViewResponder;

/**
 返回当前调取队列是否存在弹窗
 
 */
@property (nonatomic, assign, getter=isEmpty, readonly) BOOL empty;

/**
 可以将调度器进行挂起，可以中止队列触发- execute。挂起状态不会影响已经execute的弹窗
 */
@property (nonatomic, assign, getter=isSuspended) BOOL suspended;

@end


NS_ASSUME_NONNULL_END

