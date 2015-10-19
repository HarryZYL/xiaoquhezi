//
//  Activity.h
//  WeCommunity
//
//  Created by Harry on 8/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *communityId;
@property (nonatomic,strong) NSDictionary *creatorInfo;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *activityType;
@property (nonatomic,strong) NSString *activityTypeName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *describ;
@property (nonatomic,strong) NSString *address;
@property (nonatomic) double baiduPosLati;
@property (nonatomic) double baiduPosLong;
@property (nonatomic,strong) NSString *provinceCode;
@property (nonatomic,strong) NSString *cityCode;
@property (nonatomic,strong) NSString *districtCode;
@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *applicantExpiredTime;
@property (nonatomic,strong) NSString *coverPhoto;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *applicantCount;

-(id)initWithData:(NSDictionary *)data;

@end
