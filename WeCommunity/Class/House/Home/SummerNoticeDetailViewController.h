//
//  SummerNoticeDetailViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerInputView.h"
@interface SummerNoticeDetailViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) SummerInputView *summerInputView;
@property (nonatomic ,strong) UITableView *mTableView;
@property (nonatomic ,copy) NSString *strNoticeID;

@end