//
//  SummerCommunityBrowserViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//
#import "MBProgressHUD.h"
#import "UIViewController+HUD.h"
#import "SummerCommunityBrowserViewController.h"
#import "SummerCommunityBrowserTableViewCell.h"

@interface SummerCommunityBrowserViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSMutableArray *arraryData;
    UITableView *mTableView;
    UIImageView *headerView;
}
@end

@implementation SummerCommunityBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"小区一览";
    headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, 190)];
    headerView.image = [UIImage imageNamed:@"my_personal_not_login_bg.jpg"];
    [self.view addSubview:headerView];
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    
    arraryData = [[NSMutableArray alloc] init];
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 190 + 74, SCREENSIZE.width - 20, SCREENSIZE.height - 190 - 74) style:UITableViewStylePlain];
    mTableView.backgroundColor = self.view.backgroundColor;
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.rowHeight = 60;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:mTableView];
    [self getReceveData];
}

- (void)getReceveData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
    [Networking retrieveData:get_Nearby_Phones_list parameters:@{@"communityId": [Util getCommunityID]} success:^(id responseObject) {
        [hud removeFromSuperview];
        arraryData = responseObject;
        if (arraryData.count < 1) {
            [self showHint:@"暂无信息"];
        }
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
    if (indexPath.row%2 == 0) {
        cell.bgView.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
    }else{
        cell.bgView.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.row == arraryData.count - 1) {
        cell.lineHorizontalBootom.hidden = NO;
    }
    NSDictionary *dicTemp = arraryData[indexPath.row];
    
    cell.titleLab.text = dicTemp[@"name"];
    cell.phoneLab.text = dicTemp[@"phone"];
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
