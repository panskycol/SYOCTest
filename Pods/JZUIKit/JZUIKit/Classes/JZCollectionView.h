//
//  JZCollectionView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZCollectionView : UICollectionView 

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZCollectionView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZCollectionView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZCollectionView * (^delegateTarget)(id<UICollectionViewDelegate> delegate);
@property (strong, nonatomic, readonly) JZCollectionView * (^dataSourceTarget)(id<UICollectionViewDataSource> delegate);
@property (strong, nonatomic, readonly) JZCollectionView * (^bView)(UIView *view);
// register
@property (strong, nonatomic, readonly) JZCollectionView * (^rClass)(Class cls, NSString *reuseId);
@property (strong, nonatomic, readonly) JZCollectionView * (^rNib)(UINib *nib, NSString *reuseId);
@property (strong, nonatomic, readonly) JZCollectionView * (^rHeaderClass)(Class cls, NSString *reuseId);
@property (strong, nonatomic, readonly) JZCollectionView * (^rHeaderNib)(UINib *nib, NSString *reuseId);
@property (strong, nonatomic, readonly) JZCollectionView * (^rFooterClass)(Class cls, NSString *reuseId);
@property (strong, nonatomic, readonly) JZCollectionView * (^rFooterNib)(UINib *nib, NSString *reuseId);
// layout
@property (strong, nonatomic, readonly) JZCollectionView * (^direction)(UICollectionViewScrollDirection direction);
@property (strong, nonatomic, readonly) JZCollectionView * (^itemSize)(CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZCollectionView * (^minLineSpacing)(CGFloat spacing);
@property (strong, nonatomic, readonly) JZCollectionView * (^minInteritemSpacing)(CGFloat spacing);
@property (strong, nonatomic, readonly) JZCollectionView * (^sectionInset)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

+ (JZCollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
