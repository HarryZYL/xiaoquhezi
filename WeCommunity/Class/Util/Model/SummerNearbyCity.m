//
//  SummerNearbyCity.m
//  WeCommunity
//
//  Created by madarax on 15/10/23.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNearbyCity.h"

@implementation SummerNearbyCity

- (instancetype)initWithData:(NSDictionary *)returnData{
    if (self = [super init]) {
        self.baiduPosLati = returnData[@"baiduPosLati"];
        self.baiduPosLong = returnData[@"baiduPosLong"];
        self.cityCode = returnData[@"cityCode"];
        self.distance = returnData[@"distance"];
        self.districtCode = returnData[@"districtCode"];
        self.nearbyID = returnData[@"id"];
        self.nearbyName = returnData[@"name"];
        self.propertyID = returnData[@"propertyId"];
        self.provinceCode = returnData[@"provinceCode"];
        self.roadName = returnData[@"roadName"];
    }
    return self;
}

@end
