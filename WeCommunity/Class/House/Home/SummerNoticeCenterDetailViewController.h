//
//  SummerNoticeCenterDetailViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailViewController.h"
#import "SummerNoticeCenterDetailModel.h"
#import "MBProgressHUD.h"
#import "SummerInputView.h"

@interface SummerNoticeCenterDetailViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) SummerInputView *summerInputView;
@property (nonatomic ,strong) UITableView *mTableView;
@property (nonatomic ,copy  ) NSString *strNoticeID;
@property (nonatomic ,strong) Notice *detailNotice;

@property (nonatomic ,strong) SummerHomeDetailNoticeModel *identifyNotice;

@end
