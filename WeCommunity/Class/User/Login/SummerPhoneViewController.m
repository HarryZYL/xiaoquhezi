//
//  SummerPhoneViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "SummerPhoneViewController.h"
#import "UserLoginView.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"
@interface SummerPhoneViewController ()
//@property (nonatomic ,weak) IBOutlet UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *tellField;
@property (nonatomic,strong) UITextField *captchaField;
@property (nonatomic,strong) UIButton *mainBtn;
@property (nonatomic,strong) UIButton *captchaBtn;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int    timeIntervar;

@end
static int timeToGetCaptcha = 60;
@implementation SummerPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定手机";
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat heignt = 50;
    CGFloat width = SCREENSIZE.width - 30;
    
    self.tellField = [[UITextField alloc] init];
    self.tellField.frame = CGRectMake(15, 80, width, heignt);
    self.tellField.placeholder = @"请输入手机号";
    self.tellField.keyboardType = UIKeyboardTypeNumberPad;
    [self.tellField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.tellField];
    
    self.captchaField = [[UITextField alloc] init];
    self.captchaField.frame = CGRectMake(15, self.tellField.frame.size.height +self.tellField.frame.origin.y+5, 160, heignt);
    self.captchaField.placeholder = @"请输入验证码";
    [self.captchaField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.captchaField];
    
    self.captchaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.captchaBtn setBackgroundColor:[UIColor orangeColor]];
    [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.captchaBtn addTarget:self action:@selector(getResetUserPasswordCaptchaFunction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.captchaBtn];
    
    self.mainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mainBtn setBackgroundColor:[UIColor orangeColor]];
    [self.mainBtn addTarget:self action:@selector(btnSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainBtn roundRect];
    [self.view addSubview:self.mainBtn];
    
    [self setupcaptchaBtn];
    
    self.mainBtn.frame = CGRectMake(30, self.captchaField.frame.size.height+self.captchaField.frame.origin.y+15, self.view.frame.size.width-60, 40);
    [self.mainBtn setTitle:@"绑定" forState:UIControlStateNormal];
}

//获取重设密码验证码
-(void)getResetUserPasswordCaptchaFunction:(id)sender{
    if (self.tellField.text.length == 0) {
        [Util alertNetworingError:@"手机号不能为空"];
    }else{
        [self buttonDisable];
        [self.tellField resignFirstResponder];
        if ([NSString filterPhoneNumber:self.tellField.text]) {
            [Networking retrieveData:get_THIRD_LOGIN_WXAPP parameters:@{@"phoneNumber": self.tellField.text}];
        }else{
            [self showHint:@"请输入有效的手机号"];
        }
    }
}

-(void)buttonDisable{
    //    NSLog(@"test");
    self.timeIntervar = timeToGetCaptcha;
    self.captchaBtn.enabled = NO;
    self.captchaBtn.alpha = 0.55;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonNumber) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)setupcaptchaBtn{
    self.captchaBtn.frame = CGRectMake(self.captchaField.frame.size.width + 20, self.captchaField.frame.origin.y, 90, self.captchaField.frame.size.height);
}

-(void)changeButtonNumber{
    if (self.timeIntervar>0) {
        [self.captchaBtn setTitle:[NSString stringWithFormat:@"%d秒后重试",self.timeIntervar] forState:UIControlStateNormal];
        self.timeIntervar --;
        
    }else{
        self.captchaBtn.enabled = YES;
        self.captchaBtn.alpha = 1;
        [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.timeIntervar = timeToGetCaptcha;
        
    }
}

- (void)btnSure:(UIButton *)sender{
//发送手机号
    if (![NSString filterPhoneNumber:self.tellField.text]) {
        [self showHint:@"手机号别忘记了"];
        return;
    }
    if (self.captchaField.text.length < 1) {
        [self showHint:@"验证码别忘记了"];
        return;
    }
    NSDictionary *dicTemp = @{@"unionId": [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ID"],
                              @"phoneNumber":self.tellField.text,
                              @"captcha":self.captchaField.text};
    [Networking retrieveData:get_THIRD_LOADING parameters:dicTemp success:^(id responseObject) {
        NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
        NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
        User *userModel = [User shareUserDefult];
        [userModel initWithData:data];
        [User SaveAuthentication];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
