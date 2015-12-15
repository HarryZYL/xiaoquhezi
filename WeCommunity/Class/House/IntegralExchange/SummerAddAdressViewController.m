//
//  SummerAddAdressViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerAddAdressViewController.h"
#import "SummerAddressView.h"
@interface SummerAddAdressViewController ()
@property (nonatomic ,strong) SummerAddressView *contentView;

@end

@implementation SummerAddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加收货地址";
    self.view.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    
    __weak typeof(self)weakSelf = self;
    _contentView = [SummerAddressView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.height.mas_equalTo(183);
    }];
        
}



- (IBAction)selectAddressInformation:(id)sender{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
