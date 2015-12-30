//
//  SummerNavigationBarView.m
//  WeCommunity
//
//  Created by madarax on 15/12/28.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerNavigationBarView.h"

@implementation SummerNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        __weak typeof(self)weakSelf = self;
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeft setImage:[UIImage imageNamed:@"leftBill"] forState:UIControlStateNormal];
        [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        _btnLeft.frame = CGRectMake(0, 20, 70, 44);
        [self addSubview:_btnLeft];
        
        _labTitle = [[UILabel alloc] init];
        _labTitle.textColor = THEMECOLOR;
        _labTitle.font = [UIFont systemFontOfSize:20];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labTitle];
        
        [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(200);
            make.top.equalTo(weakSelf.mas_top).offset(20);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
        
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRight setTitleColor:THEMECOLOR forState:UIControlStateNormal];
        [_btnRight setTitle:@"保存" forState:UIControlStateNormal];
        [_btnRight setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        _btnRight.frame = CGRectMake(frame.size.width - 80, 20, 80, 44);
        [self addSubview:_btnRight];
    }
    return self;
}

@end
