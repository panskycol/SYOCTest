//
//  JZPopupStack.m
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/25.
//

#import "JZPopupStack.h"
#import "JZPopupList+Internal.h"

@implementation JZPopupStack

- (void)addPopupView:(id<JZPopupView>)view Priority:(JZPopupStrategyPriority)Priority{
    [super addPopupView:view Priority:Priority];
    [self _push_front:[PopupElement elementWith:view Priority:Priority]];
}

@end
