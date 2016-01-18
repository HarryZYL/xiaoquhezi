//
//  SummerDistrictModel.m
//  WeCommunity
//
//  Created by madarax on 16/1/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerDistrictModel.h"

@implementation SummerDistrictModel
- (instancetype)initWithData:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _strCode = dic[@"code"];
        _strID = dic[@"id"];
        _strName = dic[@"name"];
        _strPinYin = dic[@"pinyin"];
    }
    return self;
}
@end
