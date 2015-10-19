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
        self.creatorInfo = [[creatorInfo alloc]initWithData:data[@"creatorInfo"]];
        self.replyCount = data[@"replyCount"];
        self.community = data[@"community"];
        self.room = data[@"room"];
        self.sittingRoom = data[@"sittingRoom"];
        self.bathRoom = data[@"bathRoom"];
        self.area = data[@"area"];
        self.floor = data[@"floor"];
        self.totalFloor = data[@"totalFloor"];
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
