//
//  ThirdUserModel.h
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//  第三方登录返回的用户数据

#import <Foundation/Foundation.h>

@interface ThirdUserModel : NSObject
/**
 *
 *  @param codeID
 *
 *  @return 返回yes已经绑定过手机，没有绑定手机
 */
+ (void)returnThirdLoadingUserModelWithCode:(NSString *)codeID;

@end
