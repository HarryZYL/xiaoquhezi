//
//  SummerIntergralDetailViewController.h
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    DetailMySelf,
    DetailGoods,
} DetailType;
@interface SummerIntergralDetailViewController : UIViewController
@property(assign)DetailType intergralType;
@property(nonatomic ,strong)NSDictionary *detailGoods;
@end
