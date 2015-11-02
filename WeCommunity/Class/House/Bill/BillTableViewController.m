//
//  BillTableViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BillTableViewController.h"
#import "UIViewController+HUD.h"
#import "SummerBillConfirmViewController.h"

@interface BillTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *billArrary;/**<返回的物业费*/
    NSArray *commnunityArrary; /**<返回的小区*/
    NSDictionary *selectCommnunityDic;/**<选择的小区信息*/
    NSArray *areaDataArrary;//area数组
    BOOL isEdite;
}

@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation BillTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载中";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"多选" style:UIBarButtonItemStylePlain target:self action:@selector(borderListEdite)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.view addSubview:_loadingView];
    [self initWithRoomData];
}

- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    [self setTableViewFooterView];
}

- (void)borderListEdite{
    if (isEdite) {
        self.tableView.editing = NO;
    }else{
        self.tableView.editing = YES;
    }
    isEdite = !isEdite;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTableViewFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 60)];
    footerView.backgroundColor = [UIColor whiteColor];
    UIButton *btnSure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSure.frame = CGRectMake(10, 5, SCREENSIZE.width - 20, 50);
    [btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [btnSure addTarget:self action:@selector(sureOrderList) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    
    [footerView addSubview:btnSure];
    self.tableView.tableFooterView = footerView;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

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
    NSDictionary *dic = [billArrary objectAtIndex:indexPath.row];
    if (![dic[@"tradeStatus"] isEqualToString:@"WaitingPay"]) {
        return;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)initWithRoomData{
    [Networking retrieveData:GET_AUTHC_HOUSE parameters:@{@"token": [User getUserToken],@"communityId":[Util getCommunityID]} success:^(id responseObject) {
        [self.loadingView removeFromSuperview];
        commnunityArrary = responseObject;
        NSLog(@"----->%@",responseObject);
        if (commnunityArrary.count == 1) {//本小区房屋一个
            NSDictionary *dic = commnunityArrary.firstObject;
            selectCommnunityDic = dic;
            NSString *roomID = dic[@"id"];
            [self viewDataWithRoomId:roomID];
        }else if(commnunityArrary.count > 1){
            //需要选择房屋ID
            areaDataArrary = responseObject;
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height - 150, SCREENSIZE.width, 150)];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            [self.view addSubview:pickerView];
            [pickerView reloadAllComponents];
        }else{
            [self showHint:@"没有未交的物业费"];
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return areaDataArrary.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *strTemp = [areaDataArrary[row][@"parentNames"] componentsJoinedByString:@""];
    return strTemp;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSDictionary *dic = areaDataArrary[row];
    selectCommnunityDic = dic;
    NSString *roomID = dic[@"id"];
    [self viewDataWithRoomId:roomID];
    [pickerView removeFromSuperview];
    [self setTableView];
}

- (void)viewDataWithRoomId:(NSString *)roomID{
    __weak typeof(self)weakVC = self;
    [Networking retrieveData:GET_HOUSE_FEE parameters:@{@"token": [User getUserToken],@"tradeStatus":@"WaitingPay",@"houseId":roomID } success:^(id responseObject) {
        NSLog(@"----->%@",responseObject);
        billArrary = responseObject[@"rows"];
        [weakVC.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)sureOrderList{
    SummerBillConfirmViewController *confirmVC = [[SummerBillConfirmViewController alloc] init];
    if (billArrary.count == 1) {
        NSDictionary *dicTemp = billArrary.firstObject;
        confirmVC.commnityArrary = billArrary;
        confirmVC.billOrderIDArrary = @[dicTemp[@"id"]];
        confirmVC.commnityDic = commnunityArrary.firstObject;
    }else{
        NSArray *indexPathArrary = [self.tableView indexPathsForSelectedRows];
        NSMutableArray *billSelectArrary = [[NSMutableArray alloc] init];
        NSMutableArray *idsArrary = [[NSMutableArray alloc] init];
        for (NSIndexPath *index in indexPathArrary) {
            [billSelectArrary addObject:billArrary[index.row]];
            NSDictionary *dic = billArrary[index.row];
            [idsArrary addObject:dic[@"id"]];
        }
        confirmVC.commnityArrary    = billSelectArrary;
        confirmVC.billOrderIDArrary = idsArrary;
        confirmVC.commnityDic       = selectCommnunityDic;
    }
    [self.navigationController pushViewController:confirmVC animated:YES];
}

@end
























