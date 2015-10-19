//
//  TextDeal.m
//  WeCommunity
//
//  Created by Harry on 8/7/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "TextDeal.h"

@implementation TextDeal

-(id)initWithData:(NSDictionary *)data textType:(NSString*)type{
    self = [super init];
    
    if (self) {
        
        self.content = data[@"content"];
        self.Objectid = data[@"id"];
        self.pictures =[Util modifyArray:data[@"pictures"]];
        if ([type isEqualToString:@"complaint"]) {

            self.textDealTypeId = data[@"complaintTypeId"];
            self.textType  = data[@"complaintType"];
            
        }else if([type isEqualToString:@"repair"]) {
            self.textDealTypeId = data[@"repairTypeId"];
            self.textType  = data[@"repairType"];
        }
        self.name = data[@"name"];
        self.phone = data[@"phone"];
        self.createTime = [Util formattedDate:data[@"createTime"] type:1];
        self.creator = data[@"creator"];
        self.creatorInfo = data[@"creatorInfo"];
        self.replyCount = data[@"replyCount"];
        self.senderNewReplyCount = data[@"senderNewReplyCount"];
        self.reciverNewReplyCount = data[@"reciverNewReplyCount"];
        self.communityId = data[@"communityId"];
        self.score = data[@"score"];
        self.comment = data[@"comment"];
        self.status = data[@"status"];
        self.reciveTime = [Util formattedDate:data[@"reciveTime"] type:1];
        self.reciveId = data[@"reciveId"];
        self.reciveUserInfo = data[@"reciveUserInfo"];
        self.closeTime = data[@"closeTime"];
                         
    }
    return self;
}


@end
