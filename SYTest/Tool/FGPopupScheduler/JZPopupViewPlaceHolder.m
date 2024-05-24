//
//  JZPopupViewPlaceHolder.m
//  JZPopupSchedulerDemo
//
//  Created by FoneG on 2021/11/8.
//

#import "JZPopupViewPlaceHolder.h"

@interface JZPopupViewPlaceHolder ()
@property (nonatomic, strong) NSObject *target;
@end

@implementation JZPopupViewPlaceHolder

- (void)dealloc{
    NSLog(@"asdasdas");
}


+ (instancetype)generatePlaceHolderWith:(NSObject *)RealPopView{
    JZPopupViewPlaceHolder *handler = [JZPopupViewPlaceHolder new];
    handler.target = RealPopView;
    return handler;
}

- (void)showPopupView{
    if (self.showPopupViewCallBlock) {
        __weak NSObject *weakTarget = self.target;
        self.showPopupViewCallBlock(weakTarget);
    }
}

- (void)dismissPopupView{
    if (self.removePopupViewCallBlock) {
        __weak NSObject *weakTarget = self.target;
        self.removePopupViewCallBlock(weakTarget);
    }
}

@end
