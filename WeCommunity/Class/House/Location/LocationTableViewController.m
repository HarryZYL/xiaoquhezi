//
//  LocationTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "LocationTableViewController.h"

@interface LocationTableViewController ()
{
    NSInteger pageNumber;
}

@property(nonatomic, strong)NSMutableArray *dataArrary;
@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"切换小区";
    _dataArrary = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[BasicTableViewCell class ] forCellReuseIdentifier:@"cell"];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self refreshHeader];
    self.locationArr = @[@"玉兰香苑",@"幸福小区"];
    self.locationID = @[@"1",@"813"];
    
    
}

#pragma mark - Refreshing

- (void)refreshHeader{
    pageNumber = 1;
    NSDictionary *parameters = @{@"baiduPosLong":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                                 @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                                 @"page":[NSNumber numberWithInteger:pageNumber],
                                 @"row":@30};
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:getNearbyCommnity parameters:parameters success:^(id responseObject) {
        [weakSelf.tableView.header endRefreshing];
        weakSelf.dataArrary = responseObject[@"rows"];
        if (weakSelf.dataArrary.count < pageNumber*30) {
            [weakSelf.tableView.footer noticeNoMoreData];
        }
        [weakSelf.tableView reloadData];
    }];
}

- (void)refreshFooter{
    pageNumber ++;
    NSDictionary *dicLocation = [FileManager getData:@"userlocation"];
    CLLocation *location = dicLocation[@"location"];
    NSDictionary *parameters = @{@"baiduPosLong": @(location.coordinate.longitude),
                                 @"baiduPosLati":@(location.coordinate.latitude),
                                 @"page":[NSNumber numberWithInteger:pageNumber],
                                 @"row":@30};
    __weak typeof(self) weakSelf = self;
    [Networking retrieveData:getNearbyCommnity parameters:parameters success:^(id responseObject) {
        [weakSelf.tableView.footer endRefreshing];
        weakSelf.dataArrary = responseObject[@"rows"];
        if (weakSelf.dataArrary.count < pageNumber*30) {
            [weakSelf.tableView.footer noticeNoMoreData];
        }
        [weakSelf.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
//    return self.locationArr.count;
    return self.dataArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.textLabel.text = self.locationArr[indexPath.row];
    NSDictionary * tempDic = self.dataArrary[indexPath.row];
    cell.textLabel.text = tempDic[@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * tempDic = self.dataArrary[indexPath.row];
    NSDictionary *community = @{
                                @"communityName":tempDic[@"name"],
                                @"communityID":tempDic[@"id"]
                                };
    [FileManager saveDataToFile:community filePath:@"Community"];
    [User SaveAuthentication];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

@end
