//
//  SummerSelectSellerOrOrderView.m
//  WeCommunity
//
//  Created by madarax on 15/11/4.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectSellerOrOrderView.h"

@implementation SummerSelectSellerOrOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1];
        _btnRent = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRent.tag = 1;
        _btnRent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height/2);
        [_btnRent setTitle:@"出租" forState:UIControlStateNormal];
        [self addSubview:_btnRent];
        
        _btnSell = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSell.frame = CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2);
        [_btnSell setTitle:@"出售" forState:UIControlStateNormal];
        _btnSell.tag = 2;
        [self addSubview:_btnSell];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(3, frame.size.height/2, frame.size.width - 6, 1)];
        lineLab.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineLab];
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
