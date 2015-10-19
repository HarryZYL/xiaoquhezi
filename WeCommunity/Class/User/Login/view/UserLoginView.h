//
//  UserLoginView.h
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserLoginView : UIView
@property (nonatomic,strong) UITextField *tellField;
@property (nonatomic,strong) UITextField *passwordField1;
@property (nonatomic,strong) UITextField *passwordField2;
@property (nonatomic,strong) UITextField *captchaField;
@property (nonatomic,strong) UIButton *mainBtn;
@property (nonatomic,strong) UIButton *captchaBtn;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

-(void)setupcaptchaBtn;
//整个用户界面相似，所以封装 UserEnterView  然后根据不同的页面修改Frame
-(void)configureLoginView;
-(void)configureForgetView;
-(void)configureRegisterView;
@end
