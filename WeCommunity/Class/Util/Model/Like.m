//
//  Like.m
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "Like.h"

@implementation Like

- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.objectId = data[@"id"];
        self.content = data[@"content"];
        self.pictures = data[@"pictures"];
        self.createTime = [Util formattedDate:data[@"createTime"] type:1];
        self.creatorInfo = data[@"creatorInfo"];
        self.replyCount = data[@"replyCount"];
        self.communityId = data[@"communityId"];
        self.latestReplyId = data[@"latestReplyId"];
        self.latestReplyTime = data[@"lastReplayTime"];
        self.praiseType = data[@"praiseType"];
        self.praiseTypeId = data[@"praiseTypeId"];
        
    }
    return self;
}

@end
