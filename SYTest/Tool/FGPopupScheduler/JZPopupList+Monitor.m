//
//  JZPopupList+Monitor.m
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/7/23.
//

#import "JZPopupList+Monitor.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

static char kJZPopupListPopupMonitorKey;

@implementation JZPopupList (Monitor)

- (void)monitorRemoveEventWith:(id<JZPopupView>)popup{
    
    objc_setAssociatedObject(popup, &kJZPopupListPopupMonitorKey, self, OBJC_ASSOCIATION_ASSIGN);

    BOOL exist = NO;
    if ([popup respondsToSelector:@selector(dismissPopupView)]) {
        exist = YES;
        [[popup class] swizzleOrAddInstanceMethod:@selector(dismissPopupView) withNewSel:@selector(Monitor_dismissPopupView) withNewSelClass:self.class];
    }
    if ([popup respondsToSelector:@selector(dismissPopupViewWithAnimation:)]) {
        exist = YES;
        [[popup class] swizzleOrAddInstanceMethod:@selector(dismissPopupViewWithAnimation:) withNewSel:@selector(Monitor_dismissPopupViewWithAnimation:) withNewSelClass:self.class];
    }
    NSAssert(exist, @"You must have to implementation -dismissPopupView or -dismissPopupViewWithAnimation:");
}

- (void)Monitor_dismissPopupView{
    [self Monitor_dismissPopupView];

    if ([self conformsToProtocol:@protocol(JZPopupView)]) {
        id<JZPopupView> obj = (id<JZPopupView>)self;
        [JZPopupList tryRemovePopupView:obj];
    }
}

- (void)Monitor_dismissPopupViewWithAnimation:(JZPopupViewAnimationBlock)block{
    JZPopupViewAnimationBlock Monitor_block = ^(void){
        if (block) {
            block();
        }
        if ([self conformsToProtocol:@protocol(JZPopupView)]) {
            id<JZPopupView> obj = (id<JZPopupView>)self;
            [JZPopupList tryRemovePopupView:obj];
        }
    };
    
    [self Monitor_dismissPopupViewWithAnimation:Monitor_block];
}

+ (void)tryRemovePopupView:(id<JZPopupView>)obj{
    JZPopupList *list = objc_getAssociatedObject(obj, &kJZPopupListPopupMonitorKey);
    if (list) {
        objc_setAssociatedObject(obj, &kJZPopupListPopupMonitorKey, nil, OBJC_ASSOCIATION_ASSIGN);
        [list removePopupView:obj];
        /// 唤醒主线程做hitTest
        [list performSelector:@selector(hash) withObject:nil afterDelay:0];
    }
}

@end
