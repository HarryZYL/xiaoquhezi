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
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    NSMutableString *strTempIDCard = [[NSMutableString alloc] initWithString:identityCard];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        switch (identityCard.length) {
            case 15:
            {
                [strTempIDCard insertString:@"19" atIndex:6];
                //校验是否在合适的年月日期
                return [self checkCodeOfBirthDay:[strTempIDCard substringWithRange:NSMakeRange(6, 8)]];
            }
                break;
            case 18:
            {
                if ([self checkCodeOfBirthDay:[strTempIDCard substringWithRange:NSMakeRange(6, 8)]]) {
                    return [self validateIDCardNumberCheckCode:strTempIDCard withFlag:flag];
                }
                return NO;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        return flag;
    }
    return NO;
}
//18号码校验码
+ (BOOL)validateIDCardNumberCheckCode:(NSString *)strTempIDCard withFlag:(BOOL)flag{
    //将前17位加权因子保存在数组里
    NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++)
    {
        NSInteger subStrIndex = [[strTempIDCard substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    
    //得到最后一位身份证号码
    NSString * idCardLast= [strTempIDCard substringWithRange:NSMakeRange(17, 1)];
    
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2)
    {
        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
        {
            return flag;
        }else
        {
            flag =  NO;
            return flag;
        }
    }else
    {
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
        {
            return flag;
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
}

+ (BOOL)checkCodeOfBirthDay:(NSString *)birthDay{
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"yyyyMMdd"];
    NSDate *birthDayDate = [formatterDate dateFromString:birthDay];
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    
    if ([nowDate compare:birthDayDate] > 0) {
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:birthDayDate];
        NSInteger yearInterval = timeInterval/(60*60*24*360);
        if (yearInterval > 150 || yearInterval < 0) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
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
