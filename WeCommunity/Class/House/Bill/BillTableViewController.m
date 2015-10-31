//
//  BillTableViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BillTableViewController.h"
#import "SummerBillConfirmViewController.h"

@interface BillTableViewController ()
{
    NSMutableArray *billArrary;
    NSArray *commnunityArrary;
}
@end

@implementation BillTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self initWithRoomData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return billArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dicTemp = billArrary[indexPath.row];
    UIImage *payImg = [UIImage imageNamed:@"repair"];
    NSString *strFee = [NSString stringWithFormat:@"%@年%@月物业费,总计：%@元",dicTemp[@"year"],dicTemp[@"month"],dicTemp[@"fee"]];
    [cell configureBillCellTitle:strFee price:dicTemp[@"fee"] image:payImg];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicTemp = billArrary[indexPath.row];
    SummerBillConfirmViewController *confirmVC = [[SummerBillConfirmViewController alloc] init];
    confirmVC.billDic = dicTemp;
    if (commnunityArrary.count == 1) {
        confirmVC.commnityDic = commnunityArrary.firstObject;
    }
    [self.navigationController pushViewController:confirmVC animated:YES];
}

- (void)initWithRoomData{
    [Networking retrieveData:GET_AUTHC_HOUSE parameters:@{@"token": [User getUserToken],@"communityId":[Util getCommunityID]} success:^(id responseObject) {
        commnunityArrary = responseObject;
        NSLog(@"----->%@",responseObject);
        if (commnunityArrary.count == 1) {
            NSDictionary *dic = commnunityArrary.firstObject;
            NSString *roomID = dic[@"id"];
            [self viewDataWithRoomId:roomID];
        }else{
            //需要选择房屋ID
        }
    }];
}

- (void)viewDataWithRoomId:(NSString *)roomID{
    __weak typeof(self)weakVC = self;
    [Networking retrieveData:GET_HOUSE_FEE parameters:@{@"token": [User getUserToken],@"tradeStatus":@"WaitingPay",@"houseId":roomID } success:^(id responseObject) {
        NSLog(@"----->%@",responseObject);
        billArrary = responseObject[@"rows"];
        [weakVC.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

@end
























