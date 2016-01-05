//
//  SummerCityModel.m
//  WeCommunity
//
//  Created by madarax on 16/1/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerCityModel.h"

@implementation SummerCityModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _code    = dic[@"code"];
        _enabled = dic[@"enabled"];
        _cityID  = dic[@"id"];
        _isHot   = dic[@"isHot"];
        _name    = dic[@"name"];
        _pinyin  = dic[@"pinyin"];
    }
    return self;
}

@end
