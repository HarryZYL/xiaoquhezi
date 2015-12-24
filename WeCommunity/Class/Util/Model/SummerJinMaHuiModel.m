//
//  SummerJinMaHuiModel.m
//  WeCommunity
//
//  Created by madarax on 15/12/24.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerJinMaHuiModel.h"

@implementation SummerJinMaHuiModel

- (instancetype)initWithData:(NSDictionary *)dic{
    if (self = [super init]) {
        _jinRealName = dic[@"realName"];
        _jinCardNumber = dic[@"cardNumber"];
        _jinLevel = dic[@"cardTypeLevel"];
        _jinPoint = dic[@"point"];
    }
    
    return self;
}

- (void)saveKeyUnarchiver:(SummerJinMaHuiModel *)dic{
    NSString *strFilePath = [NSHomeDirectory() stringByAppendingString:@"/JinModel.archiver"];
    BOOL saveSucess = [NSKeyedArchiver archiveRootObject:dic toFile:strFilePath];
    if (saveSucess) {
        NSLog(@"归档成功");
    }
}

- (void)getUserModel{
    User *userModel = [User shareUserDefult];
    NSString *strFilePath = [NSHomeDirectory() stringByAppendingString:@"/JinModel.archiver"];
    userModel.userJinDic = [NSKeyedUnarchiver unarchiveObjectWithFile:strFilePath];
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
    if (self = [super init]) {
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

@end
