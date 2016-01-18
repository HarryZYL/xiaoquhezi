//
//  AppDelegate.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import "AppDelegate.h"
#import <Bugly/CrashReporter.h>
#import <AlipaySDK/AlipaySDK.h>
//#import <PgySDK/PgyManager.h>
#import "SummerTabBarViewController.h"
#import "SummerRegisterID.h"
#import "ThirdUserModel.h"

#import "BPush.h"

@interface AppDelegate ()
{
    NSString *codeID;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customizeUserInterface];
    [self initBMKMapViewManagerAndNotificationwithLaunOptions:launchOptions withApplication:application];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"d4cd9e183269a551719cb63806f2ef52"];
//    [[PgyManager sharedPgyManager] setEnableFeedback:YES];
    [User getUserModel];
    [User login];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //注册成功，把deviceToken发给后台
    [BPush registerDeviceToken:deviceToken];
    
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        if (result) {
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //推送消息
    NSLog(@"----->%@",userInfo);
    if ([userInfo[@"dataType"] isEqualToString:@"accreditation"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Update_Accreditation" object:userInfo];
        [User login];
    }
    if ([userInfo[@"dataType"] isEqualToString:@"notice"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoticeUpdate" object:userInfo];
    }
    if ([userInfo[@"dataType"] isEqualToString:@"complaint"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ComplaintUpdate" object:userInfo];
    }
    if ([userInfo[@"dataType"] isEqualToString:@"repair"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RepairUpdate" object:userInfo];
    }
    
//    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
//        NSLog(@"acitve or background");
//        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
//    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    User *userModel = [User shareUserDefult];
    [userModel saveKeyUnarchiver];
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
    
    NSDictionary *attributes = @{
                                 NSUnderlineStyleAttributeName: @1,
                                 NSForegroundColorAttributeName : THEMECOLOR,
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:20]
                                 };
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];

    [[UINavigationBar appearance] setTintColor:THEMECOLOR];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"leftBill"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBar appearance] setTintColor:THEMECOLOR];
}

- (void)initBMKMapViewManagerAndNotificationwithLaunOptions:(NSDictionary *)launchOptins withApplication:(UIApplication *)application{
    [WXApi registerApp:@"wx8728578ba70796d9"];
    [[CrashReporter sharedInstance] installWithAppId:@"900015258"];
    [[CrashReporter sharedInstance] enableBlockMonitor:YES];
    
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"l6923BycoPgnF11rWXOAdLIG" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
//l6923BycoPgnF11rWXOAdLIG 发布环境
//T8GeKkoPAu6fEaVdWAFo7G7p 开发环境
    [BPush registerChannel:launchOptins apiKey:@"l6923BycoPgnF11rWXOAdLIG" pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:NO];
    NSDictionary *userInfo = [launchOptins objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"---->从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    _serviceLocation = [[BMKLocationService alloc] init];
    _serviceLocation.delegate = self;
    [_serviceLocation startUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:userLocation.location.coordinate.longitude] forKey:@"USER_LONG"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:userLocation.location.coordinate.latitude] forKey:@"USER_LAT"];
    [_serviceLocation stopUserLocationService];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPayWay" object:nil userInfo:@{@"WXSeccessOrFail": [NSNumber numberWithBool:YES],@"WXReturnModel":resp}];
            }
                break;
                
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPayWay" object:nil userInfo:@{@"WXSeccessOrFail":[NSNumber numberWithBool:NO],@"WXReturnModel":resp}];
                break;
        }
    }
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            codeID = aresp.code;
            //发送给后台
            [ThirdUserModel returnThirdLoadingUserModelWithCode:codeID];
        }
    }
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}

@end



























