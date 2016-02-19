//
//  LikeTableViewController.h
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextPostViewController.h"
#import "BasicHeader.h"
#import "Util.h"
#import "LoadingView.h"
#import "Like.h"
#import "AccreditationPostViewController.h"
@interface LikeTableViewController : UIViewController<UIAlertViewDelegate ,UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic,strong) BasicHeader *headView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic) int page;
@property (nonatomic,strong) NSString *totalLike;
@end
