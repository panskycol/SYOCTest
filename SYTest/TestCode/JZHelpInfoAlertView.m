//
//  JZTipInfoAlertView.m
//  JinZuan
//
//  Created by Pan skycol on 2024/4/25.
//

#import "JZHelpInfoAlertView.h"
#import "JZHelpInfoAlertViewTableViewCell.h"
#import <SDWebImage/SDWeakProxy.h>

@interface JZHelpInfoAlertView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JZView *contentView;
@property (nonatomic, strong) JZImageView *iconImgView;
@property (nonatomic, strong) JZButton *closeBtn;

@property (nonatomic, strong) JZTableView *tableView;
@property (nonatomic, strong) JZButton *confirmBtn;

@end

@implementation JZHelpInfoAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _contentView = JZView.view.container(self);
    _contentView.backgroundColor = UIColor.whiteColor;
    _contentView.layerMgr.corner(20);
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
    }];
    
    _titleLb = JZLabel.label.container(_contentView)
        .txt(@"")
        .txtColor([JZColor blackColor])
        .fnt([JZFont systemFontOfSize:18]);
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.top.equalTo(_contentView).offset(30);
    }];
    
    _tableView = JZTableView.tableView.container(_contentView);
    _tableView.delegateTarget(self);
    _tableView.dataSourceTarget(self);
    _tableView.backgroundColor = [JZColor clearColor];
    _tableView.rClass(JZHelpInfoAlertViewTableViewCell.class, NSStringFromClass(JZHelpInfoAlertViewTableViewCell.class));
    _tableView.estimatedRowH(UITableViewAutomaticDimension);
    _tableView.sepaStyle(UITableViewCellSeparatorStyleNone);
    _tableView.scrollEnabled = NO;
    _tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).offset(11);
        make.left.right.equalTo(_contentView);
        make.height.equalTo(@0);
    }];
    
    WeakSelf(self);
    [self.KVOController observe:_tableView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
        if (!CGSizeEqualToSize(newSize, oldSize)) {
            [weakself.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(newSize.height));
            }];
        }
    }];
    
    self.confirmBtn = JZButton.button.title(@"我知道了").container(_contentView)
        .txtColor([JZColor whiteColor],UIControlStateNormal)
        .fnt([JZFont systemFontOfSize:16])
        .action(self, @selector(summitClick));
    UIImage *imge = [UIImage createImageWithSize:CGSizeMake(10, 10) startColor:[UIColor colorWithHexString:@"#F96653"] endColor:[UIColor colorWithHexString:@"#F71F70"] cornerRadius:0];
    [self.confirmBtn setBackgroundImage:imge forState:UIControlStateNormal];
    self.confirmBtn.layerMgr.corner(22);
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(24);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@44);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-30);
    }];
    
    _titleLb.text = @"测试";
    [self.tableView reloadData];
}

- (void)summitClick{
    
    [self removeFromSuperview];
//    [JZRouterService goToWithParseUrl:_model.tag];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZHelpInfoAlertViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(JZHelpInfoAlertViewTableViewCell.class)];
    cell.content = @"点击富士康九分裤设计费立卡随机发索拉卡发撒理发卡受打击发啦看";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

@end
