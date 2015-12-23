//
//  SummerIntergralSelectAddressViewController.h
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerEditeAddressViewController.h"

@interface SummerIntergralSelectAddressViewController : UIViewController

@property(nonatomic ,copy)void (^tapSelectAddressBlock)(NSDictionary *);

@end
