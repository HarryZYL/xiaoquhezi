//
//  SummerNavigationBarView.h
//  WeCommunity
//
//  Created by madarax on 15/12/28.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerNavigationBarView : UIView

@property (nonatomic ,strong) UIButton *btnLeft;
@property (nonatomic ,strong) UILabel *labTitle;
@property (nonatomic ,strong) UIButton *btnRight;

- (instancetype)initWithFrame:(CGRect)frame;

@end
