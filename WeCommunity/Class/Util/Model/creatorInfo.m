//
//  creatorInfo.m
//  WeCommunity
//
//  Created by Harry on 8/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "creatorInfo.h"

@implementation creatorInfo

- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.Userid = data[@"id"];
        self.userName = data[@"userName"];
        self.nickName = data[@"nickName"];
        self.headPhoto = [NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"headPhoto"]]];
        self.sex = data[@"sex"];
        self.sexName = data[@"sexName"];
        self.communityId = data[@"communityId"];
    }
    return self;
}

@end
