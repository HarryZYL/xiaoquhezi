//
//  NoticeTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/17/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "NoticeTableViewController.h"

@interface NoticeTableViewController ()

@end

@implementation NoticeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[ BasicTableViewCell class ] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    [self retrireveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Notice *notice = [[Notice alloc] initWithData:self.dataArray[indexPath.section]];
    
    [cell configureNoticeCellTitle:notice.title detail:notice.contentTxt date:notice.createTime top:notice.isTop detail:NO];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextDetailTableViewController *textVC = [[TextDetailTableViewController alloc] init];
    textVC.notice = [[Notice alloc] initWithData:self.dataArray[indexPath.section]];
    textVC.title = @"详情";
    textVC.function = @"notice";
    [self.navigationController pushViewController:textVC animated:YES];
}

#pragma mark networking

-(void)retrireveData{
    [self.tableView addSubview:self.loadingView];
    NSDictionary *parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    [Networking retrieveData:getNoticesOfCommunity parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
}

-(void)refreshHeader{
    
    NSDictionary *parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    [Networking retrieveData:getNoticesOfCommunity parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    self.page ++;
    NSDictionary *parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
    [Networking retrieveData:getNoticesOfCommunity parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        if (self.dataArray.count < row*self.page) {
            [self.tableView.footer noticeNoMoreData];
        }
    }];
}

@end
