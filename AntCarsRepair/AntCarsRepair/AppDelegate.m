//
//  AppDelegate.m
//  AntCarsRepair
//
//  Created by 宇中 on 2018/6/7.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "LRTabBarController.h"
#import "LRNavigationViewController.h"
#import "LRHomeViewController.h"
#import "LRLoginViewController.h"
// 高德 SDK头文件
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    /*
    LRHomeViewController *vc = [[LRHomeViewController alloc] init];
    vc.title = @"首页";
    self.window.rootViewController = [[LRNavigationViewController alloc] initWithRootViewController:[LRLoginViewController new]];
    */
    self.window.rootViewController = [LRTabBarController new];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    // 高德APIKey
    [AMapServices sharedServices].apiKey = @"790f89aaf8d84cf7d74a4e2b65db3d83";
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    // 自动处理键盘弹出事件
    [self setupIQKeyboardManager];
    
    return YES;
}

///自动处理键盘弹出事件
- (void)setupIQKeyboardManager{
    // 自动处理键盘弹出事件
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用 禁用要把enableAutoToolbar也设置为NO
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    //keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
    //[[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:[您的Controller class]];//在AppDelegate.m的didFinishlanuch中调用这个方法就可以了。 后面是你Controller的名字。这个是禁用某些界面使用IQKeyboard
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
