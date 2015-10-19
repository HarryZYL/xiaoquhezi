//
//  SecondHand.m
//  WeCommunity
//
//  Created by Harry on 8/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SecondHand.h"

@implementation SecondHand

- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        
        self.objectId = data[@"id"];
        self.communityId = data[@"communityId"];
        self.creatorInfo = [[creatorInfo alloc] initWithData:data[@"creatorInfo"]];
        self.createTime = [Util formattedDate:data[@"createTime"] type:1];
        self.fleaMarketType = data[@"fleaMarketType"];
        self.title = data[@"title"];
        self.originalPrice = data[@"originalPrice"];
        self.dealPrice = [NSString stringWithFormat:@"%@",data[@"dealPrice"]];
        self.content = data[@"content"];
        self.pictures = [Util modifyArray:data[@"pictures"]];
        self.completeTime = [Util formattedDate:data[@"completeTime"] type:1];
        self.reciveCount = data[@"reciveCount"];
        
    }
    return self;
}

@end
