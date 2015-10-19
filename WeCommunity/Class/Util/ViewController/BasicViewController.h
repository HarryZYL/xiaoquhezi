//
//  BasicViewController.h
//  WeCommunity
//
//  Created by Harry on 8/23/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "LocationTableViewController.h"
@interface BasicViewController : UIViewController

@property (nonatomic,strong) UIBarButtonItem *rightItem;

- (void)hideTabBar;
- (void)showTabBar;
-(void)changeLoction;
@end

