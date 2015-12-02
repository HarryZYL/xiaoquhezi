//
//  SummerRunloopView.h
//  MasoryDemon
//
//  Created by madarax on 15/12/2.
//  Copyright © 2015年 LiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerRunloopView : UIView

@property(nonatomic ,strong)NSArray *loopImgArrary;

@property(nonatomic ,copy)void(^tapIndex)(NSInteger);

- (void)confirmSubViews;

@end
