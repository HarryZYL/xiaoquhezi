//
//  SummerIntergralDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerIntergralDetailViewController.h"
#import "SummerIntergralSelectAddressViewController.h"
#import "SummerIntergralDetailTableViewCell.h"

@interface SummerIntergralDetailViewController ()
@property (nonatomic ,strong)UIButton *btnAddAdress;
@end

@implementation SummerIntergralDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"兑换详情";
    _btnAddAdress = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAddAdress.frame = CGRectMake(0, 64, SCREENSIZE.width, 40);
    _btnAddAdress.backgroundColor = [UIColor whiteColor];
    [_btnAddAdress setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_btnAddAdress setTitle:@"  点击添加地址" forState:UIControlStateNormal];
    _btnAddAdress.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _btnAddAdress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnAddAdress addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAddAdress];
    __weak typeof(self)weakSelf = self;
    UIImageView *contentImg = [UIImageView new];
    contentImg.image = [UIImage imageNamed:@"house3"];
    contentImg.backgroundColor = [UIColor greenColor];
    [self.view addSubview:contentImg];
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.top.equalTo(weakSelf.btnAddAdress.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.mas_equalTo(204);
        
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"兑换书房咖啡优惠券";
    nameLab.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
//    nameLab.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    nameLab.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.top.equalTo(contentImg.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.mas_equalTo(17);
    }];
    UILabel *lineLab = [UILabel new];
    lineLab.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    [self.view addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.top.equalTo(nameLab.mas_bottom).offset(10);
        make.height.mas_equalTo(.5);
    }];
    
    UILabel *contentLab = [UILabel new];
    contentLab.textColor = [UIColor colorWithWhite:.259 alpha:1];
    contentLab.text = @"文字介绍";
    [contentLab sizeToFit];
    [self.view addSubview:contentLab];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.top.equalTo(lineLab.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottom.lessThanOrEqualTo(weakSelf.view.mas_bottom).offset(10);
    }];
    
    UILabel *scoreLab = [UILabel new];
    scoreLab.backgroundColor = THEMECOLOR;
    scoreLab.text = @"   3500积分";
    scoreLab.textColor = [UIColor whiteColor];
    [self.view addSubview:scoreLab];
    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.bottom.right.equalTo(weakSelf.view).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *scoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [scoreBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [scoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scoreBtn.layer.cornerRadius = 5;
    scoreBtn.layer.masksToBounds = YES;
    scoreBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    scoreBtn.layer.borderWidth = 1;
    [self.view addSubview:scoreBtn];
    
    [scoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(scoreLab.mas_right).offset(-10);
        make.centerY.equalTo(scoreLab.mas_centerY);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(71);
    }];
}



- (void)selectAddress{
    SummerIntergralSelectAddressViewController *selectAddressVC = [[SummerIntergralSelectAddressViewController alloc] init];
    [self.navigationController pushViewController:selectAddressVC animated:YES];
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
