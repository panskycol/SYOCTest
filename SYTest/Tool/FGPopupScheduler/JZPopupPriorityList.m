//
//  JZPopupPriority.m
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/25.
//

#import "JZPopupPriorityList.h"
#import "JZPopupList+Internal.h"
#import <objc/runtime.h>

@implementation JZPopupPriorityList

- (void)addPopupView:(id<JZPopupView>)view Priority:(JZPopupStrategyPriority)Priority{
   
    [super addPopupView:view Priority:Priority];
    __block int index = 0;
    /// create FIFO
    [self _enumerateObjectsUsingBlock:^(PopupElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.Priority > Priority) {
            index++;
        }else if(obj.Priority == Priority && self.PPAS == JZPopupPriorityAddStrategyFIFO){
            index++;
        }else{
            *stop = YES;
        }
    }];
    [self _insert:[PopupElement elementWith:view Priority:Priority] index:index];
    
    
    id<JZPopupView> firstResponderPopuper = self.FirstFirstResponderElement.data;
    JZPopupStrategyPriority firstResponderPriority = self.FirstFirstResponderElement.Priority;
    
    BOOL jump = [firstResponderPopuper respondsToSelector:@selector(popupViewSwitchBehavior)] && firstResponderPopuper.popupViewSwitchBehavior != JZPopupViewSwitchBehaviorAwait;
    BOOL highPriority = firstResponderPriority < Priority || (firstResponderPriority == Priority && self.PPAS == JZPopupPriorityAddStrategyLIFO);
    
    BOOL reinsert = NO;
    if (jump && highPriority) {
        switch (firstResponderPopuper.popupViewSwitchBehavior) {
            case JZPopupViewSwitchBehaviorAwait:
                ///
                break;
            case JZPopupViewSwitchBehaviorLatent:
                reinsert = firstResponderPriority < Priority;
                [self discardPopupElemnt:self.FirstFirstResponderElement];
                break;
            case JZPopupViewSwitchBehaviorDiscard:
                [self discardPopupElemnt:self.FirstFirstResponderElement];
                break;
        }
    }
    if (reinsert) {
        [self addPopupView:firstResponderPopuper Priority:firstResponderPriority];
    }
}

- (void)discardPopupElemnt:(PopupElement *)element{
    if([element.data respondsToSelector:@selector(dismissPopupView)]){
        [element.data dismissPopupView];
    }
    else if ([element.data respondsToSelector:@selector(dismissPopupViewWithAnimation:)]) {
        [element.data dismissPopupViewWithAnimation:^{
            NSLog(@"-dismissPopupViewWithAnimation: Triggered by a higher priority popover");
        }];
    }
}

@end
