//
//  SummerDatabaseUtil.h
//  WeCommunity
//
//  Created by madarax on 15/12/25.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SummerDatabaseUtil : NSObject

+ (FMDatabase *)shareDatabaseUtil;

@end
