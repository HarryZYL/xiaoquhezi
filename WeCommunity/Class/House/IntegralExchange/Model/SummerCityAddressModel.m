//
//  SummerCityAddressModel.m
//  WeCommunity
//
//  Created by madarax on 16/1/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerCityAddressModel.h"


@implementation SummerCityAddressModel
- (instancetype)initWithData:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _strCode = dic[@"code"];
        _strID = dic[@"id"];
        _strName = dic[@"name"];
        _strPinYin = dic[@"pinyin"];
        _districtArrary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dicCity in dic[@"children"]) {
            [_districtArrary addObject:[[SummerDistrictModel alloc]initWithData:dicCity]];
        }
    }
    return self;
}
@end
