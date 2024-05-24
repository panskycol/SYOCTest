//
//  JZPopupList+Monitor.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/7/23.
//

#import "JZPopupList.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZPopupList (Monitor)

- (void)monitorRemoveEventWith:(id<JZPopupView>)popup;

@end

NS_ASSUME_NONNULL_END
