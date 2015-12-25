//
//  SummerSelectCommunityViewController.h
//  WeCommunity
//
//  Created by madarax on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "LocationTableViewController.h"
#import "SummerSelectCityTableViewController.h"

typedef void(^PopReturnView)(NSDictionary *);
typedef NS_ENUM(NSUInteger, SummerSelectCommunityViewType) {
    SummerSelectCommunityViewTypeDefult,
    SummerSelectCommunityViewTypeAccreditation,
};

@interface SummerSelectCommunityViewController : UIViewController

@property (nonatomic ,copy)PopReturnView backViewBlock;
@property (assign)LocationTableViewControllerStyle  selectCityType;

@end
