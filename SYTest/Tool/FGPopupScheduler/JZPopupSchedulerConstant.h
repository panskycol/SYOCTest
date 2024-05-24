//
//  JZPopupSchedulerConstant.h
//  FGPopViewScheduler
//
//  Created by FoneG on 2021/6/22.
//

#ifndef JZPopupSchedulerConstant_h
#define JZPopupSchedulerConstant_h

//
typedef NS_ENUM(NSUInteger, JZPopupSchedulerStrategy) {
    JZPopupSchedulerStrategyFIFO = 1 << 0,           //先进先出
    JZPopupSchedulerStrategyLIFO = 1 << 1,           //后进先出
    JZPopupSchedulerStrategyPriority = 1 << 2        //优先级调度
};

typedef NS_ENUM(NSUInteger, JZPopupViewSwitchBehavior) {
    JZPopupViewSwitchBehaviorDiscard,  //当该弹窗已经显示，如果后面来了弹窗优先级更高的弹窗时，显示更高优先级弹窗并且当前弹窗会被抛弃
    JZPopupViewSwitchBehaviorLatent,   //当该弹窗已经显示，如果后面来了弹窗优先级更高的弹窗时，显示更高优先级弹窗并且当前弹窗重新进入队列, PS：优先级相同时同 JZPopupViewSwitchBehaviorDiscard
    JZPopupViewSwitchBehaviorAwait,    //当该弹窗已经显示时，不会被后续高优线级的弹窗影响
};

typedef NS_ENUM(NSUInteger, JZPopupViewUntriggeredBehavior) {
    JZPopupViewUntriggeredNone,
    JZPopupViewUntriggeredAbandon,                  //当弹窗触发显示逻辑，直接抛弃（一开始已加入到链表中，但是在后面不需要再显示了）
    JZPopupViewUntriggeredBehaviorDiscard,          //当弹窗触发显示逻辑，但未满足条件时会被直接丢弃
    JZPopupViewUntriggeredBehaviorAwait,            //当弹窗触发显示逻辑，但未满足条件时会继续等待
};

typedef NSUInteger JZPopupStrategyPriority;
static const JZPopupStrategyPriority JZPopupStrategyPriorityVeryLow = 1;
static const JZPopupStrategyPriority JZPopupStrategyPriorityLow = 50;
static const JZPopupStrategyPriority JZPopupStrategyPriorityNormal = 100;
static const JZPopupStrategyPriority JZPopupStrategyPriorityHigh = 1000;
static const JZPopupStrategyPriority JZPopupStrategyPriorityVeryHigh= 2000;

typedef void(^JZPopupViewAnimationBlock)(void);

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#define WS(wSelf)            __weak typeof(self) wSelf = self
#define SS(sSelf)            __strong typeof(wSelf) sSelf = wSelf

#endif /* JZPopupSchedulerConstant_h */
