//
//  SYPersonModel.m
//  SYTest
//
//  Created by Pan skycol on 2024/7/4.
//

#import "SYPersonModel.h"

@implementation SYPersonModel

//+ (void)load{
//    
//    NSLog(@"======SYPersonModel");
//}

+ (instancetype)shareInstance{
    static SYPersonModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[SYPersonModel alloc] init];
    });
    return model;
}

- (void)dealloc{
    
    NSLog(@"======SYPersonModel dealloc");
}

@end
