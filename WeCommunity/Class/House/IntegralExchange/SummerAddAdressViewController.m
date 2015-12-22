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
    __weak typeof(self)weakSelf = self;
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnDelete addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setTitle:@"删除地址" forState:UIControlStateNormal];
    [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDelete setBackgroundColor:THEMECOLOR];
    [self.view addSubview:btnDelete];
    [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(35);
    }];
    if (_editeType == 0) {
        self.title = @"添加收货地址";
        [btnDelete setTitle:@"添加地址" forState:UIControlStateNormal];
    }else{
        self.title = @"编辑收货地址";
        
    }
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    
    _contentView = [SummerAddressView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(74);
        make.height.mas_equalTo(183);
    }];
    
        
}

- (void)deleteAddress:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"删除地址"]) {
        
    }else{
        
    }
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
