//
//  AppDelegate.m
//  iOSToday
//
//  Created by 王文杰 on 16/10/12.
//  Copyright © 2016年 王文杰. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate (){

    
    RootViewController *_rootViewController;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _rootViewController = [[RootViewController alloc]init];
    self.window.rootViewController = _rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
//    UINavigationController * nav = (UINavigationController*)[customTabBarController.viewControllers objectAtIndex:0];
//    
//    if ([ctrlString isEqual:@"sdmcc://WWJBillqueryViewController"]) {
//        WWJBillqueryViewController * wWJBillqueryViewController = [[WWJBillqueryViewController alloc]init];
//        
//        [nav pushViewController:wWJBillqueryViewController animated:YES];
//        
//        
//    }if ([ctrlString isEqual:@"sdmcc://http://m.sd.10086.cn/sdActivity/activityCenter/goCheckAppType.do?value=activity"]) {
//        
//        XWWebViewController * web = [[XWWebViewController alloc]init];
//        web.url =@"http://m.sd.10086.cn/sdActivity/activityCenter/goCheckAppType.do?value=activity";
//        [nav pushViewController:web animated:YES];
//        
//    }if ([ctrlString isEqual:@"sdmcc://CCChargeViewController"]) {
//        CCChargeViewController * cCChargeViewController = [[CCChargeViewController alloc]init];
//        [nav pushViewController:cCChargeViewController animated:YES];
//        
//    }if ([ctrlString isEqual:@"sdmcc://LoginViewController"]) {
//        
//        LoginViewController *loginViewController = [[LoginViewController alloc]init];
//        [nav presentViewController:loginViewController animated:YES completion:nil];
//        
//    }
    return NO;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
