//
//  RentViewController.h
//  WeCommunity
//
//  Created by Harry on 7/24/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
#import "AdScrollView.h"
#import "RentDetailViewController.h"
#import "HouseDeal.h"
#import "LoadingView.h"
#import "SDCycleScrollView.h"
#import "RentPostViewController.h"
#import "ActivityPostViewController.h"
#import "SecondHandPostViewController.h"
#import "AccreditationPostViewController.h"

@interface RentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource, DOPDropDownMenuDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) NSString *function;
@property (nonatomic) BOOL playAdvertise;
@property (nonatomic,strong) NSArray *filterArray1;
@property (nonatomic,strong) NSArray *filterArray2;
@property (nonatomic) int page;
@property (nonatomic,strong) NSArray *houseTypeArr;
@property (nonatomic) BOOL communityAll;



@end
