//
//  JZStackView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/10/12.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZStackView : UIStackView

@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZStackView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZStackView * (^direction)(UILayoutConstraintAxis axis);
@property (strong, nonatomic, readonly) JZStackView * (^dist)(UIStackViewDistribution dist);
@property (strong, nonatomic, readonly) JZStackView * (^align)(UIStackViewAlignment align);
@property (strong, nonatomic, readonly) JZStackView * (^space)(CGFloat spacing);
@property (strong, nonatomic, readonly) JZStackView * (^arrageViews)(NSArray <UIView *> *views);

+ (JZStackView *)stackView;
// 快速横向等间距布局
+ (JZStackView *)equalSpacingStackViewH;
// 快速纵向等间距布局
+ (JZStackView *)equalSpacingStackViewV;
// 快速横向等宽布局
+ (JZStackView *)fillEquallyStackViewH;
// 快速纵向等高布局
+ (JZStackView *)fillEquallyStackViewV;


@end

NS_ASSUME_NONNULL_END
