//
//  JZPopupViewScheduler.m
//  FGPopViewScheduler
//
//  Created by FoneG on 2021/6/22.
//

#import "JZPopupScheduler.h"
#import <CoreFoundation/CFRunLoop.h>
#import "JZPopupSchedulerStrategyQueue.h"
#import "JZPopupQueue.h"
#import "JZPopupStack.h"
#import "JZPopupPriorityList.h"

static NSHashTable *JZPopupSchedulers(void) {
    static NSHashTable *schedulers = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        schedulers = [NSHashTable weakObjectsHashTable];
    });
    return schedulers;
}

static void FGRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    for (JZPopupScheduler *scheduler in JZPopupSchedulers()) {
        if (![scheduler isEmpty]) {
            [scheduler registerFirstPopupViewResponder];
        }
    }
}

@interface JZPopupScheduler ()
{
    id<JZPopupSchedulerStrategyQueue> _list;
    JZPopupSchedulerStrategy _pss;
}

@end

@implementation JZPopupScheduler

+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting | kCFRunLoopExit, true, 0xFFFFFF, FGRunLoopObserverCallBack, nil);
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
        CFRelease(observer);
    });
}

+ (JZPopupScheduler *)JZPopupSchedulerGetForPSS:(JZPopupSchedulerStrategy)pss{
    
    if (pss & JZPopupSchedulerStrategyPriority) {
        if (pss & JZPopupSchedulerStrategyLIFO) {
            static dispatch_once_t onceToken;
            static JZPopupScheduler *scheduler = nil;
            dispatch_once(&onceToken, ^{
                scheduler = [[JZPopupScheduler alloc] initWithStrategy:pss];
            });
            return scheduler;
        }else{
            static dispatch_once_t onceToken;
            static JZPopupScheduler *scheduler = nil;
            dispatch_once(&onceToken, ^{
                scheduler = [[JZPopupScheduler alloc] initWithStrategy:pss];
            });
            return scheduler;
        }
    }
    else if (pss == JZPopupSchedulerStrategyFIFO) {
        static dispatch_once_t onceToken;
        static JZPopupScheduler *scheduler = nil;
        dispatch_once(&onceToken, ^{
            scheduler = [[JZPopupScheduler alloc] initWithStrategy:pss];
        });
        return scheduler;
    }
    else if(pss == JZPopupSchedulerStrategyLIFO){
        static dispatch_once_t onceToken;
        static JZPopupScheduler *scheduler = nil;
        dispatch_once(&onceToken, ^{
            scheduler = [[JZPopupScheduler alloc] initWithStrategy:pss];
        });
        return scheduler;
    }else{
        return nil;
    }
}

- (instancetype)initWithStrategy:(JZPopupSchedulerStrategy)pss{
    if (self = [super init]) {
        [JZPopupSchedulers() addObject:self];
        [self setSchedulerStrategy:pss];
    }
    return self;
}

- (void)setSchedulerStrategy:(JZPopupSchedulerStrategy)pss{
    _pss = pss;
    if (pss & JZPopupSchedulerStrategyPriority) {
        JZPopupPriorityList *PriorityList = [[JZPopupPriorityList alloc] init];
        PriorityList.PPAS = pss & JZPopupSchedulerStrategyLIFO ? JZPopupPriorityAddStrategyLIFO : JZPopupPriorityAddStrategyFIFO;
        _list = PriorityList;
    }
    else if (pss == JZPopupSchedulerStrategyFIFO) {
        _list = [[JZPopupQueue alloc] init];
    }
    else if(pss == JZPopupSchedulerStrategyLIFO){
        _list = [[JZPopupStack alloc] init];
    }
}

- (void)setSuspended:(BOOL)suspended{
    dispatch_async_main_safe(^(){
        self->_suspended = suspended;
        if (!suspended) [self registerFirstPopupViewResponder];
    });
}

- (void)add:(id<JZPopupView>)view{
    [self add:view Priority:JZPopupStrategyPriorityNormal];
}


#pragma mark - List Operation method

- (void)add:(id<JZPopupView>)view  Priority:(JZPopupStrategyPriority)Priority{
    dispatch_async_main_safe(^(){
        view.scheduler = self;
        [self->_list addPopupView:view Priority:Priority];
        [self registerFirstPopupViewResponder];
    });
}

- (void)remove:(id<JZPopupView>)view{
    dispatch_async_main_safe(^(){
        [self->_list removePopupView:view];
    });
}

- (void)removeAlertViewWithKey:(NSString *)key{
    dispatch_async_main_safe(^(){
        [self->_list removePopupViewWithKey:key];
    });
}

- (void)removeAllPopupViews{
    dispatch_async_main_safe(^(){
        [self->_list clear];
    });
}

- (BOOL)canRegisterFirstPopupViewResponder{
    __block BOOL canRegister = NO;
    dispatch_sync_main_safe(^(){
        canRegister = [self->_list canRegisterFirstFirstPopupViewResponder];
    });
    return canRegister;
}

- (void)registerFirstPopupViewResponder{
    if (!self.suspended && self.canRegisterFirstPopupViewResponder) {
        dispatch_async_main_safe(^(){
            [self->_list execute];
        });
    }
}

- (BOOL)isEmpty{
    __block BOOL empty = NO;
    dispatch_sync_main_safe(^(){
        empty = [self->_list isEmpty];
    });
    return empty;
}

@end
