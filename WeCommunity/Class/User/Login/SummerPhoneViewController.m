//
//  SummerPhoneViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "SummerPhoneNumberViewController.h"
#import "SummerPhoneViewController.h"
#import "UIViewController+HUD.h"
#import "NSString+HTML.h"
@interface SummerPhoneViewController ()
@property (nonatomic ,weak) IBOutlet UITextField *phoneNumber;
@end

@implementation SummerPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnSure:(id)sender{
    [self.phoneNumber resignFirstResponder];
    if ([NSString filterPhoneNumber:self.phoneNumber.text]) {
        [Networking retrieveData:get_THIRD_LOGIN_WXAPP parameters:@{@"phoneNumber": self.phoneNumber.text}];
        
        SummerPhoneNumberViewController *summerVC = [[SummerPhoneNumberViewController alloc] init];
        summerVC.strPhoneNumber = self.phoneNumber.text;
        [self.navigationController pushViewController:summerVC animated:YES];
    }else{
        [self showHint:@"请输入有效的手机号"];
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
