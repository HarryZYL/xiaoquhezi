//
//  SummerGetUserLocation.m
//  WeCommunity
//
//  Created by madarax on 15/10/23.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerGetUserLocation.h"

@implementation SummerGetUserLocation

- (id)initWithLocaiton{
    if (self = [super init]) {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        [_locationService startUserLocationService];
    }
    return self;
}

- (void)startGetUserLocation{
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    [_locationService startUserLocationService];
}

#pragma mark - BMKLocationServiceDelegate

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"----->%@",userLocation);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"----->%@",userLocation);
}


@end
