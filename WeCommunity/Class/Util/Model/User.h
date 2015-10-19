//
//  User.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileManager.h"
@interface User : NSObject
//用户信息
@property (nonatomic,strong) NSString *Userid;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *nickName	;
@property (nonatomic,strong) NSString *userType;
@property (nonatomic,strong) NSString *userTypeName;
@property (nonatomic,strong) NSURL *headPhoto;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *sexName;
@property (nonatomic,strong) NSString *job;
@property (nonatomic,strong) NSString *hobby;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *communityId;
@property (nonatomic,strong) NSString *point;
@property (nonatomic,strong) NSString *continuousSignDay;
@property (nonatomic,strong) NSString *totalSignDay;
@property (nonatomic,strong) NSString *lastSignTime;
@property (nonatomic,strong) NSString *token;

- (id) initWithData;
+(NSString*)getUserToken;

+(BOOL)judgeLogin;
+(void)login;
+(void)SaveAuthentication;
+(NSString*)getAuthenticationAddress;
+(NSString*)getAuthenticationOwnerType;
@end
