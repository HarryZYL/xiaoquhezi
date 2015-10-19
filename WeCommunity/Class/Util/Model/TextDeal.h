//
//  TextDeal.h
//  WeCommunity
//
//  Created by Harry on 8/7/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextDeal : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *Objectid;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *textDealTypeId;
@property (nonatomic,strong) NSDictionary *textType;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSDictionary *creatorInfo;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSString *senderNewReplyCount;
@property (nonatomic,strong) NSString *reciverNewReplyCount;
@property (nonatomic,strong) NSString *communityId;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *reciveTime;
@property (nonatomic,strong) NSString *reciveId;
@property (nonatomic,strong) NSDictionary *reciveUserInfo;
@property (nonatomic,strong) NSString *closeTime;

-(id)initWithData:(NSDictionary*)data textType:(NSString*)type;


@end
