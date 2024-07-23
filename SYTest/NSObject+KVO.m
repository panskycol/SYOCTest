//
//  NSObject+KVO.m
//  SYTest
//
//  Created by Pan skycol on 2024/7/5.
//

#import "NSObject+KVO.h"

@implementation __NSObjectKVO

-(void)dealloc{
    [_target removeObserver:_observer forKeyPath:_keyPath];
    _target = nil;
    _observer = nil;
}

@end


@implementation NSObject (KVO)


- (void)sj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [self sj_addObserver:observer forKeyPath:keyPath context:NULL];
}

- (void)sj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    [self sj_addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:context];
    
    __NSObjectKVO *objKVO = [[__NSObjectKVO alloc] init];
    objKVO.target = self;
    objKVO.observer = observer;
    objKVO.keyPath = keyPath;
    
    self.kvoInfo = objKVO;
}

- (void)sj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)setKvoInfo:(__NSObjectKVO *)kvoInfo{
    objc_setAssociatedObject(self, @selector(kvoInfo), kvoInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (__NSObjectKVO *)kvoInfo{
    return objc_getAssociatedObject(self, @selector(kvoInfo));
}

//- (void)setTarget:(id)target{
//    objc_setAssociatedObject(self, @selector(target), target, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (id)target{
//    return objc_getAssociatedObject(self, @selector(target));
//}
//
//- (void)setObserver:(id)observer{
//    objc_setAssociatedObject(self, @selector(observer), observer, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (id)observer{
//    return objc_getAssociatedObject(self, @selector(observer));
//}
//
//-(void)setKeyPath:(NSString *)keyPath{
//    
//    objc_setAssociatedObject(self, @selector(keyPath), keyPath, OBJC_ASSOCIATION_COPY);
//}
//
//- (NSString *)keyPath{
//    return objc_getAssociatedObject(self, @selector(keyPath));
//}


@end
