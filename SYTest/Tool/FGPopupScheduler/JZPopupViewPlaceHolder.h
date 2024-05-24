//
//  JZPopupViewPlaceHolder.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/11/8.
//

#import <Foundation/Foundation.h>
#import "JZPopupScheduler.h"

NS_ASSUME_NONNULL_BEGIN

/*
 为当前对象生成一个popup对象, 用于类似UIAlertController  这类无法直接遵守 <JZPopupView>的对象。类似这一类弹窗对象，需要做到下面3个步骤
 1. 告诉JZPopupViewPlaceHolder如何显示：showPopupViewCallBlock
 2. 告诉JZPopupViewPlaceHolder 如何隐藏：removePopupViewCallBlock
 3. 在<JZPopupView>主动消失的时候， RealPopView 需要通过 -remove：主动把 JZPopupViewPlaceHolder 从 JZPopupScheduler 中移除
 */
@interface JZPopupViewPlaceHolder : NSObject <JZPopupView>
@property (nonatomic, copy) void(^showPopupViewCallBlock)( __weak NSObject *weakObj);
@property (nonatomic, copy) void(^removePopupViewCallBlock)(__weak NSObject *weakObj);

+(instancetype)generatePlaceHolderWith:(NSObject *)RealPopView;
@end

NS_ASSUME_NONNULL_END
