//
//  SigninViewController.h
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SigninHeader.h"
#import "SigninDate.h"
#import "BasicTableViewCell.h"
@interface SigninViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) SigninHeader *headerView;
@property (nonatomic,strong) SigninDate *dateView;
@property (nonatomic,strong) UITableView *tableView;
@end
