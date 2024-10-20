//
//  JZTableView.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import <UIKit/UIKit.h>
#import "JZLayout.h"
#import "JZLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JZTableView : UITableView

@property (strong, nonatomic) JZLayer *layerMgr;
@property (strong, nonatomic) JZLayout *layout;

@property (strong, nonatomic, readonly) JZTableView * (^container)(UIView *view);
@property (strong, nonatomic, readonly) JZTableView * (^frm)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (strong, nonatomic, readonly) JZTableView * (^delegateTarget)(id<UITableViewDelegate> delegate);
@property (strong, nonatomic, readonly) JZTableView * (^dataSourceTarget)(id<UITableViewDataSource> delegate);
// height
@property (strong, nonatomic, readonly) JZTableView * (^rowH)(CGFloat height);
@property (strong, nonatomic, readonly) JZTableView * (^sectionHeaderH)(CGFloat height);
@property (strong, nonatomic, readonly) JZTableView * (^sectionFooterH)(CGFloat height);
@property (strong, nonatomic, readonly) JZTableView * (^estimatedRowH)(CGFloat height);
@property (strong, nonatomic, readonly) JZTableView * (^estimatedSectionHeaderRowH)(CGFloat height);
@property (strong, nonatomic, readonly) JZTableView * (^estimatedSectionFooterRowH)(CGFloat height);
// separator
@property (strong, nonatomic, readonly) JZTableView * (^sepaInset)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@property (strong, nonatomic, readonly) JZTableView * (^sepaColorHex)(NSString *hexString, CGFloat alpha);
@property (strong, nonatomic, readonly) JZTableView * (^sepaColor)(UIColor *colorha);

@property (strong, nonatomic, readonly) JZTableView * (^sepaStyle)(UITableViewCellSeparatorStyle style);
// layout
@property (strong, nonatomic, readonly) JZTableView * (^bView)(UIView *view);
@property (strong, nonatomic, readonly) JZTableView * (^headerView)(UIView *view);
@property (strong, nonatomic, readonly) JZTableView * (^footerView)(UIView *view);
// register
@property (strong, nonatomic, readonly) JZTableView * (^rClass)(Class cls, NSString *reuseId);
@property (strong, nonatomic, readonly) JZTableView * (^rNib)(UINib *nib, NSString *reuseId);
@property (strong, nonatomic, readonly) JZTableView * (^rHeaderFooterClass)(Class cls, NSString *reuseId);
@property (strong, nonatomic, readonly) JZTableView * (^rHeaderFooterNib)(UINib *nib, NSString *reuseId);

+ (JZTableView *)tableView;
+ (JZTableView *)tableView:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
