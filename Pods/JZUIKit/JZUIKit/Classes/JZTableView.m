//
//  JZTableView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import "JZTableView.h"
#import "JZFont.h"
#import "JZColor.h"
#import "JZLabel.h"

@implementation JZTableView

+ (JZTableView *)tableView {
    return [JZTableView tableView:UITableViewStylePlain];
}

+ (JZTableView *)tableView:(UITableViewStyle)style {
    JZTableView *tableView = [[JZTableView alloc] initWithFrame:CGRectZero style:style];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.sepaStyle(UITableViewCellSeparatorStyleNone);
    // 默认关闭预估高度
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    return tableView;
}

- (JZLayout *)layout {
    if (!_layout) {
        _layout = [[JZLayout alloc] init];
        _layout.view = self;
    }
    return _layout;
}

- (JZLayer *)layerMgr {
    if (!_layerMgr) {
        _layerMgr = [[JZLayer alloc] init];
        _layerMgr.view = self;
    }
    return _layerMgr;
}

- (JZTableView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZTableView * _Nonnull (^)(id<UITableViewDelegate> _Nonnull))delegateTarget {
    return ^id(id<UITableViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(id<UITableViewDataSource> _Nonnull))dataSourceTarget {
    return ^id(id<UITableViewDataSource> dataSource) {
        self.dataSource = dataSource;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))rowH {
    return ^id(CGFloat height) {
        self.rowHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))sectionHeaderH {
    return ^id(CGFloat height) {
        self.sectionHeaderHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))sectionFooterH {
    return ^id(CGFloat height) {
        self.sectionFooterHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))estimatedRowH {
    return ^id(CGFloat height) {
        self.estimatedRowHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))estimatedSectionHeaderRowH {
    return ^id(CGFloat height) {
        self.estimatedSectionHeaderHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat))estimatedSectionFooterRowH {
    return ^id(CGFloat height) {
        self.estimatedSectionFooterHeight = height;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))sepaInset {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        self.separatorInset = UIEdgeInsetsMake(top, left, bottom, right);
        return self;
    };
}

- (JZTableView * _Nonnull (^)(NSString * _Nonnull, CGFloat))sepaColorHex {
    return ^id(NSString *hexString, CGFloat alpha) {
        self.separatorColor = [JZColor alColorWithHexString:hexString alpha:alpha];
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UIColor * _Nonnull))sepaColor {
    return ^id(UIColor *color) {
        self.separatorColor = color;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UITableViewCellSeparatorStyle))sepaStyle {
    return ^id(UITableViewCellSeparatorStyle style) {
        self.separatorStyle = style;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UIView * _Nonnull))bView {
    return ^id(UIView *view) {
        self.backgroundView = view;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UIView * _Nonnull))headerView {
    return ^id(UIView *view) {
        self.tableHeaderView = view;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UIView * _Nonnull))footerView {
    return ^id(UIView *view) {
        self.tableFooterView = view;
        return self;
    };
}

- (JZTableView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))rClass {
    return ^id(Class cls, NSString *reuserId) {
        [self registerClass:cls forCellReuseIdentifier:reuserId];
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UINib * _Nonnull, NSString * _Nonnull))rNib {
    return ^id(UINib *nib, NSString *reuserId) {
        [self registerNib:nib forCellReuseIdentifier:reuserId];
        return self;
    };
}

- (JZTableView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))rHeaderFooterClass {
    return ^id(Class cls, NSString *reuserId) {
        [self registerClass:cls forHeaderFooterViewReuseIdentifier:reuserId];
        return self;
    };
}

- (JZTableView * _Nonnull (^)(UINib * _Nonnull, NSString * _Nonnull))rHeaderFooterNib {
    return ^id(UINib *nib, NSString *reuserId) {
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:reuserId];
        return self;
    };
}

@end
