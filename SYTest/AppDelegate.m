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

@interface AppDelegate ()

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
    
    return YES;
}


@end
