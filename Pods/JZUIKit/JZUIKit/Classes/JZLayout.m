//
//  JZLayout.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/11/10.
//

#import "JZLayout.h"
#import <Masonry/Masonry.h>

@interface JZLayout ()

@property (assign, nonatomic) BOOL isUpdate;

@end

@implementation JZLayout

- (JZLayout * _Nonnull (^)(CGFloat, CGFloat, CGFloat, CGFloat))margin {
    return ^id(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.superview).offset(top);
                    make.left.equalTo(self.view.superview).offset(left);
                    make.bottom.equalTo(self.view.superview).offset(bottom);
                    make.right.equalTo(self.view.superview).offset(right);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.superview).offset(top);
                    make.left.equalTo(self.view.superview).offset(left);
                    make.bottom.equalTo(self.view.superview).offset(bottom);
                    make.right.equalTo(self.view.superview).offset(right);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))marginT {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.superview).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.superview).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))marginL {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.superview).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.superview).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))marginB {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view.superview).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view.superview).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))marginR {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.view.superview).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.view.superview).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull, CGFloat))top {
    return ^id(UIView *view, CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.mas_bottom).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.mas_bottom).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull, CGFloat))left {
    return ^id(UIView *view, CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(view.mas_right).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull, CGFloat))bottom {
    return ^id(UIView *view, CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(view.mas_top).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(view.mas_top).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull, CGFloat))right {
    return ^id(UIView *view, CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(view.mas_left).offset(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(view.mas_left).offset(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))width {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))greaterThanWidth {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_greaterThanOrEqualTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_greaterThanOrEqualTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))lessThanWidth {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_lessThanOrEqualTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_lessThanOrEqualTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))height {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))greaterThanHeight {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_greaterThanOrEqualTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_greaterThanOrEqualTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(CGFloat))lessThanHeight {
    return ^id(CGFloat value) {
        if (self.view.superview != nil) {
            if (self.isUpdate) {
                [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_lessThanOrEqualTo(value);
                }];
            } else {
                [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_lessThanOrEqualTo(value);
                }];
            }
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull))center {
    return ^id(UIView *view) {
        if (self.isUpdate) {
            [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
            }];
        } else {
            [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
            }];
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull))centerX {
    return ^id(UIView *view) {
        if (self.isUpdate) {
            [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view);
            }];
        } else {
            [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view);
            }];
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(UIView * _Nonnull))centerY {
    return ^id(UIView *view) {
        if (self.isUpdate) {
            [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
            }];
        } else {
            [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
            }];
        }
        return self;
    };
}

- (JZLayout * _Nonnull (^)(BOOL))update {
    return ^id(BOOL isUpdate) {
        self.isUpdate = isUpdate;
        return self;
    };
}

@end
