//
//  AppDelegate.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate, BMKLocationServiceDelegate ,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager *mapManager;

@property (strong, nonatomic) BMKLocationService *serviceLocation;

@end

