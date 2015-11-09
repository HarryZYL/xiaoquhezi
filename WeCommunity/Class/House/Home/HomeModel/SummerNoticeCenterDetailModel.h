//
//  SummerNoticeCenterDetailModel.h
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//  公告回复

#import <Foundation/Foundation.h>
#import "SummerHomeDetailNoticeModel.h"

@interface SummerNoticeCenterDetailModel : NSObject

@property(nonatomic ,strong)SummerHomeDetailNoticeModel *detailNoticeModel;/**<公告回复对象*/
@property(nonatomic ,strong)NSMutableArray<SummerHomeDetailNoticeModel*> *detailReplyArrary;/**<公告回复子节点对象*/

@end
