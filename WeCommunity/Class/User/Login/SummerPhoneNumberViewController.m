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
    self.phoneNumber.text = _strPhoneNumber;
    [self buttonDisable];
}

- (IBAction)suerPhonen:(UIButton *)sender{
    if (sender.tag == 1) {
        //发送手机号
        NSDictionary *dicTemp = @{@"unionId": [[NSUserDefaults standardUserDefaults] objectForKey:@"WX_ID"],
                                  @"phoneNumber":_phoneNumber.text,
                                  @"captcha":self.remainField.text};
        [Networking retrieveData:get_THIRD_LOADING parameters:dicTemp success:^(id responseObject) {
            NSDictionary *userData = [Util removeNullInDictionary:responseObject[@"user"]];
            NSDictionary *data = @{@"token":responseObject[@"token"],@"user":userData};
            
            [FileManager saveDataToFile:data filePath:@"MyAppCache"];
            [User SaveAuthentication];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        //请求验证码
    }
}

-(void)buttonDisable{
    //    NSLog(@"test");
    self.timeIntervar = timeToGetCaptcha;
    self.btnRemain.enabled = NO;
    self.btnRemain.alpha = 0.55;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonNumber) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)changeButtonNumber{
    if (self.timeIntervar>0) {
        NSString *strTemp = [NSString stringWithFormat:@"%d秒后重试",self.timeIntervar];
        [self.btnRemain setTitle:strTemp forState:UIControlStateNormal];
        self.timeIntervar --;
    }else{
        self.btnRemain.enabled = YES;
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
