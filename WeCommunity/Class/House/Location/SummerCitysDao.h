//
//  SummerCitysDao.h
//  WeCommunity
//
//  Created by madarax on 16/1/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SummerDatabaseUtil.h"

@interface SummerCitysDao : NSObject

+ (void)insertNumberOfCitys:(NSArray *)arrary;
+ (NSArray *)selectCitysItem;

@end
