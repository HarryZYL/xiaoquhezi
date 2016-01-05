//
//  Networking.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id responseObject))ablock addition:(void (^)())ablock2;
+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters roomSuccess:(void(^)(id responseObject))ablock;

+(void)retrieveData:(NSString*)url parameters:(NSDictionary*)parameters;
+(void)upload:(NSMutableArray*)imageArr success:(void (^)(id responseObject))ablock;
+(void)uploadOne:(UIImage*)image success:(void (^)(id responseObject))ablock;
@end


























