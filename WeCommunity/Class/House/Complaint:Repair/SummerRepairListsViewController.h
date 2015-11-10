//
//  SummerRepairListsViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerInputView.h"
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import "TextDeal.h"

@interface SummerRepairListsViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) SummerInputView *summerInputView;
@property (nonatomic ,strong) UITableView *mTableView;
@property (nonatomic ,strong) TextDeal *detailTextModel;

@end
