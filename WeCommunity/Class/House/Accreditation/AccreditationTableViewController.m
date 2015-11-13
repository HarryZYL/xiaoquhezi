//
//  AccreditationTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "AccreditationTableViewController.h"

@interface AccreditationTableViewController ()

@end

@implementation AccreditationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
    self.navigationItem.rightBarButtonItem = postBtn;

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

-(void)viewWillAppear:(BOOL)animated{
    
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
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    [cell configureAccreditationCell:self.dataArray[indexPath.row]];

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}



#pragma mark networking

-(void)retrireveData{
    
    [self.view addSubview:self.loadingView];
//    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSDictionary *parameters = @{@"token":[User getUserToken],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    [Networking retrieveData:getMyAuthentications parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
        
}

-(void)refreshHeader{
//    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    NSDictionary *parameters = @{@"token":[User getUserToken],@"page":@1,@"row":[NSNumber numberWithInt:row]};
    [Networking retrieveData:getMyAuthentications parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    self.page ++;
//    NSDictionary *parameters = @{@"token":[User getUserToken],@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSString stringWithFormat:@"%d",self.page*row]};
    NSDictionary *parameters = @{@"token":[User getUserToken],@"page":@1,@"row":[NSString stringWithFormat:@"%d",self.page*row]};
    [Networking retrieveData:getMyAuthentications parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (self.dataArray.count < self.page*row) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (void)issueCertifySeccessful{
    [self refreshHeader];
}

#pragma mark action

-(void)post:(id)sender{
    AccreditationPostViewController *acVC = [[AccreditationPostViewController alloc] init];
    acVC.delegate = self;
    [self.navigationController pushViewController:acVC animated:YES];
}

@end
