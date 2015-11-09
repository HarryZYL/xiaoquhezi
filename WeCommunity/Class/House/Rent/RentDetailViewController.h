//
//  RentDetailViewController.h
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RentDetailView.h"
#import "SummerRentDetailBootomView.h"
#import "OrderHouseViewController.h"
#import "SummerPostRentViewController.h"
#import "SummerRentTakeNoteViewController.h"
#import "HouseDeal.h"
#import "ActivityDetailView.h"
#import "Activity.h"
#import "SecondHand.h"
#import "SecondHandView.h"

@interface RentDetailViewController : UIViewController<MWPhotoBrowserDelegate>

@property (nonatomic,strong) UIScrollView *scollView;
@property (nonatomic,strong) SummerRentDetailBootomView *functionBtn;
@property (nonatomic,strong) NSDictionary *detailData;
@property (nonatomic, strong) NSMutableArray *photos;
//view
@property (nonatomic,strong) RentDetailView *rentView;
@property (nonatomic,strong) ActivityDetailView *activityView;
@property (nonatomic,strong) SecondHandView *secondHandView;
//model
@property (nonatomic,strong) Activity *activity;
@property (nonatomic,strong) HouseDeal *houseDeal;
@property (nonatomic,strong) SecondHand *secondHand;
//分辨功能
@property (nonatomic,strong) NSString *function;
@end
