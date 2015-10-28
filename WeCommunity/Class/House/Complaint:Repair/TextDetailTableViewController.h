//
//  TextDetailTableViewController.h
//  WeCommunity
//
//  Created by Harry on 10/3/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextDeal.h"
#import "Notice.h"

typedef NS_ENUM(NSUInteger, TextDetailInformationNoticeStyle) {
    SettingTableViewControllerStyleNotice,
    SettingTableViewControllerStyleRepair,
    SettingTableViewControllerStyleComplain,
};

@interface TextDetailTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TextDeal *textDeal;
@property (nonatomic,strong) Notice *notice;
@property (nonatomic,strong) NSString *function;
@property (nonatomic, strong) RDRStickyKeyboardView *contentWrapper;
@end
