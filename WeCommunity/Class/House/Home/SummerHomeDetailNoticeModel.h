//
//  SummerHomeDetailNoticeModel.h
//  WeCommunity
//
//  Created by madarax on 15/11/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "creatorInfo.h"

@interface SummerHomeDetailNoticeModel : NSObject

@property(nonatomic ,copy)NSString *articleId;
@property(nonatomic ,copy)NSString *childrenCount;
@property(nonatomic ,copy)NSString *content;
@property(nonatomic ,copy)NSString *createTime;
@property(nonatomic ,copy)NSString *creator;
@property(nonatomic ,copy)NSString *objectID;
@property(nonatomic ,copy)NSString *ip;
@property(nonatomic ,copy)NSString *parentId;
@property(nonatomic ,strong)NSArray *pictures;
@property(nonatomic ,copy)NSString *replyIndex;
@property(nonatomic ,copy)NSString *replyToReply;
@property(nonatomic ,strong)creatorInfo *creatorInFo;

- (instancetype)initWithData:(NSDictionary *)dicTemp;

@end
