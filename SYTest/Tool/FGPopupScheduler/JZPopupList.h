//
//  JZPopupList.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "JZPopupSchedulerStrategyQueue.h"

NS_ASSUME_NONNULL_BEGIN

@class PopupElement;
@interface JZPopupList : NSObject <JZPopupSchedulerStrategyQueue>

@property (nonatomic, strong, readonly) PopupElement *FirstFirstResponderElement;

@end

@interface PopupElement : NSObject
/**
 弹窗数据
 */
@property (nonatomic, strong) id<JZPopupView> data;
/**
 弹窗优先级，默认JZPopupStrategyPriorityNormal
 */
@property (nonatomic, assign) JZPopupStrategyPriority Priority;
/**
 创建时间戳，当优先级相同时根据createStamp判断在list中的序列，默认FIFO
 */
@property (nonatomic, assign) double createStamp;

/**
 弹窗状态，当被高优先级弹窗置换后弹窗会通过 data.hiddent = YES 被隐藏
 */
@property (nonatomic, assign) BOOL latent;
/**
 根据弹窗和优先级初始化弹窗节点对象，createStamp默认为CFAbsoluteTimeGetCurrent()
 */
+ (instancetype)elementWith:(id<JZPopupView>)data Priority:(JZPopupStrategyPriority)Priority;

@end


NS_ASSUME_NONNULL_END
