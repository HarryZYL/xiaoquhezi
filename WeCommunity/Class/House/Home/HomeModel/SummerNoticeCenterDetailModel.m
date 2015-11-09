//
//  SummerNoticeCenterDetailModel.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeCenterDetailModel.h"

@implementation SummerNoticeCenterDetailModel

@synthesize detailNoticeModel = _detailNoticeModel;/**<公告回复对象*/
@synthesize detailReplyArrary = _detailReplyArrary;

- (instancetype)init{
    if (self = [super init]) {
        self.detailNoticeModel = [[SummerHomeDetailNoticeModel alloc] init];
        self.detailReplyArrary = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
