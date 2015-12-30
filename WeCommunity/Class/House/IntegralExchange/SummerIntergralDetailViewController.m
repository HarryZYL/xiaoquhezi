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
#import "UIViewController+HUD.h"

@interface SummerIntergralDetailViewController ()
@property (nonatomic ,strong)UIButton *btnAddAdress;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)NSMutableArray *addressArrary;
@end

@implementation SummerIntergralDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    self.title = @"兑换详情";
    _addressArrary = [[NSMutableArray alloc] initWithCapacity:1];
    _btnAddAdress = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAddAdress.frame = CGRectMake(0, 74, SCREENSIZE.width, 44);
    _btnAddAdress.backgroundColor = [UIColor whiteColor];
    [_btnAddAdress setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_btnAddAdress setTitle:@"  点击添加地址" forState:UIControlStateNormal];
    _btnAddAdress.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnAddAdress addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAddAdress];
    __weak typeof(self)weakSelf = self;
    UIImageView *contentImg = [UIImageView new];
    [contentImg sd_setImageWithURL:[NSURL URLWithString:_detailGoods[@"picture"]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    contentImg.backgroundColor = [UIColor greenColor];
    [self.view addSubview:contentImg];
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.top.equalTo(weakSelf.btnAddAdress.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.mas_equalTo(204);
        
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = _detailGoods[@"name"];
    nameLab.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];

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
    contentLab.text = _detailGoods[@"description"];
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
    scoreLab.layer.cornerRadius = 5;
    scoreLab.layer.masksToBounds = YES;
    scoreLab.text = [NSString stringWithFormat:@"   %@积分",[_detailGoods[@"point"] stringValue]];
    scoreLab.textColor = [UIColor whiteColor];
    [self.view addSubview:scoreLab];
    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.bottom.right.equalTo(weakSelf.view).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *scoreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [scoreBtn setTitle:@"兑换" forState:UIControlStateNormal];
    if (![_detailGoods[@"remainNumber"] isEqual:[NSNull null]]) {
        if ([_detailGoods[@"remainNumber"] integerValue] == 0) {
            [scoreBtn setTitle:@"兑换完了" forState:UIControlStateNormal];
            [scoreBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    [scoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scoreBtn addTarget:self action:@selector(btnExchange) forControlEvents:UIControlEventTouchUpInside];
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
    [self chooseMyAddressList];
}

- (void)btnExchange{
    User *userModel = [User shareUserDefult];
    if (userModel.userJinDic.jinLevel.integerValue < 1) {
        [self showHint:@"你还不是金马会员，需要去认证提交资料"];
        return;
    }
    if ([_btnAddAdress.currentTitle isEqualToString:@"  点击添加地址"]) {
        [self showHint:@"请选择收货地址"];
        return;
    }
    
    if (userModel.userJinDic.jinPoint.integerValue < [_detailGoods[@"point"] integerValue]) {
        [self showHint:@"积分不够啊!"];
        return;
    }
    if (![_detailGoods[@"remainNumber"] isEqual:[NSNull null]]) {
        if ([_detailGoods[@"remainNumber"] integerValue] == 0) {
            [self showHint:@"已经兑换完了"];
            return;
        }
    }
    NSDictionary *dic = _addressArrary.firstObject;
    [Networking retrieveData:JIN_EXPORY_SURE parameters:@{@"token":[User getUserToken],@"id":_detailGoods[@"id"],@"addressId":dic[@"id"]}];
    userModel.userJinDic.jinPoint = [NSString stringWithFormat:@"%ld",userModel.userJinDic.jinPoint.integerValue -  [_detailGoods[@"point"] integerValue]];
    [self showHint:@"兑换成功"];
}

- (void)chooseMyAddressList{
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:JIN_MY_CITY_LIST parameters:@{@"token": [User getUserToken]} success:^(id responseObject) {
        NSArray *arrData = responseObject;
        NSLog(@"--->%@",responseObject);
        if ([arrData count] > 0) {
            for (NSDictionary *dic in arrData) {
                if ([dic[@"isLastSelected"] boolValue]) {
                    [_addressArrary addObject:dic];
                    [weakSelf setAddressTitleContent];
                    return;
                }
            }
            if (_addressArrary.count < 1) {
                [_addressArrary addObject:[responseObject firstObject]];
            }
            [weakSelf setAddressTitleContent];
        }
        
    }];
}

- (void)setAddressTitleContent{
    NSDictionary *dic = _addressArrary.firstObject;
    [_btnAddAdress setTitleColor:[UIColor colorWithWhite:0.259 alpha:1.000] forState:UIControlStateNormal];
    [_btnAddAdress setTitle:[NSString stringWithFormat:@"  %@ %@%@%@",dic[@"name"],dic[@"provinceName"],dic[@"cityName"],dic[@"districtName"]] forState:UIControlStateNormal];
}

- (void)selectAddress{
    User *userModel = [User shareUserDefult];
    if (userModel.userJinDic.jinLevel.integerValue < 1) {
        [self showHint:@"你还不是金马会员，需要去认证提交资料"];
        return;
    }
    SummerIntergralSelectAddressViewController *selectAddressVC = [[SummerIntergralSelectAddressViewController alloc] init];
    __weak typeof(self)weakSelf = self;
    selectAddressVC.tapSelectAddressBlock = ^(NSDictionary *dic){
        [_addressArrary removeAllObjects];
        [_addressArrary addObject:dic];
        [weakSelf setAddressTitleContent];
    };
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
