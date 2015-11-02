//
//  NSString+HTML.h
//  WeCommunity
//
//  Created by madarax on 15/10/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_HTML)

+ (NSString *)filterHTML:(NSString *)html;
+ (BOOL)filterPhoneNumber:(NSString *)phoneNumer;
+ (BOOL)filterIDCard:(NSString *)identityCard;

/**
 *  认证状态
 *
 *  @param auditStatus
 *  @param ownerType
 *
 *  @return 认证状态字符串
 */
+ (NSString *)filterUserAthuration:(NSString *)auditStatus withOwnerType:(NSString *)ownerType;

@end
