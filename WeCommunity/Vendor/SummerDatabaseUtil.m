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
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        db =  [self creatDatabase];
    });
    return db;
}
+ (FMDatabase*)creatDatabase
{
    db = [FMDatabase databaseWithPath:[self getPath]];
    return db;
}
+ (NSString*)getPath
{
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* pathStr = [path  stringByAppendingPathComponent:@"xiaoquhezi.sqlite"];
    return pathStr;
}

@end
