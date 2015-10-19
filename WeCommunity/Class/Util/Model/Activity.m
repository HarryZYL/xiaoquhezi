//
//  Activity.m
//  WeCommunity
//
//  Created by Harry on 8/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "Activity.h"

@implementation Activity

-(id)initWithData:(NSDictionary *)data{
    
    self = [super init];
    if (self) {
        self.objectId = data[@"id"];
        self.communityId = data[@"communityId"];
        self.creatorInfo = data[@"creatorInfo"];
        self.createTime = [Util formattedDate:data[@"createTime"] type:1];
        self.activityType = data[@"activityType"];
        self.activityTypeName = data[@"activityTypeName"];
        self.title = data[@"title"];
        self.describ = data[@"description"];
        self.address = data[@"address"];
        self.baiduPosLati = [data[@"baiduPosLati"] doubleValue];
        self.baiduPosLong = [data[@"baiduPosLong"] doubleValue];
        self.provinceCode = data[@"provinceCode"];
        self.cityCode = data[@"cityCode"];
        self.districtCode = data[@"districtCode"];
        self.beginTime = [Util formattedDate:data[@"beginTime"] type:1];
        self.endTime = [Util formattedDate:data[@"endTime"] type:1];
        self.applicantExpiredTime = [Util formattedDate:data[@"applicantExpiredTime"] type:1];
        self.pictures = [Util modifyArray:data[@"pictures"]];
        self.coverPhoto = data[@"coverPhoto"];
        self.applicantCount = data[@"applicantCount"];
        
    }
    return self;
}


@end
