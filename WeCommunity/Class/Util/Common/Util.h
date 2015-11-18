//
//  Util.h
//  WeCommunity
//
//  Created by Harry on 7/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define THEMECOLOR [UIColor colorWithRed:0.239 green:0.800 blue:0.706 alpha:1.000]
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define is_IOS_8_Later ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
#define is_IOS_9_Later ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

static NSString *fontName= @"HelveticaNeue";
//接口数据
static NSString *kInitURL = @"http://www.wshequ.net";
//static NSString *kInitURL = @"http://192.168.1.101";
static int row = 15;
@interface Util : NSObject

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+ (UIColor *) colorWithHexString: (NSString *) hexString ;
+ (NSDictionary*)removeNullInDictionary:(NSDictionary*)dictionary;
+ (MWPhotoBrowser*)fullImageSetting:(MWPhotoBrowser*)browser;
+(void)alertNetworingError:(NSString*)msg;
+(CGFloat)getHeightForString:(NSString*)message width:(CGFloat)width font:(UIFont*)font;
+(CGFloat)getWidthForString:(NSString*)message font:(UIFont*)font;
+(id)modifyArray:(id)data;
+(NSString*)translateOrientation:(NSString*)index En:(BOOL)english;
+(NSString*)translateHouseType:(NSString*)index En:(BOOL)english;
+(NSString *) formattedDate:(NSString*)dateRaw type:(int)type;
+(NSString*)translateNumber:(NSString*)number;
+(BOOL)judgeChooseCommunity;
+(NSString*)getCommunityID;
+(NSString*)getCommunityName;
+(BOOL)judgeAuthentication;
@end
