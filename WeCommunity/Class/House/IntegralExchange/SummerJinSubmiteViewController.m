//
//  SummerJinSubmiteViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/23.
//  Copyright © 2015年 Jack. All rights reserved.
//
#import "NSString+HTML.h"
#import "UIViewController+HUD.h"
#import "SummerJinSubmiteViewController.h"

@interface SummerJinSubmiteViewController ()
@property (nonatomic ,strong) UITextField *nameText;
@property (nonatomic ,strong) UITextField *cdCardText;
@end

@implementation SummerJinSubmiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    _nameText = [UITextField new];
    _nameText.borderStyle = UITextBorderStyleRoundedRect;
    _nameText.placeholder = @"姓名";
    [self.view addSubview:_nameText];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(20);
        make.top.equalTo(weakSelf.view.mas_top).offset(80);
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
        make.height.mas_equalTo(@30);
    }];
    _cdCardText = [UITextField new];
    _cdCardText.placeholder = @"身份证号";
    _cdCardText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_cdCardText];
    [_cdCardText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(20);
        make.top.equalTo(weakSelf.nameText.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
        make.height.mas_equalTo(@30);
    }];
    UIButton *btnSubmite = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmite setTitle:@"提交信息" forState:UIControlStateNormal];
    [btnSubmite setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [btnSubmite addTarget:self action:@selector(submiteInformation) forControlEvents:UIControlEventTouchUpInside];
    btnSubmite.layer.cornerRadius = 5;
    btnSubmite.layer.masksToBounds = YES;
    btnSubmite.layer.borderWidth = .5;
    btnSubmite.layer.borderColor = THEMECOLOR.CGColor;
    [self.view addSubview:btnSubmite];
    [btnSubmite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(40);
        make.top.equalTo(weakSelf.cdCardText.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-40);
        make.height.mas_equalTo(@30);
    }];
}

- (void)submiteInformation{
    if (_nameText.text.length < 1) {
        [self showHint:@"填写姓名"];
        return;
    }
    if (![NSString filterIDCard:_cdCardText.text]) {
        [self showHint:@"填写正确的身份证号"];
        return;
    }
    NSLog(@"提交信息");
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
