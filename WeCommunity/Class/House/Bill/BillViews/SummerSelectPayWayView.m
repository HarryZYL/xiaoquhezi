//
//  SummerSelectPayWayView.m
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectPayWayView.h"

@interface SummerSelectPayWayView()
{
    UIImageView *imgWXApp;
    UIImageView *imgAlipay;
}
@end

@implementation SummerSelectPayWayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        _currentSelect = 0;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2, SCREENSIZE.width, 1)];
        lineLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        [self addSubview:lineLab];
        imgWXApp = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - frame.size.height/2 - 1, 0, (frame.size.height/2 - 1)/2, (frame.size.height/2 - 1)/2)];
        imgWXApp.center = CGPointMake(frame.size.width - (frame.size.height/2 - 1)/2, (frame.size.height/2 - 1)/2);
        imgWXApp.contentMode = 2;
        imgWXApp.image = [UIImage imageNamed:@"未勾选－设计"];
        [self addSubview:imgWXApp];
        
        UIButton *btnWXApp = [UIButton buttonWithType:UIButtonTypeCustom];
        btnWXApp.frame = CGRectMake(0, 1, SCREENSIZE.width, frame.size.height/2 - 1);
        [btnWXApp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnWXApp setTitle:@"微信支付" forState:UIControlStateNormal];
        btnWXApp.tag = 1;
        [btnWXApp addTarget:self action:@selector(btnSelectOrderPayWay:) forControlEvents:UIControlEventTouchUpInside];
        [btnWXApp setImage:[UIImage imageNamed:@"微信支付图标－设计"] forState:UIControlStateNormal];
        [btnWXApp setImageEdgeInsets:UIEdgeInsetsMake(0, -frame.size.width/2 - 42, 0, 0)];
        [btnWXApp setTitleEdgeInsets:UIEdgeInsetsMake(0, -frame.size.width/2 - 20, 0, 0)];
        [self addSubview:btnWXApp];
        
        imgAlipay = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - frame.size.height/2 -1, frame.size.height/2 + 1, (frame.size.height/2 -1)/2.0, (frame.size.height/2 -1)/2.0)];
        imgAlipay.contentMode = 2;
        
        imgAlipay.image = [UIImage imageNamed:@"未勾选－设计"];
        [self addSubview:imgAlipay];
        
        UIButton *btnAlipay = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAlipay.frame = CGRectMake(0, frame.size.height/2 + 1, frame.size.width, frame.size.height/2 -1);
        [btnAlipay addTarget:self action:@selector(btnSelectOrderPayWay:) forControlEvents:UIControlEventTouchUpInside];
        [btnAlipay setTitle:@"支付宝支付" forState:UIControlStateNormal];
        btnAlipay.tag = 2;
        [btnAlipay setImage:[UIImage imageNamed:@"支付宝－设计"] forState:UIControlStateNormal];
        [btnAlipay setImageEdgeInsets:UIEdgeInsetsMake(0, -frame.size.width/2 - 25, 0, 0)];
        [btnAlipay setTitleEdgeInsets:UIEdgeInsetsMake(0, -frame.size.width/2, 0, 0)];
        [btnAlipay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btnAlipay];
        
        imgAlipay.center = CGPointMake(frame.size.width - (frame.size.height/2 - 1)/2, btnAlipay.center.y);
    }
    
    return self;
}

- (void)btnSelectOrderPayWay:(UIButton *)sender{
    if (sender.tag == 1) {
        if (_currentSelect == 1) {
            return;
        }else{
            imgAlipay.image = [UIImage imageNamed:@"未勾选－设计"];
            imgWXApp.image = [UIImage imageNamed:@"选中－设计"];
            _currentSelect = 1;
        }
    }else{
        if (_currentSelect == 2) {
            return;
        }else{
            imgAlipay.image = [UIImage imageNamed:@"选中－设计"];
            imgWXApp.image = [UIImage imageNamed:@"未勾选－设计"];
            _currentSelect = 2;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
