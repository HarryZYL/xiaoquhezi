//
//  SummerNoticeDetailViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerInputView.h"
@interface SummerNoticeDetailViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>
{
    SummerInputView *inputView;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,copy) NSString *strNoticeID;

@end
