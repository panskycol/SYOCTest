//
//  JZAnim.m
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/10/14.
//

#import "JZAnim.h"

@implementation JZAnim

- (JZAnim * _Nonnull (^)(void))blink {
    return ^id(void) {
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 1.0;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        animation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:12/100.0],
                               [NSNumber numberWithFloat:24/100.0],
                               [NSNumber numberWithFloat:36/100.0],
                               [NSNumber numberWithFloat:50/100.0],
                               [NSNumber numberWithFloat:60/100.0],
                               [NSNumber numberWithFloat:70/100.0],
                               [NSNumber numberWithFloat:1.0]];
        animation.repeatCount = MAXFLOAT;
        animation.autoreverses = NO;
        [self.view.layer addAnimation:animation forKey:@"accostAnimation"];
        return self;
    };
}

- (JZAnim * _Nonnull (^)(CGPoint, CGPoint))move {
    
    return ^id(CGPoint fromPosition, CGPoint endPosition) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration = 1.0;
        animation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        animation.toValue = [NSValue valueWithCGPoint:endPosition];
        [self.view.layer addAnimation:animation forKey:@"moveAnimation"];

        return self;
    };
}

- (JZAnim * _Nonnull (^)(JZAnimRotation))rotation {
    return ^id (JZAnimRotation rotationType) {
        NSString *keyPath;
        if (rotationType == JZAnimRotationUpDown) {
            keyPath = @"transform.rotation.y";
        }else {
            keyPath = @"transform.rotation.x";
        }
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
        animation.duration = 1;
        animation.fromValue = @(0);
        animation.toValue = @(M_PI);
        [self.view.layer addAnimation:animation forKey:@"rotateAnimation"];

        return self;
    };
}

- (JZAnim * _Nonnull (^)(CGFloat, CGFloat))scale {
    return ^id (CGFloat fromScale, CGFloat toScale) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.duration = 1.0;
        animation.repeatCount = 1;
        animation.fromValue = @(fromScale);
        animation.toValue = @(toScale);
        [self.view.layer addAnimation:animation forKey:@"scaleAnimation"];
        
        return self;
    };
}

#define kAngleToradian(x) ((x)/180.0*M_PI)
- (JZAnim * _Nonnull (^)(void))shake {
    return ^id (void) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        animation.duration = 0.6;
        animation.repeatCount = 5;
        animation.values = @[@(kAngleToradian(-5)), @(kAngleToradian(5)), @(kAngleToradian(-5))];
        
        [self.view.layer addAnimation:animation forKey:@"shakeAnimation"];
        return self;
    };
}

@end
