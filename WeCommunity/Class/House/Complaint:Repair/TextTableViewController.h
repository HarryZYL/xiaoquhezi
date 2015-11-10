//
//  TextTableViewController.h
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextPostViewController.h"
#import "TextDeal.h"
#import "AFHTTPRequestOperationManager.h"
#import "Util.h"
#import "User.h"
#import "LoadingView.h"
#import "TextDeal.h"
#import "TextDetailTableViewController.h"
#import "SummerRepairListsViewController.h"

@interface TextTableViewController : UITableViewController

@property (nonatomic ,copy) NSString *function;
@property (nonatomic ,strong) LoadingView *loadingView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic) int page;
@end
