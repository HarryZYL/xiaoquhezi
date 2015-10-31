//
//  ThirdUserModel.m
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ThirdUserModel.h"

@implementation ThirdUserModel

+ (void)returnThirdLoadingUserModelWithCode:(NSString *)codeID{
    [Networking retrieveData:get_LOGIN_CODE parameters:@{@"code": codeID} success:^(id responseObject) {
//            unionId = oRdIHs3ivrXTmpLjxHKeBLPHriMw;
//            user = "<null>";
//user－－－存在，说明已经绑定过手机号；为空，说明没有绑定过手机号－－－>qu绑定手机号
        NSLog(@"---->%@",responseObject);
        BOOL isLoading;
        if ([responseObject[@"user"] isEqual:[NSNull null]]) {
            isLoading = NO;
        }else{
            isLoading = YES;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kWXAppLoadingSeccess" object:nil userInfo:@{@"isload": [NSNumber numberWithBool:isLoading]}];
    }];
}

- (void)dealloc{
}

@end
