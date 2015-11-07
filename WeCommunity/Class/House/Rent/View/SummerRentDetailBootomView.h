//
//  SummerRentDetailBootomView.h
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerRentDetailBootomView : UIView

@property (nonatomic ,strong) UIButton *btnLeft;
@property (nonatomic ,strong) UIButton *btnRight;

- (instancetype)initWithFrame:(CGRect)frame withItem:(NSInteger) countIndex;

@end
