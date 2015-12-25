//
//  SummerCityModel.m
//  WeCommunity
//
//  Created by madarax on 15/12/25.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerCityModel.h"

@implementation SummerCityModel

@synthesize roadName = _roadName,name = _name,distance = _distance,cityID = _cityID;


- (id)initWithData:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cityID = dic[@"id"];
        self.roadName = dic[@"roadName"];
        self.name = dic[@"name"];
        self.distance = dic[@"distance"];
    }
    return self;
}

@end
