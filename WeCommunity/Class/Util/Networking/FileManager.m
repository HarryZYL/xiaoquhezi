//
//  FileManager.m
//  WeCommunity
//
//  Created by Harry on 8/6/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

// 从本地系统里获得数据
+(NSDictionary*)getData:(NSString*)filePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:filePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
        //从本地读缓存文件
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:cachesDirectory];
        return data;
    }else {
        return nil;
    }
   
}

// 把数据（保存）到系统里
+(void)saveDataToFile:(NSDictionary*)data filePath:(NSString*)filePath{
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:filePath];
    
    if (![fileManager fileExistsAtPath:cachesDirectory]) {
        
        [fileManager createFileAtPath:cachesDirectory contents:nil attributes:nil];
        
    }
    
    [data writeToFile:cachesDirectory atomically:YES];
}
@end
