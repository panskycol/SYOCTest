//
//  JZTipInfoAlertViewTableViewCell.m
//  JinZuan
//
//  Created by Pan skycol on 2024/4/25.
//

#import "JZHelpInfoAlertViewTableViewCell.h"


@interface JZHelpInfoAlertViewTableViewCell ()

@property (nonatomic, strong) JZLabel *contetLb;
@property (nonatomic, strong) JZButton *checkBtn;

@end

@implementation JZHelpInfoAlertViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _contetLb = JZLabel.label.container(self.contentView).fnt([UIFont systemFontOfSize:14]);
    _contetLb.lines(0);
    [_contetLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(36);
        make.right.mas_equalTo(-36);
    }];
}


- (void)setContent:(NSString *)content{
    
    _content = content;
    if (IsStrEmpty(content)) {
        return;
    }
    NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc] initWithString:content];
    [arrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, content.length)];
    [arrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, content.length)];

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5; //设置行间距
    [arrStr setParagraphStyle:paraStyle];
    
    _contetLb.attributedText = arrStr;
}

@end
