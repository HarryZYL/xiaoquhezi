//
//  SummerRentAlertView.h
//  WeCommunity
//
//  Created by madarax on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseDeal.h"
#import "SAMTextView.h"
#import "CameraImageView.h"

@interface SummerRentAlertView : UIView

@property (nonatomic,strong) HouseDeal *houseDeal;

@property (nonatomic ,strong)UIScrollView *mScrollView;
@property (nonatomic ,strong)UIView *bootomView;
@property (nonatomic ,strong)UIView *middleView;
@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)CameraImageView *photoImage;

- (void)setContentTitle;

@end
