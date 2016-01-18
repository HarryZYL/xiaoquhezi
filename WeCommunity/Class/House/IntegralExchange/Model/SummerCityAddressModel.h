//
//  SummerCityAddressModel.h
//  WeCommunity
//
//  Created by madarax on 16/1/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SummerDistrictModel.h"

@interface SummerCityAddressModel : NSObject
@property(nonatomic,copy)NSString *strCode;
@property(nonatomic,copy)NSString *strEnabled;
@property(nonatomic,copy)NSString *strID;
@property(nonatomic,copy)NSString *strName;
@property(nonatomic,copy)NSString *strPinYin;
@property(nonatomic,strong)NSMutableArray *districtArrary;
- (instancetype)initWithData:(NSDictionary *)dic;

@end
