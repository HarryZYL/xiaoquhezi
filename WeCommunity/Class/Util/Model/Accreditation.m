//
//  Accreditation.m
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "Accreditation.h"



@implementation Accreditation


-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        
        self.objectId = data[@"id"];
        self.userId = data[@"userId"];
        self.userName = data[@"userName"];
        self.headPhoto = data[@"headPhoto"];
        self.communityId = data[@"communityId"];
        self.community = data[@"community"];
        self.realName = data[@"realName"];
        self.cardType = data[@"cardType"];
        self.cardTypeName = data[@"cardTypeName"];
        self.cardNumber = data[@"cardNumber"];
        self.houseId = data[@"houseId"];
        self.houseName = data[@"houseName"];
        self.buildingId = data[@"buildingId"];
        self.buildingName = data[@"buildingName"];
        self.applyTime = [Util formattedDate:data[@"applyTime"] type:1];
        self.auditorId = data[@"auditorId"];
        self.auditTime = [Util formattedDate:data[@"auditTime"] type:1];
        self.auditStatus = data[@"auditStatus"];
        self.auditFailedReason = data[@"auditFailedReason"];
        self.ownerType = data[@"ownerType"];
        self.ownerTypeName = data[@"ownerTypeName"];
        self.reciveTime = data[@"reciveTime"];
        
    }
    return self;
}

@end
