//
//  AppDelegate.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customizeUserInterface];
    [self initBMKMapViewManagerAndNotification];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    [[PgyManager sharedPgyManager] startManagerWithAppId:@"1b3770561745742362df33e9c96817b2"];
//    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"1b3770561745742362df33e9c96817b2"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //注册成功，把deviceToken发给后台
    NSLog(@"------>%@",[[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
    NSLog(@"------>%@",deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //推送消息
    NSLog(@"----->%@",userInfo);
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
- (void)customizeUserInterface {
    // Customize the nav bar
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:77.0/255.0 green:192.0/255.0 blue:168.0/255.0 alpha:1.0]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackground"] forBarMetrics:UIBarMetricsDefault];
    

    NSDictionary *attributes = @{
                                 NSUnderlineStyleAttributeName: @1,
                                 NSForegroundColorAttributeName : THEMECOLOR,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:20]
                                 };
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];

    [[UINavigationBar appearance] setTintColor:THEMECOLOR];
    
    // Customize the tab bar
//    
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UITabBar *tabBar = tabBarController.tabBar;
//    tabBar.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:251.0/255.0 blue:245.0/255.0 alpha:1.0];
//    tabBar.tintColor =[UIColor colorWithRed:77.0/255.0 green:192.0/255.0 blue:168.0/255.0 alpha:1.0];
//    
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:2];
//    [tabBarItem1 setImage: [UIImage imageNamed:@"管家"] ];
//    [tabBarItem1 setSelectedImage: [[UIImage imageNamed:@"管家2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    // [tabBarItem2 setImage: [[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem2 setImage: [UIImage imageNamed:@"邻里"] ];
//    [tabBarItem2 setSelectedImage: [[UIImage imageNamed:@"邻里2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tabBarItem3 setImage: [UIImage imageNamed:@"local"]];
//    [tabBarItem3 setSelectedImage: [UIImage imageNamed:@"local"]];
//    [tabBarItem4 setImage: [UIImage imageNamed:@"个人主页"]];
//    [tabBarItem4 setSelectedImage: [[UIImage imageNamed:@"个人主页2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    
    
}

- (void)initBMKMapViewManagerAndNotification{
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"l6923BycoPgnF11rWXOAdLIG" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    if ([[UIDevice currentDevice] systemVersion].floatValue < 8.0) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }else{
        UIUserNotificationSettings * s =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:s];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    _serviceLocation = [[BMKLocationService alloc] init];
    _serviceLocation.delegate = self;
    [_serviceLocation startUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:userLocation.location.coordinate.longitude] forKey:@"USER_LONG"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:userLocation.location.coordinate.latitude] forKey:@"USER_LAT"];
    [_serviceLocation stopUserLocationService];
}

@end



























