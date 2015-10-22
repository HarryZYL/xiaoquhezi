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

@end
