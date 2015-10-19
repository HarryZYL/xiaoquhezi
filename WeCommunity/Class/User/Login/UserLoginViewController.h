//
//  UserLoginViewController.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginView.h"

//这个是登陆界面的视图控制器

@interface UserLoginViewController : UIViewController

@property (nonatomic,strong) UserLoginView *loginView; //用户登陆界面
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) NSString *function;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic) int timeIntervar;
@end
