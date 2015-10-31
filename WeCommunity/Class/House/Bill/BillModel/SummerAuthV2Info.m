//
//  SummerAuthV2Info.m
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerAuthV2Info.h"

@implementation SummerAuthV2Info

- (NSString *)description
{
    if (self.appID.length != 16||self.pid.length != 16) {
        return nil;
    }
    NSArray *decriptionArray = @[[NSString stringWithFormat:@"app_id=\"%@\"", self.appID],
                                 [NSString stringWithFormat:@"pid=\"%@\"", self.pid],
                                 [NSString stringWithFormat:@"apiname=\"%@\"", self.apiName?self.apiName:@"com.alipay.account.auth"],
                                 [NSString stringWithFormat:@"app_name=\"%@\"", self.appName?self.appName:@"mc"],
                                 [NSString stringWithFormat:@"biz_type=\"%@\"", self.bizType?self.bizType:@"openservice"],
                                 [NSString stringWithFormat:@"product_id=\"%@\"", self.productID?self.productID:@"WAP_FAST_LOGIN"],
                                 [NSString stringWithFormat:@"scope=\"%@\"", self.scope?self.scope:@"kuaijie"],
                                 [NSString stringWithFormat:@"target_id=\"%@\"", self.targetID?self.targetID:@"20141225xxxx"],
                                 [NSString stringWithFormat:@"auth_type=\"%@\"", self.authType?self.authType:@"AUTHACCOUNT"],
                                 [NSString stringWithFormat:@"sign_date=\"%@\"", self.signDate?self.signDate:@"2014-12-25 00:00:00"],
                                 [NSString stringWithFormat:@"service=\"%@\"", self.service?self.service:@"mobile.securitypay.pay"]];
    
    return [decriptionArray componentsJoinedByString:@"&"];
    
}

@end
