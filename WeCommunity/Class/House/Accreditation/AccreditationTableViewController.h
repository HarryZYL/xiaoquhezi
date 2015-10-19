//
//  AccreditationTableViewController.h
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "LoadingView.h"
#import "User.h"
#import "AccreditationPostViewController.h"
@interface AccreditationTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic) int page;
@end
