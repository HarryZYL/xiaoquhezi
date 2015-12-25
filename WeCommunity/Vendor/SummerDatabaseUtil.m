//
//  SummerDatabaseUtil.m
//  WeCommunity
//
//  Created by madarax on 15/12/25.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerDatabaseUtil.h"

@implementation SummerDatabaseUtil
static FMDatabase *db = nil;
+ (FMDatabase *)shareDatabaseUtil{
    static dispatch_once_t present;
    dispatch_once(&present, ^{
        db = [FMDatabase databaseWithPath:[self getPath]];
    });
    return db;
}

+ (NSString *)getPath{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"Documents/xiaoquhezi.sqlite"];
    return path;
}

@end
