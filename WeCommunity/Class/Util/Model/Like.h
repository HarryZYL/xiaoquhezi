//
//  Like.h
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Like : NSObject

@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *praiseTypeId;
@property (nonatomic,strong) NSDictionary *praiseType;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSDictionary *creatorInfo;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSString *communityId; //小区信息
@property (nonatomic,strong) NSString *latestReplyId;
@property (nonatomic,strong) NSString *latestReplyTime;

- (id)initWithData:(NSDictionary*)data;
@end
