//
//  SummerInputPhoneNumber.m
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerInputPhoneNumber.h"

@implementation SummerInputPhoneNumber

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.inputPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 20)];
        self.inputPhoneNumber.placeholder = @"请输入要绑定的手机号码";
        [self addSubview:self.inputPhoneNumber];
        
        UIButton *btnCansole = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCansole setTitle:@"取消" forState:UIControlStateNormal];
        btnCansole.frame = CGRectMake(10, self.inputPhoneNumber.frame.origin.y + 30, (self.frame.size.width - 20)/2.0, 30);
        [self addSubview:btnCansole];
    }
    return self;
}

- (void)btnActionSureOrCansol:(UIButton *)sender{
    
}

@end
