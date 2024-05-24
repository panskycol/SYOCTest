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

//当该弹窗已经显示，有插进来的视图如何处理改弹窗
@property (nonatomic, assign) FGPopupViewSwitchBehavior switchBehavior;

@property (nonatomic, copy) void(^touchCallBack)(void);

@end

NS_ASSUME_NONNULL_END
