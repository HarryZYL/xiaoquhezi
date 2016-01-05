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

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init] && aDecoder) {
        _roadName = [aDecoder decodeObjectForKey:@"roadName"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _distance = [aDecoder decodeObjectForKey:@"distance"];
        _cityID = [aDecoder decodeObjectForKey:@"cityID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_roadName forKey:@"roadName"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_distance forKey:@"distance"];
    [aCoder encodeObject:_cityID forKey:@"cityID"];
}

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
