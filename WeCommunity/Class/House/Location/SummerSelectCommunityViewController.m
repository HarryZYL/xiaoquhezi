//
//  SummerSelectCommunityViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectCommunityViewController.h"
#import "SummerSelectCommunityTableViewCell.h"


@interface SummerSelectCommunityViewController ()<UITextFieldDelegate ,UITableViewDelegate ,UITableViewDataSource ,BMKGeoCodeSearchDelegate>
{
    NSInteger pageNumber;
    NSString *strCityName;
    BOOL isLocation;
}
@property(nonatomic ,strong)UITableView *mTabelView;
@property(nonatomic ,strong)UITextField *mTextField;
@property(nonatomic ,strong)NSMutableArray *dataArrary;
@property(nonatomic ,strong)BMKGeoCodeSearch *geocodeSearch;
@end

@implementation SummerSelectCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self)weakSelf = self;
    self.title = @"附近的小区";
    strCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"CITY_NAME"];
    isLocation = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    _dataArrary = [[NSMutableArray alloc] init];
    UIBarButtonItem *cityItem  = [[UIBarButtonItem alloc] initWithTitle:@"切换城市" style:UIBarButtonItemStylePlain target:self action:@selector(selectCityOfName)];
    self.navigationItem.rightBarButtonItem = cityItem;
    
    CLLocationCoordinate2D locationCoordinate;
    locationCoordinate.longitude = [[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"] doubleValue];
    locationCoordinate.latitude  =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"] doubleValue];
    BMKReverseGeoCodeOption *codeOption = [[BMKReverseGeoCodeOption alloc] init];
    codeOption.reverseGeoPoint = locationCoordinate;
    
    _geocodeSearch = [[BMKGeoCodeSearch alloc] init];
    _geocodeSearch.delegate = self;
    [_geocodeSearch reverseGeoCode:codeOption];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(70);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.mas_equalTo(50);
    }];
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.backgroundColor = [UIColor orangeColor];
    [btnSearch addTarget:self action:@selector(searchContentWithText) forControlEvents:UIControlEventTouchUpInside];
    [btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [bgView addSubview:btnSearch];
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top);
        make.bottom.equalTo(bgView.mas_bottom);
        make.right.equalTo(bgView.mas_right);
        make.width.mas_equalTo(60);
    }];
    
    _mTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width - 80, 50)];
    _mTextField.placeholder = @"搜索附近的小区";
    _mTextField.delegate = self;
    _mTextField.returnKeyType = UIReturnKeySearch;
    UIImageView *searchImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    searchImageView.frame = CGRectMake(0, 0, 26, 36);
    searchImageView.contentMode = UIViewContentModeCenter;
    _mTextField.leftView = searchImageView;
    _mTextField.leftViewMode = UITextFieldViewModeAlways;
    [bgView addSubview:_mTextField];
    
    _mTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 64, SCREENSIZE.width, SCREENSIZE.height - 64 - 64) style:UITableViewStylePlain];
    [_mTabelView registerNib:[UINib nibWithNibName:@"SummerSelectCommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    self.mTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.mTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    
    self.mTabelView.tableFooterView = [UIView new];
    _mTabelView.rowHeight  = 80;
    _mTabelView.delegate   = self;
    _mTabelView.dataSource = self;
    [self.view addSubview:_mTabelView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    strCityName = result.addressDetail.city;
    _mTextField.placeholder = [NSString stringWithFormat:@"搜索%@的小区",strCityName];
    [[NSUserDefaults standardUserDefaults] setObject:strCityName forKey:@"CITY_NAME"];
    [self refreshHeader];
}

#pragma mark - Refreshing

- (void)refreshHeader{
    pageNumber = 1;
    if (!strCityName) {
        return;
    }
    if (_dataArrary.count) {
        _dataArrary = nil;
    }
    NSDictionary *parameters = [self returnPostParama];
    __weak typeof(self) weakSelf = self;
    if (isLocation) {
        [Networking retrieveData:getNearbyCommnity parameters:parameters success:^(id responseObject) {
            [weakSelf.mTabelView.mj_header endRefreshing];
            weakSelf.dataArrary = responseObject[@"rows"];
            if (weakSelf.dataArrary.count < pageNumber*30) {
                [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.mTabelView reloadData];
        }];
    }else{
        [Networking retrieveData:getCommnityOfCity parameters:parameters success:^(id responseObject) {
            [weakSelf.mTabelView.mj_header endRefreshing];
            weakSelf.dataArrary = responseObject[@"rows"];
            if (weakSelf.dataArrary.count < pageNumber*30) {
                [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.mTabelView reloadData];
        }];
    }
    
}

- (NSDictionary *)returnPostParama{
    NSDictionary *parameters;
    if (isLocation) {
        if (_mTextField.text.length > 0) {
            parameters = @{@"baiduPosLong": [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                           @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                           @"page":[NSNumber numberWithInteger:pageNumber],
                           @"cityName":strCityName,
                           @"name":_mTextField.text,
                           @"row":@30};
        }else{
            parameters = @{@"baiduPosLong":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                           @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                           @"page":[NSNumber numberWithInteger:pageNumber],
                           @"cityName":strCityName,
                           @"row":@30};
        }
        
    }else{
        if (_mTextField.text.length > 0) {
            parameters = @{@"cityName": strCityName,
                           @"name":_mTextField.text,
                           @"baiduPosLong": [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                           @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                           @"page":[NSNumber numberWithInteger:pageNumber],
                           @"row":@30};
        }else{
            parameters = @{@"cityName": strCityName,
                           @"baiduPosLong": [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                           @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                           @"page":[NSNumber numberWithInteger:pageNumber],
                           @"row":@30};
        }
    }
    return parameters;
}

- (void)refreshFooter{
    pageNumber ++;
    NSDictionary *parameters = [self returnPostParama];
    __weak typeof(self) weakSelf = self;
    if (isLocation) {
        [Networking retrieveData:getNearbyCommnity parameters:parameters success:^(id responseObject) {
            [weakSelf.mTabelView.mj_footer endRefreshing];
            weakSelf.dataArrary = responseObject[@"rows"];
            if (weakSelf.dataArrary.count < pageNumber*30) {
                [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.mTabelView reloadData];
        }];
    }else{
        [Networking retrieveData:getCommnityOfCity parameters:parameters success:^(id responseObject) {
            [weakSelf.mTabelView.mj_footer endRefreshing];
            weakSelf.dataArrary = responseObject[@"rows"];
            if (weakSelf.dataArrary.count < pageNumber*30) {
                [weakSelf.mTabelView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.mTabelView reloadData];
        }];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerSelectCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    NSDictionary *dicTem = _dataArrary[indexPath.row];
    cell.cellNameLab.text = dicTem[@"name"];
    cell.cellDetailLab.text = dicTem[@"roadName"];
    if ([dicTem[@"distance"] integerValue] > 999) {
        cell.cellDistanceLab.text = [NSString stringWithFormat:@"%.2fKm",[dicTem[@"distance"] floatValue]/1000];
    }else{
        cell.cellDistanceLab.text = [NSString stringWithFormat:@"%@m",dicTem[@"distance"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicTemp = _dataArrary[indexPath.row];
    
    NSDictionary *dicTempCommunity = [FileManager getData:@"historyCommynity"];
    
    NSMutableArray *arrCommunity = [[NSMutableArray alloc] initWithArray:dicTempCommunity[@"communityNames"]];

    NSDictionary *community = @{
                                @"communityName":dicTemp[@"name"],
                                @"communityID":dicTemp[@"id"]
                                };
    if (![arrCommunity containsObject:community]) {
        [arrCommunity addObject:community];
        [FileManager saveDataToFile:community filePath:@"Community"];
        [User SaveAuthentication];
        [FileManager saveDataToFile:@{@"communityNames": arrCommunity} filePath:@"historyCommynity"];
    }
    if (_backViewBlock) {
        _backViewBlock(community);
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchContentWithText{
    if ([[_mTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] < 1) {
        return;
    }
    
    pageNumber = 1;
    NSDictionary *parama = [self returnPostParama];
    
    [self receveCityCommunityWithParama:parama];
}

- (void)selectCityOfName{
    __weak typeof(self)weakSelf = self;
    SummerSelectCityTableViewController *selectCityVC = [[SummerSelectCityTableViewController alloc] init];
    selectCityVC.cityBlock = ^(NSDictionary *dicCity){
        [weakSelf selectCityNameWithCityIDWithCityName:dicCity];
    };
    [self.navigationController pushViewController:selectCityVC animated:YES];
}

- (void)selectCityNameWithCityIDWithCityName:(NSDictionary *)dicTemp{
    pageNumber = 1;
    isLocation = NO;
    strCityName = dicTemp[@"name"];
    self.title = strCityName;
    _mTextField.placeholder = [NSString stringWithFormat:@"搜索%@的小区",dicTemp[@"name"]];
    NSDictionary *parama = @{@"cityName": dicTemp[@"name"],
                             @"baiduPosLong": [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LONG"],
                             @"baiduPosLati":[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_LAT"],
                             @"page":[NSNumber numberWithInteger:pageNumber],
                             @"row":@"30"};
    [self receveCityCommunityWithParama:parama];
}

- (void)receveCityCommunityWithParama:(NSDictionary *)paraDic{
    _dataArrary = nil;
    
    [Networking retrieveData:getCommnityOfCity parameters:paraDic success:^(id responseObject) {
        if (pageNumber * 30 > [responseObject[@"total"] integerValue]) {
            [_mTabelView.mj_footer endRefreshingWithNoMoreData];
            _dataArrary = responseObject[@"rows"];
            [_mTabelView reloadData];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    _geocodeSearch.delegate = nil;
}

@end























