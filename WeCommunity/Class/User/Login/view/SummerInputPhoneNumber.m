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
        self.backgroundColor = [UIColor whiteColor];
        _inputPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 65, frame.size.width - 20, 20)];
        _inputPhoneNumber.placeholder = @"请输入手机号码";
        _inputPhoneNumber.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_inputPhoneNumber];
        
        UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnSure.frame = CGRectMake(10, frame.size.height - 40, (frame.size.width - 30)/2, 30);
        [btnSure addTarget:self action:@selector(btnActionSureOrCansol:) forControlEvents:UIControlEventTouchUpInside];
        [btnSure setTitle:@"确认" forState:UIControlStateNormal];
        [self addSubview:btnSure];
        
//        UIButton *btnCansole = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btnCansole.frame = CGRectMake(frame.size.width - (frame.size.width - 30)/2, frame.size.height - 40, (frame.size.width - 30)/2, 30);
//        [btnCansole addTarget:self action:@selector(btnActionSureOrCansol:) forControlEvents:UIControlEventTouchUpInside];
//        [btnCansole setTitle:@"取消" forState:UIControlStateNormal];
//        [self addSubview:btnCansole];
    }
    return self;
}

- (void)btnActionSureOrCansol:(UIButton *)sender{
    if (sender.tag == 2) {
        //取消
        [self removeFromSuperview];
    }else{
        //确定
        [self.inputPhoneNumber resignFirstResponder];
        if ([NSString filterPhoneNumber:self.inputPhoneNumber.text]) {
            [self.delegate summerInputPhonetNumber:self.inputPhoneNumber.text];
            [self removeFromSuperview];
        }else{
            [self.delegate summerInputPhonetNumber:self.inputPhoneNumber.text];
        }
    }
}

@end
