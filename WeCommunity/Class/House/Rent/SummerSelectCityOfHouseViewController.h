//
//  SummerSelectCityOfHouseViewController.h
//  WeCommunity
//
//  Created by madarax on 15/10/29.
//  Copyright © 2015年 Harry. All rights reserved.
//  根据城市选小区

#import <UIKit/UIKit.h>
#import "SummerSelectCityView.h"

@protocol SummerSelectCityOfHouseViewControllerDelegate <NSObject>

- (void)selectedFinishedNearlyCommunity:(NSDictionary *)dicTemp;

@end

@interface SummerSelectCityOfHouseViewController : UIViewController<SummerSelectCityViewDelegate>

@property (nonatomic,weak) id delegate;

@end
