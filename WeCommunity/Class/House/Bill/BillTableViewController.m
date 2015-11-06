//
//  BillTableViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//
#import "SummerBillBootomView.h"
#import "BillTableViewController.h"
#import "UIViewController+HUD.h"
#import "SummerBillTableViewCell.h"
#import "SummerBillConfirmViewController.h"

@interface BillTableViewController ()
{
    NSMutableArray *billArrary;/**<返回的物业费*/
    float totalBillMoney;
    SummerBillBootomView *botomView;
    NSMutableArray *arrarySelect;
}

@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation BillTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物业费账单";
    self.view.backgroundColor = [UIColor whiteColor];
    arrarySelect = [[NSMutableArray alloc] init];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载中";
    [self.view addSubview:_loadingView];
//    [self viewDataWithRoomId:_roomDic[@"id"]];
    [self setTableView];
    [self setBootomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    totalBillMoney = 0.0;
    [self viewDataWithRoomId:_roomDic[@"id"]];
//
//    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
}

- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height - 64 - 60) style:UITableViewStyleGrouped];
    self.tableView.autoresizesSubviews = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.rowHeight = 64;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SummerBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (void)setBootomView{
    botomView = [[SummerBillBootomView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - 60, SCREENSIZE.width, 60)];
    botomView.backgroundColor = [UIColor whiteColor];
    [botomView.btnSure addTarget:self action:@selector(sureOrderList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [tableView dequeueReusableCellWithIdentifier:@"cellHeader"];
    if (!headerView) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 60)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *grayLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 8)];
        grayLab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        [headerView addSubview:grayLab];
        
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, SCREENSIZE.width - 20, 53)];
        labName.tag = 1;
        [headerView addSubview:labName];
    }
    UILabel *labName = (UILabel *)[headerView viewWithTag:1];
    labName.text = [_roomDic[@"parentNames"] componentsJoinedByString:@""];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 61;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return billArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SummerBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dicTemp = billArrary[indexPath.row];
    NSArray *arraryIndex = [tableView indexPathsForSelectedRows];
    if ([arraryIndex containsObject:indexPath]) {
        [cell configureBillCellConten:dicTemp withSelectOrNot:YES];
    }else{
        [cell configureBillCellConten:dicTemp withSelectOrNot:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [billArrary objectAtIndex:indexPath.row];
    [arrarySelect addObject:dic];
    totalBillMoney -= [dic[@"fee"] floatValue];
    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
    SummerBillTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.cellImgSelect.image = [UIImage imageNamed:@"未勾选－设计"];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [billArrary objectAtIndex:indexPath.row];
    [arrarySelect removeObject:dic];
    totalBillMoney += [dic[@"fee"] floatValue];
    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
    SummerBillTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.cellImgSelect.image = [UIImage imageNamed:@"选中－设计"];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)viewDataWithRoomId:(NSString *)roomID{
    __weak typeof(self)weakVC = self;
    [Networking retrieveData:GET_HOUSE_FEE parameters:@{@"token": [User getUserToken],@"tradeStatus":@"WaitingPay",@"houseId":roomID } success:^(id responseObject) {
        NSLog(@"----->%@",responseObject);
        billArrary = responseObject[@"rows"];
        for (NSDictionary *dicTemp in billArrary) {
            totalBillMoney += [dicTemp[@"fee"] floatValue];
        }
        botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
        [weakVC.tableView reloadData];
    }];
}

//确认订单
- (void)sureOrderList{
    if ([self.tableView indexPathsForSelectedRows].count >= billArrary.count) {
        [self showHint:@"记得选择，才能缴费"];
        return;
    }
    SummerBillConfirmViewController *confirmVC = [[SummerBillConfirmViewController alloc] init];
    NSArray *indexPathArrary = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *selectBillArrary = [[NSMutableArray alloc] initWithArray:billArrary];
    
    NSMutableArray *arraryIDs = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in indexPathArrary) {
        [selectBillArrary removeObject:billArrary[indexPath.row]];
    }
    for (NSDictionary *dicTemp in selectBillArrary) {
        [arraryIDs addObject:dicTemp[@"id"]];
    }
    confirmVC.commnityArrary = selectBillArrary;
    confirmVC.billOrderIDArrary = arraryIDs;
    confirmVC.commnityDic = self.roomDic;
    [self.navigationController pushViewController:confirmVC animated:YES];
}

@end
























