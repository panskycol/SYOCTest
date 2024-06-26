//
//  JZPopupList+Internal.h
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/24.
//

#import "JZPopupList.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZPopupList ()

/**
 list操作方法
 */
- (void)_push_back:(PopupElement *)e;
- (void)_push_front:(PopupElement *)e;
- (void)_insert:(PopupElement *)e index:(int)index;
- (void)_rm:(PopupElement *)e;
- (void)_enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(PopupElement *obj, NSUInteger idx, BOOL *stop))block;

@end



NS_ASSUME_NONNULL_END
