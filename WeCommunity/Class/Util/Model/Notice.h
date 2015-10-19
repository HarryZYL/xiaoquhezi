//
//  Notice.h
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Notice : NSObject
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *Objectid;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *contentTxt;
@property (nonatomic,strong) NSString *isTop;
@property (nonatomic,strong) NSString *setTopTime;
@property (nonatomic,strong) NSString *validBeginTime;
@property (nonatomic,strong) NSString *validEndTime;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSDictionary *creatorInfo;
@property (nonatomic,strong) NSString *replyCount;
@property (nonatomic,strong) NSString *communityId;
-(id)initWithData:(NSDictionary *)data;
@end
