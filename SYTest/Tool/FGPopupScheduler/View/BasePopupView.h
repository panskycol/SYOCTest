//
//  BasePopView.h
//  FGPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/23.
//

#import <UIKit/UIKit.h>
#import "FGPopupView.h"
#import "FGPopupScheduler.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZBasePopupView : UIView <FGPopupView>

- (instancetype)initWithDescrption:(NSString *)des scheduler:(FGPopupScheduler*)scheduler;

@property (nonatomic, strong, readonly) FGPopupScheduler *scheduler;
@property (nonatomic, assign) FGPopupViewSwitchBehavior switchBehavior;
@property (nonatomic, copy) void(^touchCallBack)(void) ;

@end

NS_ASSUME_NONNULL_END
