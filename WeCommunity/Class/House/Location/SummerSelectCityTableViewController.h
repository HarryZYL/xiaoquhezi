//
//  SummerSelectCityTableViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectCityName)(NSDictionary *);

@interface SummerSelectCityTableViewController : UIViewController

@property (nonatomic ,copy)selectCityName cityBlock;

@end
