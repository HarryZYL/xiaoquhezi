//
//  SummerGetUserLocation.h
//  WeCommunity
//
//  Created by madarax on 15/10/23.
//  Copyright © 2015年 Harry. All rights reserved.
//  本来封装一下定位的，但是代理不执行

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface SummerGetUserLocation : NSObject<BMKLocationServiceDelegate>

@property (nonatomic, strong)BMKLocationService *locationService;

- (id)initWithLocaiton;
- (void)startGetUserLocation;

@end
