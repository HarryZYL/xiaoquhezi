//
//  SummerCityModel.h
//  WeCommunity
//
//  Created by madarax on 16/1/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerCityModel : NSObject

@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *enabled;
@property (nonatomic ,copy) NSString *cityID;
@property (nonatomic ,copy) NSString *isHot;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *pinyin;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
