//
//  SummerNoticeCenterDetailViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailViewController.h"

@interface SummerNoticeCenterDetailViewController : SummerNoticeDetailViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) Notice *detailNotice;;

@end
