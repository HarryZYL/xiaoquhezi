//
//  Util.m
//  WeCommunity
//
//  Created by Harry on 7/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

// 移除数组中的空值

+ (NSDictionary*)removeNullInDictionary:(NSDictionary*)dictionary{
    
    NSMutableArray *keyArray = [NSMutableArray arrayWithCapacity:20];
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:20];
    
    for (NSString *key in dictionary) {
        [keyArray addObject:key];
        NSString *value = [NSString stringWithFormat:@"%@",dictionary[key]];
        if ([value isEqualToString:@"<null>"]) {
            [valueArray addObject:@""];
        }else{
            [valueArray addObject:dictionary[key]];
        }
    }
    
    return  [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];

}

+ (MWPhotoBrowser*)fullImageSetting:(MWPhotoBrowser*)browser{
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = YES;
    browser.enableSwipeToDismiss = YES;
    browser.autoPlayOnAppear = NO;
    
    return browser;
}
//返回错误的网路信息
+(void)alertNetworingError:(NSString*)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    [alert show];
}

+(CGFloat)getHeightForString:(NSString*)message width:(CGFloat)width font:(UIFont*)font{
    CGRect describe = [message boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil];
    return CGRectGetHeight(describe);
}

+(CGFloat)getWidthForString:(NSString*)message font:(UIFont*)font{
    CGSize stringsize = [message sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return stringsize.width;
}

+(id)modifyArray:(id)data{
    
    NSString *test = [NSString stringWithFormat:@"%@",data];
    
    if ([test isEqualToString:@"<null>"]) {
        return @[@""];
    }else{
        return data;
    }
}


+(NSString*)translateOrientation:(NSString*)index En:(BOOL)english{
    
    NSDictionary *dictionary = @{@"East":@"东",@"South":@"南",@"West":@"西",@"North":@"北",@"SouthNorth":@"南北",@"EastWest":@"东西",@"EastSouth":@"东南",@"WestSouth":@"西南",@"EastNorth":@"东北",@"WestNorth":@"西北"};
    return  [self translate:dictionary message:index En:english];
}

+(NSString*)translate:(NSDictionary*)dictionary message:(NSString*)index En:(BOOL)english{
    if (english) {
        return dictionary[index];
    }else{
        NSString *result;
        BOOL getResult = NO;
        
        for (NSString *key in dictionary) {
            if ([dictionary[key] isEqualToString:index ]) {
                result = key;
                getResult = YES;
                break;
            }
        }
        
        if (getResult) {
            return result;
        }else{
            return @"";
        }
    }
    
}


+(NSString*)translateHouseType:(NSString*)index En:(BOOL)english{
    NSDictionary *dictionary = @{@"Normal":@"普通住宅",@"Double":@"商住两用",@"Apartment":@"公寓",@"Villa":@"别墅",@"Other":@"其他"};
    
    return  [self translate:dictionary message:index En:english];
}

+(NSString *) formattedDate:(NSString*)dateRaw type:(int)type {
    
    NSString *date = [NSString stringWithFormat:@"%@",dateRaw];
    
    if (![date isEqualToString:@"<null>"]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        switch (type) {
            case 1:
                [formatter setDateFormat:@"yyyy年MM月dd日 HH:MM"];
                break;
            case 2:
                [formatter setDateFormat:@"yyyy年MM月dd日"];
                break;
            case 3:
                [formatter setDateFormat:@"MM-dd"];
                break;
            case 4:
                [formatter setDateFormat:@"yyyy年MM月"];
                break;
            default:
                break;
        }
        
        NSTimeInterval tempDate = [date doubleValue]/1000;
        
        NSDate *confromTimestr = [NSDate dateWithTimeIntervalSince1970:tempDate];
        
        return [formatter stringFromDate:confromTimestr];
    }else{
        return nil;
    }
    
}

+(NSString*)translateNumber:(NSString*)number{
    
    int conditon = [number intValue];
    
    NSArray *result = @[@"零",@"一",@"两",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    
    return result[conditon];
    
}

+(NSString*)getCommunityName{
    NSDictionary *dataAll = [FileManager getData:@"Community"];
    return dataAll[@"communityName"];
}

+(NSString*)getCommunityID{
    NSDictionary *dataAll = [FileManager getData:@"Community"];
    return dataAll[@"communityID"];
}
+(BOOL)judgeChooseCommunity{
    NSDictionary *data = [FileManager getData:@"Community"];
    NSString *event = [NSString stringWithFormat:@"%@",data[@"communityName"]];
    if ([event isEqualToString:@"(null)"]) {
        return false;
    }else{
        return true;
        
    }
}

+(BOOL)judgeAuthentication{
   NSString *auth =  [User getAuthenticationOwnerType];
    if ([auth isEqualToString:@"未认证"]) {
        return false;
    }else{
        return true;
    }
}

@end
