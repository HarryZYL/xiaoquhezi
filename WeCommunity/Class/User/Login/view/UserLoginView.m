//
//  UserLoginView.m
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "UserLoginView.h"
#import "WXApi.h"

@implementation UserLoginView

//设置坐标
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat heignt = 50;
        CGFloat width = frame.size.width;
        
        self.tellField = [[UITextField alloc] init];
        self.tellField.frame = CGRectMake(0, 0, width, heignt);
        self.tellField.placeholder = NSLocalizedString(@"Login_Name_Text", nil);
        self.tellField.keyboardType = UIKeyboardTypeNumberPad;
        [self.tellField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:self.tellField];
        
        self.passwordField1 = [[UITextField alloc] init];
        self.passwordField1.frame = CGRectMake(0, self.tellField.frame.size.height +self.tellField.frame.origin.y+5, width, heignt);
        self.passwordField1.placeholder = NSLocalizedString(@"Login_Password_Text", nil);
        [self.passwordField1 setBorderStyle:UITextBorderStyleRoundedRect];
        self.passwordField1.secureTextEntry = YES;
        [self addSubview:self.passwordField1];
        
        self.passwordField2 = [[UITextField alloc] init];
        [self.passwordField2 setBorderStyle:UITextBorderStyleRoundedRect];
        self.passwordField2.secureTextEntry = YES;
        [self addSubview:self.passwordField2];
        
        self.captchaField = [[UITextField alloc] init];
        [self.captchaField setBorderStyle:UITextBorderStyleRoundedRect];
        self.captchaField.keyboardType = UIKeyboardTypeNumberPad;
        self.captchaField.placeholder = NSLocalizedString(@"Register_Auth", nil);
        [self addSubview:self.captchaField];
        
        self.captchaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.captchaBtn setTitle:NSLocalizedString(@"Register_Get_Auth", nil) forState:UIControlStateNormal];
        [self.captchaBtn setBackgroundColor:THEMECOLOR];
        [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.captchaBtn];
        
        self.mainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.mainBtn setBackgroundColor:THEMECOLOR];
        [self.mainBtn roundRect];
        [self addSubview:self.mainBtn];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.leftBtn setTitle:NSLocalizedString(@"Login_Forget_Psw", nil) forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.rightBtn setTitle:NSLocalizedString(@"Login_Register", nil) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:self.rightBtn];
    }
    return self;
}

-(void)setupcaptchaBtn{
    self.captchaBtn.frame = CGRectMake(self.captchaField.frame.size.width + 10, self.captchaField.frame.origin.y+10, 90, 30);
}


-(void)configureLoginView{
    
    self.leftBtn.frame = CGRectMake(0, self.passwordField1.frame.size.height+self.passwordField1.frame.origin.y+20, 110, 20);
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.rightBtn.frame = CGRectMake(self.frame.size.width-80, self.passwordField1.frame.size.height+self.passwordField1.frame.origin.y+20, 80, 20);
    
    self.mainBtn.frame = CGRectMake(30, self.passwordField1.frame.size.height+self.passwordField1.frame.origin.y+60, self.frame.size.width-60, 40);
    [self.mainBtn setTitle:NSLocalizedString(@"Login_Title", nil) forState:UIControlStateNormal];
    
//    UIButton *btnWeiXin = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [btnWeiXin setTitle:@"微信登录" forState:UIControlStateNormal];
//    [btnWeiXin setTitleColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1] forState:UIControlStateNormal];
//    btnWeiXin.frame = CGRectMake(30, self.mainBtn.frame.origin.y + 70, self.frame.size.width - 60, 40);
//    [btnWeiXin addTarget:self action:@selector(wxinRegister) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btnWeiXin];
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, self.frame.size.height - 215 + 84, self.frame.size.width, .5);
    lineLayer.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
    [self.layer addSublayer:lineLayer];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 225 + 84, 100, 20)];
    nameLab.layer.position = lineLayer.position;
    nameLab.textColor = [UIColor colorWithWhite:0.533 alpha:1.000];
    nameLab.text = NSLocalizedString(@"Login_WeChat", nil);
    nameLab.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    nameLab.font = [UIFont systemFontOfSize:15];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLab];
    
    UIButton *btnWeiXin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnWeiXin.layer.cornerRadius = 3;
    btnWeiXin.layer.masksToBounds = YES;
    [btnWeiXin setBackgroundImage:[UIImage imageNamed:@"weixin_loading"] forState:UIControlStateNormal];
    btnWeiXin.frame = CGRectMake((self.frame.size.width - 40)/2, self.frame.size.height - 190 + 84, 36, 36);
    [btnWeiXin addTarget:self action:@selector(wxinRegister) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnWeiXin];
    
    if (![WXApi isWXAppInstalled]) {
        btnWeiXin.hidden = YES;
    }

}

-(void)configureForgetView{
    self.passwordField1.placeholder = NSLocalizedString(@"Forget_Psw_Text", nil);
    
    self.captchaField.frame = CGRectMake(0,self.passwordField1.frame.size.height+self.passwordField1.frame.origin.y+5, self.passwordField1.frame.size.width-120, self.passwordField1.frame.size.height);
    [self setupcaptchaBtn];
    
    self.mainBtn.frame = CGRectMake(30, self.captchaField.frame.size.height+self.captchaField.frame.origin.y+15, self.frame.size.width-60, 40);
    [self.mainBtn setTitle:NSLocalizedString(@"Forget_Psw_Reset", nil) forState:UIControlStateNormal];
}

-(void)configureRegisterView{
    self.passwordField2.frame = CGRectMake(0, self.passwordField1.frame.size.height+self.passwordField1.frame.origin.y+5, self.passwordField1.frame.size.width, self.passwordField1.frame.size.height);
    self.passwordField2.placeholder = NSLocalizedString(@"Register_Psw", nil);
    
    self.captchaField.frame = CGRectMake(0,self.passwordField2.frame.size.height+self.passwordField2.frame.origin.y+5, self.passwordField2.frame.size.width-120, self.passwordField2.frame.size.height);
    [self setupcaptchaBtn];
    
    self.mainBtn.frame = CGRectMake(30, self.captchaField.frame.size.height+self.captchaField.frame.origin.y+15, self.frame.size.width-60, 40);
    [self.mainBtn setTitle:NSLocalizedString(@"Login_Register", nil) forState:UIControlStateNormal];
    
}

- (void)wxinRegister{
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123";
    [WXApi sendReq:req];
}

@end





















