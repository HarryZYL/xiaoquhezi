//
//  SummerBillBootomView.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBillBootomView.h"

@implementation SummerBillBootomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _totalMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width/2, frame.size.height)];
        _totalMoney.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        _totalMoney.textAlignment = NSTextAlignmentCenter;
        _totalMoney.text = @"总计：元";
        [self addSubview:_totalMoney];
        
        _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSure.frame = CGRectMake(SCREENSIZE.width/2, 0, SCREENSIZE.width/2, frame.size.height );
        [_btnSure setBackgroundColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1]];
        [_btnSure setTitle:@"缴纳物业费" forState:UIControlStateNormal];
        [self addSubview:_btnSure];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
