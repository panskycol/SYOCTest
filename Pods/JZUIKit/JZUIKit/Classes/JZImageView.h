//
//  JZImageView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZImageView : UIImageView
 
@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZImageView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZImageView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZImageView * (^img)(NSString *imageName);
@property (strong, nonatomic, readonly) JZImageView * (^animImgs)(NSArray <NSString *> *imageNames);
@property (strong, nonatomic, readonly) JZImageView * (^formatAnimImgs)(NSString *prefix, NSInteger count);
@property (strong, nonatomic, readonly) JZImageView * (^duration)(NSTimeInterval interval);
@property (strong, nonatomic, readonly) JZImageView * (^rCount)(NSInteger count);
@property (strong, nonatomic, readonly) JZImageView * (^start)(void);
@property (strong, nonatomic, readonly) JZImageView * (^stop)(void);

+ (JZImageView *)imageView;

@end

NS_ASSUME_NONNULL_END
