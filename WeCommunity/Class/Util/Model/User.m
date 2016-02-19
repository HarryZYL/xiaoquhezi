//
//  User.m
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import <objc/runtime.h>
#import "User.h"
#import "BPush.h"
#import "FileManager.h"

@implementation User
static User *shareUserModel = nil;
+ (User *)shareUserDefult{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareUserModel = [[self alloc] init];
    });
    return shareUserModel;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (unsigned int index = 0; index < count; index ++) {
        Ivar ivars = ivar[index];
        const char *name = ivar_getName(ivars);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [User shareUserDefult];
    if (self) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (unsigned int index = 0; index < count; index ++) {
            Ivar ivars = ivar[index];
            const char *name = ivar_getName(ivars);
            NSString *strName = [NSString stringWithUTF8String:name];
            
            id value = [aDecoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

- (void) initWithData:(NSDictionary *)dataAll {
    NSDictionary *data     = dataAll[@"user"];
    self.Userid            = data[@"id"];
    self.token             = dataAll[@"token"];
    self.userName          = data[@"userName"];
    self.continuousSignDay = data[@"continuousSignDay"];
    self.nickName          = data[@"nickName"];
    self.job               = data[@"job"];
    self.point             = data[@"point"];
    self.sex               = data[@"sex"];
    self.sexName           = data[@"sexName"];
    self.totalSignDay      = data[@"totalSignDay"];
    self.userType          = data[@"userType"];
    self.userTypeName      = data[@"userTypeName"];
    self.lastSignTime      = [Util formattedDate:data[@"lastSignTime"] type:1];
    self.createTime        = [Util formattedDate:data[@"createTime"] type:1];
    self.communityId       = data[@"communityId"];
    self.headPhoto         = [NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"headPhoto"]]];
    self.continuousSignDay = data[@"continuousSignDay"];
    self.userJinDic        = [[SummerJinMaHuiModel alloc] initWithData:data[@"memberUser"]];
    self.hobby             = data[@"hobby"];
    
    if ([User getUserToken] && [BPush getChannelId] && self.Userid) {
        [Networking retrieveData:get_Baidu_Push parameters:@{@"token": self.token,@"userId":[BPush getUserId],@"channelId":[BPush getChannelId],@"deviceType":@"iOS"}];
    }
    [self saveKeyUnarchiver];
}

- (void)saveKeyUnarchiver{
    User *userModel = [User shareUserDefult];
    NSString *strFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/UserModel.archiver"];
    
    BOOL saveSucess = [NSKeyedArchiver archiveRootObject:userModel toFile:strFilePath];
    if (saveSucess) {
        NSLog(@"归档成功");
    }
}

+ (void)getUserModel{
    User *userModel = [User shareUserDefult];
    NSString *strFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/UserModel.archiver"];
    userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:strFilePath];
}

+(NSString*)getUserToken{
    User *userModel = [User shareUserDefult];
    return userModel.token;
}

//判断是否登录了
+(BOOL)judgeLogin{
    NSString *wxIDd = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ID"];
    User *userModel = [User shareUserDefult];
    
    if (wxIDd.length < 1 || wxIDd == nil) {
        if ([userModel.loginUserName isEqualToString:@"0"] || [userModel.loginUserName length] < 1 || userModel.loginUserName == nil || userModel.loginPassword == nil || [userModel.loginPassword isEqualToString:@"0"]) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}


//用户登陆
+(void)login{
    NSString *wxIDd = [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ID"];
    NSDictionary *parameters;
    NSString *strUrl;
    User *userModel = [User shareUserDefult];
    if (wxIDd.length < 1) {
        if (userModel.loginUserName == nil||userModel.loginPassword == nil) {
            return;
        }
        parameters = @{@"phoneNumber":userModel.loginUserName,@"password":userModel.loginPassword,@"userLoginType":@"IPhone"};
        strUrl = phoneLogin;
    }else{
        parameters = @{@"accountType":@"WeiXin",@"thirdId":[[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ID"],@"userId":userModel.Userid,@"userLoginType":@"IPhone"};
        strUrl = get_WXAPP_LOADING;
    }
    
    [Networking retrieveData:strUrl parameters:parameters success:^(id responseObject) {
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        
        [[User shareUserDefult] initWithData:data];
        [User SaveAuthentication];
    }];
    
}

+(void)SaveAuthentication{
    
    NSString *communityID = @"1";
    if ([Util judgeChooseCommunity]) {
        communityID =[Util getCommunityID];
    }
    
    [Networking retrieveData:getAuthenticationStatus parameters:@{@"token":[User getUserToken],@"communityId":communityID} success:^(id responseObject) {
        
        NSString *event = [NSString stringWithFormat:@"%@",responseObject];
        
        if ([event isEqualToString:@"<null>"]) {
            
            NSDictionary *authentication = @{
                                             @"communityName":@"",
                                             @"addressName":@"",
                                             @"owerType":@"未认证"
                                             };
            
            [FileManager saveDataToFile:authentication filePath:@"Authentication"];
            
            
        }else{
            NSString *owerType = @"";
            if([responseObject[@"auditStatus"] isEqualToString:@"Success"]){
                if ([responseObject[@"ownerType"] isEqualToString:@"Owner"]) {
                    owerType = @"户主";
                }else if ([responseObject[@"ownerType"] isEqualToString:@"NoOwner"]){
                    owerType = @"业主";
                }
            }else if([responseObject[@"auditStatus"] isEqualToString:@"Pending"]){
                 owerType = @"未受理";
            }else{
                owerType = @"认证中";
            }
            NSDictionary *authentication = @{
                                             @"communityName":responseObject[@"community"][@"name"],
                                             @"addressName":[NSString stringWithFormat:@"%@%@",responseObject[@"buildingName"],responseObject[@"houseName"]],
                                             @"owerType":owerType
                                             };
            [FileManager saveDataToFile:authentication filePath:@"Authentication"];
        }
    }];

}

+(NSString*)getAuthenticationAddress{
    NSDictionary *dataAll = [FileManager getData:@"Authentication"];
    return dataAll[@"addressName"];
}

+(NSString*)getAuthenticationOwnerType{
    NSDictionary *dataAll = [FileManager getData:@"Authentication"];
    return dataAll[@"owerType"];
}


@end
