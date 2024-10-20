//
//  JZCollectionView.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/8.
//

#import "JZCollectionView.h"

@implementation JZCollectionView 

+ (JZCollectionView *)collectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    JZCollectionView *collectionView = [[JZCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
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

- (JZCollectionView * _Nonnull (^)(UIView * _Nonnull))container {
    return ^id(UIView *view) {
        if (view) {
            [view addSubview:self];
        }
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))frm {
    return ^id(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(id<UICollectionViewDelegate> _Nonnull))delegateTarget {
    return ^id(id<UICollectionViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(id<UICollectionViewDataSource> _Nonnull))dataSourceTarget {
    return ^id(id<UICollectionViewDataSource> dataSource) {
        self.dataSource = dataSource;
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(UIView * _Nonnull))bView {
    return ^id(UIView *view) {
        self.backgroundView = view;
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))rClass {
    return ^id(Class cls, NSString *reuserId) {
        [self registerClass:cls forCellWithReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(UINib * _Nonnull, NSString * _Nonnull))rNib {
    return ^id(UINib *nib, NSString *reuserId) {
        [self registerNib:nib forCellWithReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))rHeaderClass {
    return ^id(Class cls, NSString *reuserId) {
        [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(UINib * _Nonnull, NSString * _Nonnull))rHeaderNib {
    return ^id(UINib *nib, NSString *reuserId) {
        [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(Class  _Nonnull __unsafe_unretained, NSString * _Nonnull))rFooterClass {
    return ^id(Class cls, NSString *reuserId) {
        [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(UINib * _Nonnull, NSString * _Nonnull))rFooterNib {
    return ^id(UINib *nib, NSString *reuserId) {
        [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuserId];
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(UICollectionViewScrollDirection))direction {
    return ^id(UICollectionViewScrollDirection direction) {
        if ([self.collectionViewLayout.class isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            layout.scrollDirection = direction;
        }
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(CGFloat, CGFloat))itemSize {
    return ^id(CGFloat w, CGFloat h) {
        if ([self.collectionViewLayout.class isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            layout.itemSize = CGSizeMake(w, h);
        }
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(CGFloat))minLineSpacing {
    return ^id(CGFloat spacing) {
        if ([self.collectionViewLayout.class isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            layout.minimumLineSpacing = spacing;
        }
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(CGFloat))minInteritemSpacing {
    return ^id(CGFloat spacing) {
        if ([self.collectionViewLayout.class isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            layout.minimumInteritemSpacing = spacing;
        }
        return self;
    };
}

- (JZCollectionView * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))sectionInset {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        if ([self.collectionViewLayout.class isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            layout.sectionInset = UIEdgeInsetsMake(top, left, bottom, right);
        }
        return self;
    };

}

@end
