//
//  SummerCitysDao.m
//  WeCommunity
//
//  Created by madarax on 16/1/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerCitysDao.h"

@implementation SummerCitysDao

+ (void)insertNumberOfCitys:(NSArray *)arrary{
    FMDatabase *db = [SummerDatabaseUtil shareDatabaseUtil];
    if (![db open]) {
        NSLog(@"打开失败");
        return;
    }
    [db setShouldCacheStatements:YES];
    if (![db tableExists:@"CITYS_NAME"]) {
        [db executeUpdate:@"CREATE TABLE CITYS_NAME(code TEXT,enabled TEXT,cityID TEXT,name TEXT,pinyin TEXT)"];
    }
    for (NSDictionary *dic in arrary) {
        [db executeUpdate:@"INSERT INTO CITYS_NAME(code,enabled,cityID,name,pinyin) VALUES(?,?,?,?,?)",dic[@"code"],dic[@"enabled"],dic[@"id"],dic[@"name"],dic[@"pinyin"]];
    }
    [db clearCachedStatements];
    [db close];
}

+ (NSArray *)selectCitysItem{
    NSMutableArray *arrary = [[NSMutableArray alloc] initWithCapacity:0];
    FMDatabase *db = [SummerDatabaseUtil shareDatabaseUtil];
    if (![db open]) {
        NSLog(@"打开失败");
        return nil;
    }
    [db setShouldCacheStatements:YES];
    if (![db tableExists:@"CITYS_NAME"]) {
        [db executeUpdate:@"CREATE TABLE CITYS_NAME(code TEXT,enabled TEXT,cityID TEXT,name TEXT,pinyin TEXT)"];
    }
    FMResultSet *set = [db executeQuery:@"SELECT * FROM CITYS_NAME"];
    while ([set next]) {
        NSMutableDictionary *dicTem = [[NSMutableDictionary alloc] init];
        [dicTem setObject:[set stringForColumn:@"code"] forKey:@"code"];
        [dicTem setObject:[set stringForColumn:@"cityID"] forKey:@"id"];
        [dicTem setObject:[set stringForColumn:@"pinyin"] forKey:@"pinyin"];
        [dicTem setObject:[set stringForColumn:@"name"] forKey:@"name"];
        [arrary addObject:dicTem];
    }
    [db clearCachedStatements];
    [db close];
    return arrary;
}

@end
















