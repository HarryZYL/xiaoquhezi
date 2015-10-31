//
//  SummerPhoneNumberViewController.m
//  WeCommunity
//
//  Created by madarax on 15/10/31.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerPhoneNumberViewController.h"

@interface SummerPhoneNumberViewController ()

@property (nonatomic ,strong)NSTimer *timer;
@end

@implementation SummerPhoneNumberViewController
static int timeToGetCaptcha = 60;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定手机号";
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
}

- (IBAction)suerPhonen:(id)sender{
    if (_phoneNumber.editing) {
        //发送手机号
    }else{
        //发送验证码
    }
}

-(void)buttonDisable{
    //    NSLog(@"test");
    self.timeIntervar = timeToGetCaptcha;
    self.suerBtn.enabled = NO;
    self.suerBtn.alpha = 0.55;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonNumber) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)changeButtonNumber{
    if (self.timeIntervar>0) {
        self.remainField.text = [NSString stringWithFormat:@"%d秒后重试",self.timeIntervar];
        self.timeIntervar --;
    }else{
        self.suerBtn.enabled = YES;
        self.suerBtn.alpha = 1;
        [self.suerBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.timeIntervar = timeToGetCaptcha;
        
    }
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
