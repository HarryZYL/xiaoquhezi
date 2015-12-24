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
//            unionId = oRdIHs3ivrXTmpLjxHKeBLPHriMw;／／需要记录
//            user = "<null>";
//user－－－存在，说明已经绑定过手机号；为空，说明没有绑定过手机号－－－>qu绑定手机号
        [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"unionId"] forKey:@"WX_ID"];
        NSLog(@"---->%@",responseObject);
        BOOL isLoading;
        if ([responseObject[@"user"] isEqual:[NSNull null]]) {
            isLoading = NO;
        }else{
            NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
            
            NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
            User *userModel = [User shareUserDefult];
            [userModel initWithData:data];
            [User SaveAuthentication];
            isLoading = YES;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kWXAppLoadingSeccess" object:nil userInfo:@{@"isload": [NSNumber numberWithBool:isLoading]}];
    }];
}

- (void)dealloc{
    
}

@end
