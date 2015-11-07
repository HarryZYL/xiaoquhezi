//
//  OrderHouseViewController.h
//  WeCommunity
//
//  Created by Harry on 7/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderHouseViewControllerDelegate <NSObject>

- (void)orderHouseRentSeccess;

@end

@interface OrderHouseViewController : UIViewController

@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *tellField;
@property (nonatomic,strong) UIButton *dateBtn;
@property (nonatomic,strong) UIButton *orderBtn;
@property (nonatomic,strong) NSString *houseID;
@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) UIDatePicker *oneDatePicker;
@property (nonatomic,weak) id delegate;

@end
