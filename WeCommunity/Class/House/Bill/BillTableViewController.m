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
    [self viewDataWithRoomId:_roomDic[@"id"]];
    [self setTableView];
    [self setBootomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self viewDataWithRoomId:_roomDic[@"id"]];
    totalBillMoney = 0.0;
    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
//    self.tableView.frame = CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - 100);
}

- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height - 64 - 60) style:UITableViewStyleGrouped];
    self.tableView.autoresizesSubviews = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.editing = YES;
    self.tableView.rowHeight = 80;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
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
        
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENSIZE.width - 20, 60)];
        labName.tag = 1;
        [headerView addSubview:labName];
    }
    UILabel *labName = (UILabel *)[headerView viewWithTag:1];
    labName.text = [_roomDic[@"parentNames"] componentsJoinedByString:@""];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return billArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dicTemp = billArrary[indexPath.row];
    NSString *strFee = [NSString stringWithFormat:@"%@年%@月物业费，总计：%@元",dicTemp[@"year"],dicTemp[@"month"],dicTemp[@"fee"]];
    [cell configureBillCellTitle:strFee price:dicTemp[@"fee"] image:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [billArrary objectAtIndex:indexPath.row];
    [arrarySelect removeObject:dic];
    totalBillMoney += [dic[@"fee"] floatValue];
    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [billArrary objectAtIndex:indexPath.row];
    [arrarySelect addObject:dic];
    totalBillMoney -= [dic[@"fee"] floatValue];
    botomView.totalMoney.text = [NSString stringWithFormat:@"总计：%.2f元",totalBillMoney];
}

- (void)viewDataWithRoomId:(NSString *)roomID{
    __weak typeof(self)weakVC = self;
    [Networking retrieveData:GET_HOUSE_FEE parameters:@{@"token": [User getUserToken],@"tradeStatus":@"WaitingPay",@"houseId":roomID } success:^(id responseObject) {
        NSLog(@"----->%@",responseObject);
        billArrary = responseObject[@"rows"];
        [weakVC.tableView reloadData];
    }];
}

//确认订单
- (void)sureOrderList{
    if ([self.tableView indexPathsForSelectedRows].count < 1) {
        [self showHint:@"记得选择，才能缴费"];
        return;
    }
    SummerBillConfirmViewController *confirmVC = [[SummerBillConfirmViewController alloc] init];
    NSArray *indexPathArrary = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *selectBillArrary = [[NSMutableArray alloc] init];
    
    NSMutableArray *arraryIDs = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in indexPathArrary) {
        NSDictionary *dicTem = billArrary[indexPath.row];
        [arraryIDs addObject:dicTem[@"id"]];
        [selectBillArrary addObject:dicTem];
    }
    confirmVC.commnityArrary = selectBillArrary;
    confirmVC.billOrderIDArrary = arraryIDs;
    confirmVC.commnityDic = self.roomDic;
    [self.navigationController pushViewController:confirmVC animated:YES];
}

@end
























