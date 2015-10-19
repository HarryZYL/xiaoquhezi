//
//  HouseViewController.h
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HousePostView.h"
#import "FunctionView.h"
#import "HouseFooterView.h"
#import "TextPostViewController.h"
#import "TextTableViewController.h"
#import "LikeTableViewController.h"
#import "RentViewController.h"
#import "BillViewController.h"
#import "HouseKeeperViewController.h"
#import "SigninViewController.h"
#import "WebViewController.h"
#import "OverViewViewController.h"
#import "FileManager.h"
#import "NoticeTableViewController.h"
#import "UserView.h"
#import "SettingTableViewController.h"
#import "BasicViewController.h"
#import "AccreditationTableViewController.h"
#import "UserDetailTableViewController.h"
#import "UserLoginViewController.h"
#import "Networking.h"
#import "AccreditationPostViewController.h"


@interface HouseViewController : BasicViewController<UIAlertViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) HousePostView *headView;
@property (nonatomic ,strong) FunctionView *functionView;
@property (nonatomic ,strong) HouseFooterView *footerView;
@property (nonatomic,strong) NSArray *noticeData;
@property (nonatomic,strong) UserView *userView;
@property (nonatomic,strong) UIView *userBgView;

@end
