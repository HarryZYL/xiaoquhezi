//
//  SummerEditeAddressViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/14.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerEditeAddressViewController.h"

#import "SummerAddAdressViewController.h"
#import "SummerSelectAddressTableViewCell.h"

@interface SummerEditeAddressViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mTableView;
@property (nonatomic ,strong)NSMutableArray *addressArrary;
@end

@implementation SummerEditeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑收货地址";
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStylePlain];
    _mTableView.delegate   = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight  = 85;
//    _mTableView.editing = YES;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerSelectAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    [self.view addSubview:_mTableView];
    [self receveAddress];
}

- (void)receveAddress{
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:JIN_MY_CITY_LIST parameters:@{@"token": [User getUserToken]} success:^(id responseObject) {
//        for (NSDictionary *dic in (NSArray *)responseObject) {
//            [weakSelf.addressArrary addObject:dic];
//        }
        _addressArrary = responseObject;
        [weakSelf.mTableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerSelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    [cell confirmCellContentWithData:_addressArrary[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerAddAdressViewController *editeVC = [[SummerAddAdressViewController alloc] init];
    editeVC.editeType = SummerEditeAddAdressTypeEidteOrDelete;
    editeVC.addressDic = _addressArrary[indexPath.row];
    __weak typeof(self)weakSelf = self;
    editeVC.updataAddressSeccess = ^{
        [weakSelf receveAddress];
    };
    [self.navigationController pushViewController:editeVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
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
