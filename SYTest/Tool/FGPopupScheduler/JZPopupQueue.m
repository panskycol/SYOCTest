//
//  JZPopupQueue.m
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/23.
//

#import "JZPopupQueue.h"
#import "JZPopupList+Internal.h"

@implementation JZPopupQueue

- (void)addPopupView:(id<JZPopupView>)view Priority:(JZPopupStrategyPriority)Priority{
    [super addPopupView:view Priority:Priority];
    [self _push_back:[PopupElement elementWith:view Priority:Priority]];
}


@end
