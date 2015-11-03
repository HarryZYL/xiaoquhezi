//
//  Notice.m
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import "NSString+HTML.h"
#import "Notice.h"

@implementation Notice
@synthesize Objectid = _Objectid;
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        self.Objectid = data[@"id"];
        self.title = data[@"title"];
        self.content = data[@"content"];
        self.contentTxt = [NSString filterHTML:data[@"contentTxt"]];
        self.pictures = [Util modifyArray:data[@"pictures"]];
        self.createTime = [Util formattedDate:data[@"createTime"] type:1];
        self.creator = data[@"creator"];
        self.creatorInfo = data[@"creatorInfo"];
        self.communityId = data[@"communityId"];
        self.replyCount = data[@"replyCount"];
        self.isTop = [NSString stringWithFormat:@"%@",data[@"isTop"] ];
        self.setTopTime = [Util formattedDate:data[@"setTopTime"] type:1];
        self.validBeginTime = [Util formattedDate:data[@"validBeginTime"] type:1];
        self.validEndTime = [Util formattedDate:data[@"validEndTime"] type:1];
    }
    return self;
}

@end
