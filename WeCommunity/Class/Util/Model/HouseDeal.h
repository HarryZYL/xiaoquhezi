//
//  HouseDeal.h
//  WeCommunity
//
//  Created by Harry on 8/11/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "creatorInfo.h"
@interface HouseDeal : NSObject

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *ip;//发布者ip
@property (nonatomic,strong) NSDictionary *creatorInfo;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSDictionary *community; //小区信息
@property (nonatomic,strong) NSString *room;
@property (nonatomic,strong) NSString *sittingRoom;
@property (nonatomic,strong) NSString *bathRoom;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *floor;
@property (nonatomic,strong) NSString *totalFloor;
@property (nonatomic,strong) NSString *houseOrientation;
@property (nonatomic,strong) NSString *houseType;
@property (nonatomic,strong) NSString *isCompleted;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *dealType;
@property (nonatomic,strong) NSString *latestReplyId;
@property (nonatomic,strong) NSString *latestReplyTime;
@property (nonatomic,strong) NSString *bookingCount;

- (id)initWithData:(NSDictionary*)data;
@end
