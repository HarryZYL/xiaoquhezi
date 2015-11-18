//
//  SummerBillRoomViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBillRoomViewController.h"
#import "BillTableViewController.h"
#import "UIViewController+HUD.h"

@interface SummerBillRoomViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    UITableView *mTalbeView;
    NSArray *arraryData;
}
@end

@implementation SummerBillRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mTalbeView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    mTalbeView.delegate = self;
    mTalbeView.dataSource = self;
    mTalbeView.rowHeight = 80;
    mTalbeView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:mTalbeView];
    [self receveData];
}

- (void)receveData{
    [Networking retrieveData:GET_PROPERTY_HOUSE_FEE parameters:@{@"token": [User getUserToken],
                                                                 @"communityId":[Util getCommunityID]} success:^(id responseObject) {
                                                                     arraryData = responseObject;
                                                                     [mTalbeView reloadData];
                                                                 }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arraryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *payBtn = [[UILabel alloc] init];
        [payBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1]];
        payBtn.font = [UIFont systemFontOfSize:14];
        payBtn.textAlignment = NSTextAlignmentCenter;
        payBtn.textColor = [UIColor whiteColor];
        payBtn.layer.cornerRadius = 3;
        payBtn.layer.masksToBounds = YES;
        payBtn.tag = 1;
        payBtn.frame = CGRectMake(SCREENSIZE.width - 80, 25, 60, 30);
        [cell addSubview:payBtn];
    }
    UILabel *payButton = (UILabel *)[cell viewWithTag:1];
    NSDictionary *dicTemp = arraryData[indexPath.row];
    cell.textLabel.text = [dicTemp[@"parentNames"] componentsJoinedByString:@""];
    if ([dicTemp[@"payed"] boolValue]) {
        [payButton setText:@"已交清"];
    }else{
        [payButton setText:@"去缴费"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicTemp = arraryData[indexPath.row];
    if ([dicTemp[@"payed"] boolValue]) {
        [self showHint:@"已经交过了"];
        return;
    }
    BillTableViewController *tableVC = [[BillTableViewController alloc] init];
    tableVC.roomDic = dicTemp;
    [self.navigationController pushViewController:tableVC animated:YES];
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
