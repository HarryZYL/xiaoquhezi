//
//  SummerBillConfirmViewController.h
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatPayManager.h"

@interface SummerBillConfirmViewController : UIViewController

@property (nonatomic ,copy)NSString *orderListID;/**<返回的订单ID*/
@property (nonatomic ,strong)NSArray *billOrderIDArrary; /**<选择的物业费ID*/
@property (nonatomic ,strong)NSArray *commnityArrary;    /**<选择的物业费信息*/
@property (nonatomic ,strong)NSDictionary *commnityDic;  /**<选择的小区信息*/

@end
