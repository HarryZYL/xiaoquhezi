//
//  NSString+HTML.m
//  WeCommunity
//
//  Created by madarax on 15/10/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "NSString+HTML.h"

@implementation NSString(NSString_HTML)

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&nbsp;"] withString:@""];
    }
    return html;
}

+ (BOOL)filterPhoneNumber:(NSString *)phoneNumer{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumer] == YES)
        || ([regextestcm evaluateWithObject:phoneNumer] == YES)
        || ([regextestct evaluateWithObject:phoneNumer] == YES)
        || ([regextestcu evaluateWithObject:phoneNumer] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)filterIDCard:(NSString *)identityCard{
    if (identityCard.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (NSString *)filterUserAthuration:(NSString *)auditStatus withOwnerType:(NSString *)ownerType{
    NSString *owerType = @"";
    if([auditStatus isEqualToString:@"Success"]){
        if ([ownerType isEqualToString:@"Owner"]) {
            owerType = @"认证户主";
        }else if ([ownerType isEqualToString:@"NoOwner"]){
            owerType = @"认证业主";
        }
    }else if([auditStatus isEqualToString:@"Pending"]){
        owerType = @"未受理";
    }else if ([auditStatus isEqualToString:@"Handing"]){
        owerType = @"认证中";
    }else{
        owerType = @"认证失败";
    }
    return owerType;
}

@end
