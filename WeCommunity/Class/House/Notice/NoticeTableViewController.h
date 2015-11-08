//
//  NoticeTableViewController.h
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "LoadingView.h"
#import "Notice.h"
#import "TextDetailTableViewController.h"
#import "SummerNoticeCenterDetailViewController.h"
@interface NoticeTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic) int page;
@end
