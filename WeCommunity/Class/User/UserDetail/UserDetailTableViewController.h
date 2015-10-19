//
//  UserDetailTableViewController.h
//  WeCommunity
//
//  Created by Harry on 8/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "EditDetailTableViewController.h"
#import "Util.h"
#import "User.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface UserDetailTableViewController : UITableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//用户详细信息的视图控制器
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *detailArray;
@property (nonatomic,strong) NSArray *messageArray;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic,strong) NSString *actionStr;//用来判断什么动作
@property ( nonatomic ,strong) NSString *sourceType;
@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) NSString *headImageString;
@property (nonatomic) BOOL stopLogin;
@end
