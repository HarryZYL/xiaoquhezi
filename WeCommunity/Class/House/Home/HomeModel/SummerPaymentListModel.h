//
//  SummerPaymentListModel.h
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummerPaymentListModel : NSObject

@property (nonatomic ,copy) NSString *communityName;
@property (nonatomic ,copy) NSString *dates;
@property (nonatomic ,copy) NSString *fee;
@property (nonatomic ,copy) NSString *orderNO;
@property (nonatomic ,copy) NSString *parentNames;
@property (nonatomic ,copy) NSString *payTime;
@property (nonatomic ,copy) NSString *propertyName;

- (instancetype)initWithJson:(NSDictionary *)json;

@end
