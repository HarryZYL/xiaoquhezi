//
//  BillTableViewController.h
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BillTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *roomDic;

@end
