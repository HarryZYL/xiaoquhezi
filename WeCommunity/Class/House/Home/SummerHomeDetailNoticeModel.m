//
//  SummerHomeDetailNoticeModel.m
//  WeCommunity
//
//  Created by madarax on 15/11/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerHomeDetailNoticeModel.h"

@implementation SummerHomeDetailNoticeModel

- (instancetype)initWithData:(NSDictionary *)dicTemp{
    if (self = [super init]) {
        self.articleId = dicTemp[@"articleId"];
        self.childrenCount = dicTemp[@"childrenCount"];
        self.content = dicTemp[@"content"];
        self.createTime = dicTemp[@"createTime"];
        self.creator = dicTemp[@"creator"];
        self.creatorInFo = [[creatorInfo alloc] initWithData:dicTemp[@"creatorInfo"]];
        self.objectID = [NSString stringWithFormat:@"%@",dicTemp[@"id"]];
        self.ip = dicTemp[@"ip"];
        self.parentId = [NSString stringWithFormat:@"%@",dicTemp[@"parentId"]];
        self.pictures = dicTemp[@"pictures"];
        self.replyIndex = dicTemp[@"replyIndex"];
        self.replyToReply = dicTemp[@"replyToReply"];
    }
    return self;
}

@end
