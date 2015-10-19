//
//  SecondHand.h
//  WeCommunity
//
//  Created by Harry on 8/13/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "creatorInfo.h"
@interface SecondHand : NSObject

//二手的模型
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *communityId;//社区id
@property (nonatomic,strong) creatorInfo *creatorInfo;//创建者信息
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *fleaMarketType;//市场类型
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *originalPrice;//原价
@property (nonatomic,strong) NSString *dealPrice;//交易价
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray *pictures;
@property (nonatomic,strong) NSString *completeTime;//完成时间
@property (nonatomic,strong) NSString *reciveCount;//收获数量
- (id)initWithData:(NSDictionary*)data;
@end
