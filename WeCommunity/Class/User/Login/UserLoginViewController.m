//
//  UserLoginViewController.m
//  WeCommunity
//
//  Created by Harry on 7/31/15.
//  Copyright (c) 2015 Harry. All rights reserved.
// 登录窗体

#import "UserLoginViewController.h"
#import "SummerPhoneNumberViewController.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"

@interface UserLoginViewController ()<UIAlertViewDelegate>

@end

static int timeToGetCaptcha = 60;

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    
//    初始化登陆视图
    self.loginView = [[UserLoginView alloc] initWithFrame:CGRectMake(30, 84, self.view.frame.size.width-60, self.view.frame.size.height - 94)];
    
    if ([self.function isEqualToString:@"login"]) {
        [self.loginView configureLoginView];
        [self.loginView.leftBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView.rightBtn addTarget:self action:@selector(signin:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView.mainBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        //loding view
        self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
        self.loadingView.titleLabel.text = @"正在登录";
    }else if ([self.function isEqualToString:@"forget"]) {
        [self.loginView configureForgetView];
        [self.loginView.captchaBtn addTarget:self action:@selector(getResetUserPasswordCaptchaFunction:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView.mainBtn addTarget:self action:@selector(changePassword:) forControlEvents:UIControlEventTouchUpInside];
        //loding view
        self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
        self.loadingView.titleLabel.text = @"正在重置";
        
    }else if ([self.function isEqualToString:@"register"]) {
        [self.loginView configureRegisterView];
        [self.loginView.captchaBtn addTarget:self action:@selector(getPhoneRegisterCaptchaFuntion:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView.mainBtn addTarget:self action:@selector(registerPhone:) forControlEvents:UIControlEventTouchUpInside];
        self.loadingView.backgroundColor = [UIColor redColor];
        //loding view
        self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
        self.loadingView.titleLabel.text = @"正在注册";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newUserOrLoading:) name:@"kWXAppLoadingSeccess" object:nil];
    }
    [self.view addSubview:self.loginView];
    // cache data
    
}

//跳转注册界面
-(void)signin:(id)sender{
    UserLoginViewController *signinView = [[UserLoginViewController alloc] init];
    signinView.function = @"register";
    [self pushVC:signinView title:@"注册新用户"];
    
}

//跳转忘记密码界面
-(void)forgetPassword:(id)sender{
    UserLoginViewController *forgetView = [[UserLoginViewController alloc] init];
    forgetView.function = @"forget";
    [self pushVC:forgetView title:@"忘记密码"];
}

// 封装的跳转方法
-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark login action

//登陆的网络请求
-(void)login:(id)sender{
    
    [self.view addSubview:self.loadingView];
    [self.view endEditing:YES];
    NSDictionary *parameters = @{@"phoneNumber":self.loginView.tellField.text,@"password":self.loginView.passwordField1.text};
    [Networking retrieveData:phoneLogin parameters:parameters success:^(id responseObject) {
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        NSDictionary *password = @{@"password":self.loginView.passwordField1.text};
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        [FileManager saveDataToFile:password filePath:@"Password"];
        [User SaveAuthentication];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    
}


#pragma mark forget action

//改变密码
-(void)changePassword:(id)sender{
    
    [self.view addSubview:self.loadingView];
    [self.view endEditing:YES];
    
    NSDictionary *parameters = @{@"phoneNumber":self.loginView.tellField.text,@"newPassword":self.loginView.passwordField1.text,@"captcha":self.loginView.captchaField.text};
    
    [Networking retrieveData:resetUserPassword parameters:parameters success:^(id responseObject) {
        [Util alertNetworingError:@"重置成功"];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    
}

//获取重设密码验证码
-(void)getResetUserPasswordCaptchaFunction:(id)sender{
    
    if (self.loginView.tellField.text.length == 0) {
        [Util alertNetworingError:@"手机号不能为空"];
    }else{
        [self buttonDisable];
        NSDictionary *parameters = @{@"phoneNumber":self.loginView.tellField.text};
        [Networking retrieveData:getResetUserPasswordCaptcha parameters:parameters];

    }
    
}

#pragma mark register
//获取手机注册验证码
-(void)getPhoneRegisterCaptchaFuntion:(id)sender{
    
    if (self.loginView.tellField.text.length == 0) {
        [Util alertNetworingError:@"手机号不能为空"];
    }else{
        [self buttonDisable];
        NSDictionary *parameters = @{@"phoneNumber":self.loginView.tellField.text};
        [Networking retrieveData:getPhoneRegisterCaptcha parameters:parameters];
    }
}

//注册验证
-(void)registerPhone:(id)sender{
    
    if (self.loginView.tellField.text.length == 0) {
        [Util alertNetworingError:@"手机号不能为空"];
    }else if (self.loginView.passwordField1.text.length == 0){
        [Util alertNetworingError:@"密码不能为空"];
    }else if(self.loginView.passwordField2.text.length == 0){
        [Util alertNetworingError:@"请再次输入密码"];
    }else if(![self.loginView.passwordField1.text isEqualToString: self.loginView.passwordField2.text]){
        [Util alertNetworingError:@"第二次输入密码与第一次不同"];
    }else if(self.loginView.captchaField.text.length == 0){
        [Util alertNetworingError:@"请输入验证码"];
    }else{
        [self processRegister];
    }
    
    NSLog(@"test");
}

//执行注册功能
-(void)processRegister{
    
    [self.view addSubview:self.loadingView];
    [self.view endEditing:YES];
    NSDictionary *parameters = @{@"phoneNumber":self.loginView.tellField.text,@"password":self.loginView.passwordField1.text,@"captcha":self.loginView.captchaField.text};
    [Networking retrieveData:phoneRegister parameters:parameters success:^(id responseObject) {
        
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        NSDictionary *password = @{@"password":self.loginView.passwordField1.text};
        [FileManager saveDataToFile:data filePath:@"MyAppCache"];
        [FileManager saveDataToFile:password filePath:@"Password"];
        [User SaveAuthentication];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    
}

#pragma mark 验证码

-(void)buttonDisable{
//    NSLog(@"test");
    self.timeIntervar = timeToGetCaptcha;
    self.loginView.captchaBtn.enabled = NO;
    self.loginView.captchaBtn.alpha = 0.55;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonNumber) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

-(void)changeButtonNumber{
    if (self.timeIntervar>0) {
        [self.loginView.captchaBtn setTitle:[NSString stringWithFormat:@"%d秒后重试",self.timeIntervar] forState:UIControlStateNormal];
        self.timeIntervar --;
        
    }else{
        self.loginView.captchaBtn.enabled = YES;
        self.loginView.captchaBtn.alpha = 1;
        [self.loginView.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.timeIntervar = timeToGetCaptcha;
        
    }
}

- (void)newUserOrLoading:(NSNotification *)notDic{
    NSLog(@"--->%@",notDic);
    if ([notDic.userInfo[@"isload"] boolValue]) {
        //直接登录
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        //绑定手机
        SummerPhoneNumberViewController *phoneVC = [[SummerPhoneNumberViewController alloc] init];
        [self.navigationController pushViewController:phoneVC animated:YES];
    }
}

@end
