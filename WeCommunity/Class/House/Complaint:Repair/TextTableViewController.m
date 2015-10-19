//
//  TextTableViewController.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "TextTableViewController.h"

@interface TextTableViewController ()

@end

@implementation TextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    if ([self.function isEqualToString:@"complaint"]) {
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"投诉" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
    }else if([self.function isEqualToString:@"repair"]){
        UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"报修" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
        self.navigationItem.rightBarButtonItem = postBtn;
    }
    
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    
    if ([User judgeLogin]) {
        [self retrireveData];
    }else{
        [Util alertNetworingError:@"请先登录"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
    
    TextDeal *textDeal = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
    
    [cell configureTextCellImage:[NSURL URLWithString:textDeal.textType[@"logo"]] title:textDeal.content date:textDeal.createTime deal:textDeal.status pictures:textDeal.pictures detail:NO];

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    TextDeal *textDeal = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
    if (![textDeal.pictures isEqual:[NSNull null]]) {
        if ([textDeal.pictures[0] isEqualToString:@""] ) {
            return 120;
        }else{
            return 180;
        }
    }else{
         return 120;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextDetailTableViewController *textVC = [[TextDetailTableViewController alloc] init];
    textVC.textDeal = [[TextDeal alloc] initWithData:self.dataArray[indexPath.section] textType:self.function];
    textVC.title = @"详情";
    textVC.function = @"text";
    [self.navigationController pushViewController:textVC animated:YES];
    
}

# pragma mark retrieve data


-(void)retrireveData{

    [self.view addSubview:self.loadingView];
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
}

-(void)refreshHeader{
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    self.page ++;
    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSString *url = @"";
    if ([self.function isEqualToString:@"complaint"]) {
        url = getMyComplaintsOfCommunity;
    }else if([self.function isEqualToString:@"repair"]){
        url = getMyRepairsOfCommunity;
    }
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        if (self.dataArray.count < row*self.page) {
            [self.tableView.footer noticeNoMoreData];
        }
    }];
}



# pragma mark - function
-(void)post:(id)sender{
    if ([Util judgeAuthentication]) {
        TextPostViewController *textPostVC = [[TextPostViewController alloc] init];
        textPostVC.function = self.function;
        NSString *firstTitle = self.navigationItem.title;
        NSString *title = [NSString stringWithFormat:@"发布%@",firstTitle];
        textPostVC.navigationItem.title = title;
        [self.navigationController pushViewController:textPostVC animated:YES];
    }else{
        [Util alertNetworingError:@"只有认证用户才能发布"];
    }
    
}




@end
