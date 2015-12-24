//
//  SummerJinMaHuiModel.h
//  WeCommunity
//
//  Created by madarax on 15/12/24.
//  Copyright © 2015年 Jack. All rights reserved.
//  金马会

#import <Foundation/Foundation.h>

@interface SummerJinMaHuiModel : NSObject<NSCoding>

@property (nonatomic ,copy)NSString *jinRealName;
@property (nonatomic ,copy)NSString *jinCardNumber;
@property (nonatomic ,copy)NSString *jinPoint;
@property (nonatomic ,copy)NSString *jinLevel;

- (instancetype)initWithData:(NSDictionary *)dic;
@end
