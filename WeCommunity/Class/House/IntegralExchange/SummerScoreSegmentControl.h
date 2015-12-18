//
//  SummerScoreSegmentControl.h
//  WeCommunity
//
//  Created by madarax on 15/12/17.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerScoreSegmentControl : UIView

@property(nonatomic ,assign)NSInteger currentSelectIndex;
@property(nonatomic ,strong)NSArray *items;
@property(nonatomic ,strong)UIFont *titleFont;

@property(nonatomic ,copy)void(^tapIndexTag)(NSInteger);

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex;

@end
