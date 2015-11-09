//
//  SummerCommunityBrowserViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerCommunityBrowserViewController.h"
#import "SummerCommunityBrowserTableViewCell.h"

@interface SummerCommunityBrowserViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSMutableArray *arraryData;
    UITableView *mTableView;
}
@end

@implementation SummerCommunityBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"小区一览";
    arraryData = [[NSMutableArray alloc] init];
    mTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.rowHeight = 70;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:mTableView];
    [self getReceveData];
}

- (void)getReceveData{
    [Networking retrieveData:get_Nearby_Phones_list parameters:@{@"communityId": [Util getCommunityID]} success:^(id responseObject) {
        arraryData = responseObject;
        NSLog(@"123");
        [mTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arraryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerCommunityBrowserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerCommunityBrowserTableViewCell" owner:self options:nil].firstObject;
        [cell.btnPhoneNumber addTarget:self action:@selector(communityPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSDictionary *dicTemp = arraryData[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@：%@",dicTemp[@"name"],dicTemp[@"phone"]];
    return cell;
}

- (void)communityPhone:(UIButton *)sender{
    NSIndexPath *index = [mTableView indexPathForCell:(UITableViewCell *)sender.superview.superview.superview];
    NSDictionary *dic = arraryData[index.row];
    NSString *strTemp = [NSString stringWithFormat:@"telprompt:%@",[dic[@"phone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strTemp]];
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
