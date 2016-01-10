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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrireveData) name:@"NoticeUpdate" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[ BasicTableViewCell class ] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    [self.tableView addSubview:self.loadingView];
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
    
    [cell configureNoticeCellTitle:notice.title detail:notice.contentTxt date:notice.createTime top:notice.isTop detail:NO withReplyCount:notice.replyCount];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Notice *detailID = [[Notice alloc] initWithData:self.dataArray[indexPath.section]];
    SummerNoticeCenterDetailViewController *textVC = [[SummerNoticeCenterDetailViewController alloc] init];
    textVC.detailNotice = [[Notice alloc] initWithData:self.dataArray[indexPath.section]];
    textVC.strNoticeID = detailID.Objectid;
    [self.navigationController pushViewController:textVC animated:YES];
}

#pragma mark networking

-(void)retrireveData{
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    self.page ++;
    NSDictionary *parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
    [Networking retrieveData:getNoticesOfCommunity parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (self.dataArray.count < row*self.page) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

@end
