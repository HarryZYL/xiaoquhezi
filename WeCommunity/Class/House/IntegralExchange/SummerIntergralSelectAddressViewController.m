//
//  SummerIntergralSelectAddressViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerIntergralSelectAddressViewController.h"
#import "SummerAddAdressViewController.h"
#import "SummerSelectAddressTableViewCell.h"

@interface SummerIntergralSelectAddressViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mTableView;
@property (nonatomic ,strong)UIButton *btnAddAdress;
@end

@implementation SummerIntergralSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    self.title = @"选择地址";
    _btnAddAdress = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnAddAdress.backgroundColor = [UIColor whiteColor];
    _btnAddAdress.frame = CGRectMake(0, 64, SCREENSIZE.width, 44);
    [_btnAddAdress setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [_btnAddAdress setTitle:@"点击添加地址" forState:UIControlStateNormal];
    [_btnAddAdress addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAddAdress];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 113, SCREENSIZE.width, SCREENSIZE.height - 113) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight = 85;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerSelectAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    [self.view addSubview:_mTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerSelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    
    return cell;
}

- (void)selectAddress{
    SummerAddAdressViewController *addressVC = [[SummerAddAdressViewController alloc] init];
    
    [self.navigationController pushViewController:addressVC animated:YES];
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
