//
//  EditDetailTableViewController.h
//  WeCommunity
//
//  Created by Harry on 9/2/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicTableViewCell.h"
#import "MBProgressHUD.h"
#import "User.h"

@interface EditDetailTableViewController : UITableViewController<UITextFieldDelegate>
//修改用户详细信息的视图控制器
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *titleMessage;
@property (nonatomic,strong) NSString *updateMessage;// 更新的字段
@property (nonatomic,strong) NSString *changedMessage;//更新的信息
@property (nonatomic,strong) MBProgressHUD *loadingView;

@end
