//
//  RentViewController.m
//  WeCommunity
//
//  Created by Harry on 7/24/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "RentViewController.h"
#import "AccreditationTableViewController.h"
#import "SummerSelectSellerOrOrderView.h"
@interface RentViewController ()
{
    SummerSelectSellerOrOrderView *orderSelectView;
}
@property (nonatomic ,strong)AdScrollView *adView;
@end

@implementation RentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _adView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(post:)];
    self.navigationItem.rightBarButtonItem = postBtn;
    
    if (self.playAdvertise) {
        [self setupAdvertisement];
    }
    
    [self setupChooseList];
    [self setupTableView];
    
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    self.loadingView.titleLabel.text = @"正在加载";
    self.communityAll = NO;
    self.houseTypeArr = @[@"Sale",@"Rent"];
    [self retrireveData];
    
    orderSelectView = [[SummerSelectSellerOrOrderView alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 100, 64, 100, 90)];
    orderSelectView.alpha = 0;
    [orderSelectView.btnRent addTarget:self action:@selector(postButtonRent:) forControlEvents:UIControlEventTouchUpInside];
    [orderSelectView.btnSell addTarget:self action:@selector(postButtonRent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderSelectView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resavedRequsetRefeshing) name:@"RENT_ROOM_UPDATE" object:nil];
    // Do any additional setup after loading the view.
}

-(void)setupAdvertisement{
    NSArray *imageArray = @[@"house1",@"house2",@"house3"];
    _adView = [[AdScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150)];
    _adView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    _adView.imageNameArray = imageArray;
    _adView.PageControlShowStyle = UIPageControlShowStyleCenter;
    _adView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _adView.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_adView];
}


-(void)setupTableView{
    
    if (!self.playAdvertise) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, self.view.frame.size.height-260) style:UITableViewStylePlain];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BasicTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [self.view addSubview:self.tableView];
    
}

#pragma mark filter button
-(void)setupChooseList{
    if ([self.function isEqualToString:@"rent"] || [self.function isEqualToString:@"user"]) {
        self.filterArray1 = @[@"本小区",@"所有小区"];
        self.filterArray2 = @[@"所有",@"出售",@"出租"];
    }else  if ([self.function isEqualToString:@"activity"]){
        
        self.filterArray1 = @[@"本小区",@"所有小区"];
        self.filterArray2 = @[@"所有",@"聚会",@"运动",@"电影",@"讲座",@"公益",@"旅行",@"其他"];
        
    }else if ([self.function isEqualToString:@"secondHand"]){
        
        self.filterArray1 = @[@"本小区",@"所有小区"];
        self.filterArray2 = @[@"所有",@"转让",@"求购"];
    }

    if (!self.playAdvertise) {
        DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:50];
        menu.dataSource = self;
        menu.delegate = self;
        
        [self.view addSubview:menu];
    }else{
        DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 210) andHeight:50];
        menu.dataSource = self;
        menu.delegate   = self;
        [self.view addSubview:menu];
    }
    
}

#pragma mark - DOPDropDownMenuDataSource

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    switch (column) {
            
        case 0: return self.filterArray1.count;
            break;
        case 1: return self.filterArray2.count;
            break;
        default:
            return 1;
            break;
    }

}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    menu.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
    switch (indexPath.column) {
        case 0:
            return self.filterArray1[indexPath.row];
            break;
        case 1: return self.filterArray2[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    switch (indexPath.column) {
            
        case 0:
            switch (indexPath.row) {
                case 0:
                    self.communityAll = NO;
                    [self retrireveData];
                    break;
                case 1:
                    self.communityAll = YES;
                    [self retrireveData];
                    break;
                    
                default:
                    break;
            }
            
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    self.houseTypeArr = @[@"Sale",@"Rent"];
                    [self retrireveData];
                    break;
                case 1:
                    self.houseTypeArr = @[@"Sale"];
                    [self retrireveData];
                    break;
                case 2:
                    self.houseTypeArr = @[@"Rent"];
                    [self retrireveData];
                    break;
                    
                default:
                    break;
            }

            
            break;
        default:
            
            break;
    }

    
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
    if ([self.function isEqualToString:@"rent"]) {
        
        HouseDeal *houseDeal = [[HouseDeal alloc] initWithData:self.dataArray[indexPath.row]];
        NSString *detail = [NSString stringWithFormat:@"%@ %@室-%@厅-%@卫-%@m²",houseDeal.community[@"name"],houseDeal.room,houseDeal.sittingRoom,houseDeal.bathRoom,houseDeal.area];
        [cell configureRentCellImage:houseDeal.pictures[0] title:houseDeal.title detail:detail price:[NSString stringWithFormat:@"%@",houseDeal.price] priceUnit:@"元/月" date: [Util formattedDate:self.dataArray[indexPath.row][@"createTime"] type:3]];

    }else  if ([self.function isEqualToString:@"activity"]){
        
        Activity *activity = [[Activity alloc] initWithData:self.dataArray[indexPath.row]];
        [cell configureActivityCellImage:[NSURL URLWithString:activity.coverPhoto] title:activity.title detail:activity.activityTypeName address:activity.address date:activity.beginTime attends:[NSString stringWithFormat:@"%@",activity.applicantCount]];

    }else if ([self.function isEqualToString:@"secondHand"]){
        
        SecondHand *secondHand = [[SecondHand alloc] initWithData:self.dataArray[indexPath.row]];
        [cell configureRentCellImage:secondHand.pictures[0] title:secondHand.title detail:secondHand.content price:[NSString stringWithFormat:@"%@",secondHand.dealPrice]  priceUnit:[NSString stringWithFormat:@"原价%@元",secondHand.originalPrice] date:@"" ];
    }
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RentDetailViewController *rentVC = [[RentDetailViewController alloc] init];
    rentVC.detailData = self.dataArray[indexPath.row];
    rentVC.function = self.function;
    if ([self.function isEqualToString:@"rent"]) {
        [self pushVC:rentVC title:@"租售详情"];
    }else if([self.function isEqualToString:@"activity"]){
        [self pushVC:rentVC title:@"活动细节"];
    }else if([self.function isEqualToString:@"secondHand"]){
        [self pushVC:rentVC title:@"详情"];
    }
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark action

- (void)postButtonRent:(UIButton *)sender{
    orderSelectView.alpha = 0;
    RentPostViewController *postVC  = [[RentPostViewController alloc] init];
    if (sender.tag == 1) {
        //出租
        postVC.houseDealType = SummerHouseDealTypeRent;
    }else{
        //出售
        postVC.houseDealType = SummerHouseDealTypeSale;
    }
    postVC.step = 0;
    [self pushVC:postVC title:@"发布"];
    
}

-(void)post:(id)sender{
    NSString *userAuthType = [User getAuthenticationOwnerType];
    if ([userAuthType isEqualToString:@"未认证"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还未认证，是否现在去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1000;
        [alertView show];
    }else if ([userAuthType isEqualToString:@"户主"] || [userAuthType isEqualToString:@"业主"]){
        if ([self.function isEqualToString:@"rent"]) {//房屋租售／卖房
            orderSelectView.alpha = 1;
        }else if([self.function isEqualToString:@"activity"]){
            ActivityPostViewController *postVC  = [[ActivityPostViewController alloc] init];
            [self pushVC:postVC title:@"发布"];
        }else if([self.function isEqualToString:@"secondHand"]){
            SecondHandPostViewController *postVC  = [[SecondHandPostViewController alloc] init];
            [self pushVC:postVC title:@"发布"];
        }
    }else if ([userAuthType isEqualToString:@"认证失败"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"认证失败，是否再次去认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1002;
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"还在认证中" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1001;
        [alertView show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (orderSelectView.frame.size.height > 0) {
        orderSelectView.alpha = 0;
    }
}

#pragma mark networking

-(void)retrireveData{
    [self.view addSubview:self.loadingView];
    
    NSDictionary *parameters;
    NSString *url;
    if ([self.function isEqualToString:@"rent"]) {
        if (self.communityAll) {
            parameters = @{@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getAllHouseDeals;
        }else{
            parameters = @{@"communityId":[Util getCommunityID],@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getHouseDealsOfCommunity;
        }
        
        
    }else if([self.function isEqualToString:@"activity"]){
        parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
        url = getActivityOfCommunity;
        
    }else if([self.function isEqualToString:@"secondHand"]){
        parameters = @{@"communityId":[Util getCommunityID],@"fleaMarketType":@[@"Sale",@"Buy"],@"page":@1,@"row":[NSNumber numberWithInt:row]};
        url = getFleaMarketOfCommunity;
        
    }else if ([self.function isEqualToString:@"user"]) {
        parameters = @{@"token":[User getUserToken],@"houseDealTypes":@[@"Sale",@"Rent"],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
        url = getMyHouseDealsOfCommunity;
        
    }

    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
    } addition:^{
        [self.loadingView removeFromSuperview];
    }];
    
}

-(void)refreshHeader{

    NSDictionary *parameters;
    NSString *url;
    
    if ([self.function isEqualToString:@"rent"]) {
        if (self.communityAll) {
            parameters = @{@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getAllHouseDeals;
        }else{
            parameters = @{@"communityId":[Util getCommunityID],@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getHouseDealsOfCommunity;
        }

        
    }else if([self.function isEqualToString:@"activity"]){
        parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row]};
        url = getActivityOfCommunity;
        
    }else if([self.function isEqualToString:@"secondHand"]){
        parameters = @{@"communityId":[Util getCommunityID],@"fleaMarketType":@[@"Sale",@"Buy"],@"page":@1,@"row":[NSNumber numberWithInt:row]};
        url = getFleaMarketOfCommunity;
    }else if ([self.function isEqualToString:@"user"]) {
        parameters = @{@"token":[User getUserToken],@"houseDealTypes":@[@"Sale",@"Rent"],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
        url = getMyHouseDealsOfCommunity;
        
    }
    
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
        self.page = 1;
    }];
}

-(void)refreshFooter{
    NSDictionary *parameters;
    NSString *url;
    self.page ++;
    
    if ([self.function isEqualToString:@"rent"]) {
        if (self.communityAll) {
            parameters = @{@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getAllHouseDeals;
        }else{
            parameters = @{@"communityId":[Util getCommunityID],@"houseDealTypes":self.houseTypeArr,@"page":@1,@"row":[NSNumber numberWithInt:row]};
            url = getHouseDealsOfCommunity;
        }

        
    }else if([self.function isEqualToString:@"activity"]){
        parameters = @{@"communityId":[Util getCommunityID],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
        url = getActivityOfCommunity;
        
    }else if([self.function isEqualToString:@"secondHand"]){
        parameters = @{@"communityId":[Util getCommunityID],@"fleaMarketType":@[@"Sale",@"Buy"],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
        url = getFleaMarketOfCommunity;
        
    }else if ([self.function isEqualToString:@"user"]) {
        parameters = @{@"token":[User getUserToken],@"houseDealTypes":@[@"Sale",@"Rent"],@"page":@1,@"row":[NSNumber numberWithInt:row*self.page]};
        url = getMyHouseDealsOfCommunity;
        
    }
    
    [Networking retrieveData:url parameters:parameters success:^(id responseObject) {
        self.dataArray = responseObject[@"rows"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (self.dataArray.count < row*self.page) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

#pragma mark alertView
-(void)authentication{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"还未认证，是否现在认证？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 10;
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && (alertView.tag == 10 || alertView.tag == 1000)) {
        AccreditationPostViewController *postView = [[AccreditationPostViewController alloc] init];
        [self pushVC:postView title:@"发布认证"];
    }
    if (alertView.tag == 11) {
        RentPostViewController *postVC  = [[RentPostViewController alloc] init];
        postVC.step = 0;
        if (buttonIndex == 0) {
            postVC.houseDealType = SummerHouseDealTypeSale;
        }else{
            postVC.houseDealType = SummerHouseDealTypeRent;
        }
        [self pushVC:postVC title:@"发布"];
    }
    
}

- (void)resavedRequsetRefeshing{
    [self refreshHeader];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
















