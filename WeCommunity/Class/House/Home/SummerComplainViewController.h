//
//  SummerComplainViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/8.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SummerInputView.h"
#import "UIViewController+HUD.h"
#import "TextDeal.h"

@interface SummerComplainViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) SummerInputView *summerInputView;/**<输入框*/
@property (nonatomic ,strong) UITableView *mTableView;
@property (nonatomic ,copy  ) NSString *strDetailID;/**<投诉ID*/
@property (nonatomic ,strong) TextDeal *complainModel;

@end
