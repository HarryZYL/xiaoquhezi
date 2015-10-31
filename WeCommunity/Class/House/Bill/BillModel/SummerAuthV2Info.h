//
//  SummerAuthV2Info.h
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerAuthV2Info : NSObject
@property(nonatomic,copy)NSString *apiName;
@property(nonatomic,copy)NSString *appName;
@property(nonatomic,copy)NSString *appID;
@property(nonatomic,copy)NSString *bizType;
@property(nonatomic,copy)NSString *pid;
@property(nonatomic,copy)NSString *productID;
@property(nonatomic,copy)NSString *scope;
@property(nonatomic,copy)NSString *targetID;
@property(nonatomic,copy)NSString *authType;
@property(nonatomic,copy)NSString *signDate;
@property(nonatomic,copy)NSString *service;



- (NSString *)description;

@end
