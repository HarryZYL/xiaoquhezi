//
//  SummerAlertView.h
//  WeCommunity
//
//  Created by madarax on 15/10/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummerAlertViewDelegate <NSObject>

- (void)summerAlertViewClickIndex:(NSInteger)index;

@end

@interface SummerAlertView : UIView

@property (nonatomic, weak) id delegate;

@end
