//
//  SYGestureViewController.m
//  SYTest
//
//  Created by Pan skycol on 2024/3/26.
//

#import "SYGestureViewController.h"
#import "NSObject+KVO.h"
#import "SYPersonModel.h"

@interface SYGestureViewController ()

@end

@implementation SYGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // SYPersonModel 添加了int age、NSinteger sex 两个属性
    SYPersonModel *model = [[SYPersonModel alloc] init];
    //  24   32
    _model = NULL;
    
//    [self sj_addObserver:self.model forKeyPath:@"age"];
    NSLog(@"%ld ==== %ld",[[SYPersonModel shareInstance] arcDebugRetainCount], [self arcDebugRetainCount]);
    [[SYPersonModel shareInstance] addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSLog(@"%ld ==== %ld",[[SYPersonModel shareInstance] arcDebugRetainCount], [self arcDebugRetainCount]);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 30);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)dealloc{
    
    NSLog(@"======SYGestureViewController dealloc");
}

- (void)onClick1{
    _model.age = 3;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"");
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    
    [super willMoveToParentViewController:parent];
}
 
- (void)didMoveToParentViewController:(UIViewController *)parent{
    
    [super didMoveToParentViewController:parent];
}
@end
