//
//  JZPopupPriority.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/25.
//

#import "JZPopupList.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JZPopupPriorityAddStrategy) {
    JZPopupPriorityAddStrategyFIFO, //FIFO
    JZPopupPriorityAddStrategyLIFO, //LIFO
};

@interface JZPopupPriorityList : JZPopupList

/**
 当两个弹窗之间的优先级相同的时候，会根据选择的添加策略来决定出队列的顺序，默认为JZPopupPriorityAddStrategyFIFO
 */
@property (nonatomic, assign) JZPopupPriorityAddStrategy PPAS;

@end

NS_ASSUME_NONNULL_END
