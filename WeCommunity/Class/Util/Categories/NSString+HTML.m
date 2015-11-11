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
    NSString *MOBILE = @"^1[3|4|5|8|][0-9]\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:phoneNumer];
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
