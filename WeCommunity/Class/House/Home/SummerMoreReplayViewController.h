//
//  SummerMoreReplayViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
///Users/madarax/Documents/iosapp/xiaoquhezi/WeCommunity/Class/House/Home/SummerMoreReplayViewController.m

#import <UIKit/UIKit.h>
#import "SummerInputView.h"
#import "SummerHomeDetailNoticeModel.h"

@interface SummerMoreReplayViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate ,UITextViewDelegate>

@property (nonatomic ,copy)NSString *strID;/**<回复ID*/
@property (nonatomic ,copy)NSString *strNoticeID;/**<公告ID*/
@property (nonatomic ,strong) SummerHomeDetailNoticeModel *detailNoticeModel;
@property (nonatomic ,strong) SummerInputView *summerInputView;
@property (nonatomic ,strong) UITableView *mTableView;
@property (nonatomic ,strong) SummerHomeDetailNoticeModel *defaultNoticeModel;

@end
