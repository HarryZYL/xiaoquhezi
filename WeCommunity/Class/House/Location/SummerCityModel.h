//
//  SummerCityModel.h
//  WeCommunity
//
//  Created by madarax on 15/12/25.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerCityModel : NSObject<NSCoding>

@property(nonatomic,copy)NSString *cityID;
@property(nonatomic,copy)NSString *roadName;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *distance;

- (id)initWithData:(NSDictionary *)dic;

@end
