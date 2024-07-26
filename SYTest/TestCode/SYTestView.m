//
//  SYTestView.m
//  SYTest
//
//  Created by Pan skycol on 2024/7/22.
//

#import "SYTestView.h"

@interface SYTestView ()

@property (nonatomic, copy) void(^heapBlock)(void);

@end

@implementation SYTestView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        __block int age = 10;
        NSLog(@"age_address1:%p  %d", &age, age);
        void (^stackBlock)(void) = ^{
            NSLog(@"age_address2:%p  %d", &age, age);
        };
        
        // 执行栈上的 Block
        stackBlock();
        NSLog(@"age_address3:%p  %d", &age, age);
        
        // 将 Block 拷贝到堆上
        self.heapBlock = stackBlock;
        
        age = 30;
        NSLog(@"age_address4:%p  %d", &age, age);
        // 执行堆上的 Block
        _heapBlock();
        NSLog(@"age_address5:%p  %d", &age, age);
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"====%s == name:%@",__func__,self.name);
    if ([self.name isEqualToString:@"C"]) {  //遇到C视图就会被穿透过去，下面C的touches事件不再走
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s == name:%@",__func__,self.name);
    
    [super touchesBegan:touches withEvent:event];
}


@end
