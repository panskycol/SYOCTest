//
//  MSAvatarSampleView.m
//  AiJiaoYou
//
//  Created by Wudi_Mac on 2019/4/29.
//  Copyright © 2019 User. All rights reserved.
//

#import "MSAvatarSampleView.h"


@interface MSAvatarSampleView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
//@property (strong, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liveHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBottomMarginConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *headCorrectImgView;

@property (weak, nonatomic) IBOutlet UIImageView *headError1;

@property (weak, nonatomic) IBOutlet UIImageView *headError3;

@property (weak, nonatomic) IBOutlet UIImageView *headError4;

@property (weak, nonatomic) IBOutlet UILabel *headError4Label;

@property (assign, nonatomic) SampleType type;

@end

@implementation MSAvatarSampleView

- (instancetype)initWithType:(SampleType)type{
    self = [super init];
    if (self) {
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"MSAvatarSampleView" owner:nil options:nil];
        self = [nibArr lastObject];
        self.type = type;
        [self setCustomStyle];
        self.frame = RECT(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tap];
}

- (void)setGender:(UserGender)gender {
    _gender = gender;
    
    if (self.gender == GenderFemale) {
        self.headCorrectImgView.image = [UIImage imageNamed:@"head_correct_img"];
        self.headError1.image = [UIImage imageNamed:@"head_error_1"];
        self.headError3.image = [UIImage imageNamed:@"head_error_4"];
        self.headError4.image = [UIImage imageNamed:@"head_error_8"];
        self.headError4Label.text = @"涉黄引诱";
        self.titleLb.text = @"请上传本人高清正面靓照";

    }else {
        self.headCorrectImgView.image = [UIImage imageNamed:@"head_correct_img_man"];
        self.headError1.image = [UIImage imageNamed:@"head_error_1_man"];
        self.headError3.image = [UIImage imageNamed:@"head_error_4_man"];
        self.headError4.image = [UIImage imageNamed:@"head_error_8_man"];
        self.headError4Label.text = @"衣不遮体";
        self.titleLb.text = @"请上传本人高清正面帅照";
    }
}

- (void)setCustomStyle{
        
    if (self.type == SampleTypeAvatar) {
        self.confirmBtn.hidden = YES;
        self.confirmHeightConstraint.constant = 0;
        self.liveHeightConstraint.constant = 0;
        [self.cancelBtn setTitle:@"我知道啦，去上传" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:RGBA(0, 122, 255, 1) forState:UIControlStateNormal];
    }else{
        self.confirmBtn.hidden = NO;
        self.confirmHeightConstraint.constant = 50;
         self.liveHeightConstraint.constant = 1;
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:RGBA(64, 64, 64, 1) forState:UIControlStateNormal];
    }
    
    if (iPhoneX) {
        self.cancelBottomMarginConstraint.constant = 30;
    } else {
        self.cancelBottomMarginConstraint.constant = 0;
    }
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, CGRectGetHeight(self.contentView.bounds));
    maskLayer.path = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
}

- (void)show{
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentViewBottomConstraint.constant = 0;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentViewBottomConstraint.constant = -UI_SCREEN_HEIGHT;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)checkBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
//    [UserInfoManager setHideUploadAvatarTip:sender.selected];
}

- (IBAction)confirmAction:(id)sender {
    [self hide];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self hide];
    if (self.type == SampleTypeAvatar){
        if (self.confirmBlock) {
            self.confirmBlock();
        }
    }
}

@end
