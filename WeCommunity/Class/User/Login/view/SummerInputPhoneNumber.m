//
//  SummerInputPhoneNumber.m
//  WeCommunity
//
//  Created by madarax on 15/10/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerInputPhoneNumber.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"

@implementation SummerInputPhoneNumber

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.inputPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 20)];
        self.inputPhoneNumber.placeholder = @"请输入要绑定的手机号码";
        [self addSubview:self.inputPhoneNumber];
        
        UIButton *btnCansole = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCansole setTitle:@"取消" forState:UIControlStateNormal];
        btnCansole.tag = 2;
        [btnCansole addTarget:self action:@selector(btnActionSureOrCansol:) forControlEvents:UIControlEventTouchUpInside];
        btnCansole.frame = CGRectMake(10, self.inputPhoneNumber.frame.origin.y + 30, (self.frame.size.width - 30)/2.0, 30);
        [self addSubview:btnCansole];
        
        UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnSure setTitle:@"确定" forState:UIControlStateNormal];
        btnSure.tag = 3;
        [btnSure addTarget:self action:@selector(btnActionSureOrCansol:) forControlEvents:UIControlEventTouchUpInside];
        btnSure.frame = CGRectMake(frame.size.width / 2.0 + 10, self.inputPhoneNumber.frame.origin.y + 30, (self.frame.size.width - 30)/2.0, 30);
        [self addSubview:btnSure];
    }
    return self;
}

- (void)btnActionSureOrCansol:(UIButton *)sender{
    if (sender.tag == 2) {
        //取消
        [self.delegate summerInputPhonetNumber:@""];
        [self removeFromSuperview];
    }else{
        //确定
        if ([NSString filterPhoneNumber:self.inputPhoneNumber.text]) {
            [self.delegate summerInputPhonetNumber:self.inputPhoneNumber.text];
            [self removeFromSuperview];
        }
    }
}

@end
