//
//  HouseDeal.m
//  WeCommunity
//
//  Created by Harry on 8/11/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HouseDeal.h"

@implementation HouseDeal

- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.objectId = data[@"id"];
        self.title = data[@"title"];
        self.content = data[@"content"];
        self.pictures = [Util modifyArray:data[@"pictures"]];
        self.createTime = [Util formattedDate:data[@"createTime"] type:2];
        self.ip = data[@"ip"];
        self.creatorInfo = data[@"creatorInfo"];
        self.replyCount = data[@"replyCount"];
        self.community = data[@"community"];
        self.room = [data[@"room"] stringValue];
        self.sittingRoom = [data[@"sittingRoom"] stringValue];
        self.bathRoom = [data[@"bathRoom"] stringValue];
        self.area = [data[@"area"] stringValue];
        self.floor = [data[@"floor"] stringValue];
        self.totalFloor = [data[@"totalFloor"] stringValue];
        self.houseOrientation = [Util translateOrientation:data[@"houseOrientation"] En:YES];
        self.houseType = [Util translateHouseType:data[@"houseType"] En:YES];
        self.isCompleted = data[@"isCompleted"];
        self.price = [NSString stringWithFormat:@"%@",data[@"price"]];
        self.dealType = data[@"dealType"];
        self.latestReplyId = [NSString stringWithFormat:@"%@",data[@"latestReplyId"]];
        self.latestReplyTime = data[@"lastReplayTime"];
        self.bookingCount = data[@"bookingCount"];
        
    }
    return self;
}

@end
