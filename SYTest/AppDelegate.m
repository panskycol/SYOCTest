//
//  AppDelegate.m
//  SYTest
//
//  Created by Pan skycol on 2024/2/28.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WOCrashProtectorManager.h"
#import "JZBasePopupView.h"
#import <Matrix/Matrix.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<MatrixPluginListenerDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *vc = [[ViewController alloc] init];
    vc.title = @"导航栏";
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = navVc;
    
//    UINavigationController *navVc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[navVc];
    self.window.rootViewController = tabVC;
    
//    [WOCrashProtectorManager makeAllEffective];
    
    Matrix *matrix = [Matrix sharedInstance];
    MatrixBuilder *curBuilder = [[MatrixBuilder alloc] init];
    curBuilder.pluginListener = self; // pluginListener 回调 plugin 的相关事件
        
    WCCrashBlockMonitorPlugin *crashBlockPlugin = [[WCCrashBlockMonitorPlugin alloc] init];
    [curBuilder addPlugin:crashBlockPlugin]; // 添加卡顿和崩溃监控
        
    WCMemoryStatPlugin *memoryStatPlugin = [[WCMemoryStatPlugin alloc] init];
    [curBuilder addPlugin:memoryStatPlugin]; // 添加内存监控功能

    WCFPSMonitorPlugin *fpsMonitorPlugin = [[WCFPSMonitorPlugin alloc] init];
    [curBuilder addPlugin:fpsMonitorPlugin]; // 添加 fps 监控功能
        
    [matrix addMatrixBuilder:curBuilder];
        
    [crashBlockPlugin start]; // 开启卡顿和崩溃监控
    [memoryStatPlugin start]; // 开启内存监控
    [fpsMonitorPlugin start]; // 开启 fps 监控
    
    [self registerAPN];
    
    return YES;
}

// 注册通知
- (void)registerAPN {

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
}

// 接收到通知时触发的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSLog(@"");
    
    completionHandler(UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionSound);
}

// 点击通知时触发的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"");
    
    completionHandler();
}

- (void)onReportIssue:(MatrixIssue *)issue{
    
    NSLog(@"");
}


@end
