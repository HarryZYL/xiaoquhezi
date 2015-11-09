//
//  SummerMoreReplayViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
///Users/madarax/Documents/iosapp/xiaoquhezi/WeCommunity/Class/House/Home/SummerMoreReplayViewController.m

#import <UIKit/UIKit.h>
#import "SummerInputView.h"

@interface SummerMoreReplayViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,copy)NSString *strID;
@property (nonatomic ,strong) SummerInputView *summerInputView;
@property (nonatomic ,strong) UITableView *mTableView;

@end
