//
//  SummerNearbyCity.h
//  WeCommunity
//
//  Created by madarax on 15/10/23.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerNearbyCity : NSObject

@property(nonatomic,copy)NSString *baiduPosLati;
@property(nonatomic,copy)NSString *baiduPosLong;
@property(nonatomic,copy)NSString *cityCode;
@property(nonatomic,copy)NSString *distance;
@property(nonatomic,copy)NSString *districtCode;
@property(nonatomic,copy)NSString *nearbyID;
@property(nonatomic,copy)NSString *nearbyName;
@property(nonatomic,copy)NSString *propertyID;
@property(nonatomic,copy)NSString *provinceCode;
@property(nonatomic,copy)NSString *roadName;

- (instancetype)initWithData:(NSDictionary *)returnData;

@end
