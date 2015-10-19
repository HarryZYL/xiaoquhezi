//
//  FileManager.h
//  WeCommunity
//
//  Created by Harry on 8/6/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
//获取文件路径
+(NSDictionary*)getData:(NSString*)filePath;
//保存文件
+(void)saveDataToFile:(NSDictionary*)data filePath:(NSString*)filePath;
@end
