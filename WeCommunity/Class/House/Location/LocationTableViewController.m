//
//  LocationTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "LocationTableViewController.h"
#import "SummerSelectCommunityViewController.h"

@interface LocationTableViewController ()<UIAlertViewDelegate>
{
    NSInteger pageNumber;
    NSString *strCommunityName;
    UIButton *btnClearItem;
}

@property(nonatomic, strong)NSMutableArray *dataArrary;
@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    __weak typeof(self)weakSelf = self;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清除记录" style:UIBarButtonItemStylePlain target:self action:@selector(clearCommunity)];
    btnClearItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClearItem setTitle:@"清除记录" forState:UIControlStateNormal];
    [btnClearItem setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    btnClearItem.frame = CGRectMake(0, 0, 80, 40);
    [btnClearItem addTarget:self action:@selector(clearCommunity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnClearItem];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title = @"切换小区";
    strCommunityName = [Util getCommunityName];
    self.view.backgroundColor = [UIColor whiteColor];
    self.locationArr = @[@"玉兰香苑",@"幸福小区",@"光明小区"];
    self.locationID = @[@"1",@"813",@"814"];
    _dataArrary = [FileManager getData:@"historyCommynity"][@"communityNames"];
    if (!_dataArrary || _dataArrary.count == 1) {
        btnClearItem.hidden = YES;
    }
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - 64 - 60) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.mTableView registerClass:[BasicTableViewCell class ] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_mTableView];
    

    self.mTableView.tableFooterView = [[UIView alloc]init];
    
    UIButton *btnSelectCommunity = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSelectCommunity.backgroundColor = [UIColor orangeColor];
    [btnSelectCommunity setTitle:@"更换小区" forState:UIControlStateNormal];
    [btnSelectCommunity addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectCommunity];
    
    [btnSelectCommunity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottomMargin.equalTo(weakSelf.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(40);
    }];
}

- (void)clearCommunity{
    UIAlertView *alertVeiw = [[UIAlertView alloc] initWithTitle:@"清除记录" message:@"是否清除记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertVeiw show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        btnClearItem.hidden = YES;
        NSDictionary *dicCommunity = @{@"communityName":[Util getCommunityName],
                                       @"communityID":[Util getCommunityID]
                                       };
        [FileManager saveDataToFile:@{@"communityNames": @[dicCommunity]} filePath:@"historyCommynity"];
        _dataArrary = [FileManager getData:@"historyCommynity"][@"communityNames"];
        [_mTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * tempDic = self.dataArrary[indexPath.row];
    if ([tempDic[@"communityName"] isEqualToString:strCommunityName]) {
        cell.textLabel.textColor = THEMECOLOR;
    }
    cell.textLabel.text = tempDic[@"communityName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * tempDic = self.dataArrary[indexPath.row];
    if (self.dataArrary.count == 1 || [tempDic[@"communityName"] isEqualToString:strCommunityName]) {
        return;
    }
    if (_locationStyle == LocationTableViewControllerStyleDefult) {
        NSDictionary *community = @{
                                    @"communityName":tempDic[@"communityName"],
                                    @"communityID":tempDic[@"communityID"]
                                    };
        [FileManager saveDataToFile:community filePath:@"Community"];
        [User SaveAuthentication];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if(_locationStyle == LocationStyleSelectCommunityNameAndID){
        NSDictionary *community = @{
                                    @"communityName":tempDic[@"communityName"],
                                    @"communityID":tempDic[@"communityID"]
                                    };
        [self.delegate selectedFinishedCommunityNameAndID:community];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)selectCommunity{
    __weak typeof(self)weakSelf = self;
    SummerSelectCommunityViewController *selectCommunityVC = [[SummerSelectCommunityViewController alloc] init];
    selectCommunityVC.selectCityType = _locationStyle;
    selectCommunityVC.backViewBlock = ^(NSDictionary *tempDic){
        NSDictionary *community = @{
                                    @"communityName":tempDic[@"communityName"],
                                    @"communityID":tempDic[@"communityID"]
                                    };
        [FileManager saveDataToFile:community filePath:@"Community"];
        [User SaveAuthentication];
        
        if (weakSelf.locationStyle == LocationTableViewControllerStyleDefult) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.delegate selectedFinishedCommunityNameAndID:community];
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.navigationController pushViewController:selectCommunityVC animated:YES];
}

@end
