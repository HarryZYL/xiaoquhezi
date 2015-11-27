//
//  SummerRePostMyRentViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "SummerPostRentViewController.h"
#import "SummerRentAlertView.h"
#import <UIKit/UIKit.h>
#import "HouseDeal.h"

@interface SummerRePostMyRentViewController : UIViewController
@property(nonatomic , strong)SummerRentAlertView *alertViewModel;
@property (nonatomic,strong) HouseDeal *houseDeal;
@property (nonatomic,copy)NSString *strHouseDeailID;
@property (assign)SummerPostRentType houseDealType;

@end
