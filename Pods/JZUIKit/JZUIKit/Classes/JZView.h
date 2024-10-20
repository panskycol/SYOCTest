//
//  JZView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/30.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZView : UIView

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout; 

@property (strong, nonatomic, readonly) JZView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZView * (^bColorHex)(NSString *hexString,CGFloat alpha);
@property (strong, nonatomic, readonly) JZView * (^bColor)(UIColor *color);

+ (JZView *)view;

@end

NS_ASSUME_NONNULL_END
