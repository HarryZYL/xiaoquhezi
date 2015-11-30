//
//  SummerSelectCommunityViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectCommunityViewController.h"

@interface SummerSelectCommunityViewController ()<UITableViewDelegate ,UITableViewDataSource>
{
    NSInteger pageNumber;
}
@property(nonatomic ,strong)UITableView *mTabelView;
@property(nonatomic ,strong)NSMutableArray *dataArrary;
@end

@implementation SummerSelectCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近的小区";
    _dataArrary = [[NSMutableArray alloc] init];
    UIBarButtonItem *cityItem  = [[UIBarButtonItem alloc] initWithTitle:@"切换城市" style:UIBarButtonItemStylePlain target:self action:@selector(selectCityOfName)];
    self.navigationItem.rightBarButtonItem = cityItem;
    
    _mTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height - 64 - 64 - 60) style:UITableViewStylePlain];
    self.mTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.mTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    _mTabelView.delegate = self;
    _mTabelView.dataSource = self;
    [self.view addSubview:_mTabelView];
    
    [self refreshHeader];
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
        [weakSelf.mTabelView.mj_header endRefreshing];
        weakSelf.dataArrary = responseObject[@"rows"];
        if (weakSelf.dataArrary.count < pageNumber*30) {
            [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.mTabelView reloadData];
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
        [weakSelf.mTabelView.mj_footer endRefreshing];
        weakSelf.dataArrary = responseObject[@"rows"];
        if (weakSelf.dataArrary.count < pageNumber*30) {
            [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.mTabelView reloadData];
    }];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArrary.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

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

- (void)selectCityOfName{
    
}

@end
