//
//  BasePopView.m
//  FGPopupSchedulerDemo
//
//  Created by FoneG on 2021/6/23.
//

#import "JZBasePopupView.h"

@implementation JZBasePopupView

@synthesize key;

@synthesize UntriggeredBehavior;

@synthesize superView;

- (instancetype)initWithDescrption:(NSString *)des scheduler:(nonnull FGPopupScheduler *)scheduler
{
    self = [super initWithFrame:CGRectMake(0, 0, 200, 300)];
    if (self) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1].CGColor;
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2].CGColor;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0,1);
        self.layer.cornerRadius = 4;
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = des;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self addSubview:label];
        
        _switchBehavior = FGPopupViewSwitchBehaviorAwait;
        _scheduler = scheduler;
    }
    return self;
}

- (void)showPopupView{
    NSLog(@"%s", __func__);
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
    if (self.superview) {
        [self.superview addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}

- (void)dismissPopupView{
    NSLog(@"%s", __func__);
    [super removeFromSuperview];  //这里要使用super, 不然出现死循环
}

- (void)removeFromSuperview{
    [self dismissPopupView];
    [super removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchCallBack) {
        self.touchCallBack();
    }else{
        [self dismissPopupView];
    }
}

- (FGPopupViewSwitchBehavior)popupViewSwitchBehavior{
    return self.switchBehavior;
}

- (void)dealloc{
    
    NSLog(@"JZBasePopupView %@ %s", self.key ,__func__);
}

@end
