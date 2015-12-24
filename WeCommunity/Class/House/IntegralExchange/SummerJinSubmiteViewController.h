//
//  SummerJinSubmiteViewController.h
//  WeCommunity
//
//  Created by madarax on 15/12/23.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SummerJinSubmiteViewType) {
    SummerJinSubmiteViewTypeSub,
    SummerJinSubmiteViewTypeBind,
};
@interface SummerJinSubmiteViewController : UIViewController

@property (assign) SummerJinSubmiteViewType submitType;

@end
