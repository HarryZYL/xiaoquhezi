//
//  SummerAddAdressViewController.h
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SummerEditeAddAdressType) {
    SummerEditeAddAdressTypeAdd,
    SummerEditeAddAdressTypeEidteOrDelete,
};
@interface SummerAddAdressViewController : UIViewController

@property(nonatomic ,assign)SummerEditeAddAdressType editeType;
@property(nonatomic ,strong)NSDictionary *addressDic;
@property(nonatomic ,copy)voidBlock updataAddressSeccess;

@end
