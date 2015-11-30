//
//  LocationTableViewController.m
//  WeCommunity
//
//  Created by Harry on 8/30/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "LocationTableViewController.h"
#import "SummerSelectCommunityViewController.h"

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
    __weak typeof(self)weakSelf = self;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"切换小区";
    self.view.backgroundColor = [UIColor whiteColor];
    self.locationArr = @[@"玉兰香苑",@"幸福小区",@"光明小区"];
    self.locationID = @[@"1",@"813",@"814"];
    _dataArrary = [[NSMutableArray alloc] init];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height - 64 - 60) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.mTableView registerClass:[BasicTableViewCell class ] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_mTableView];
    

    self.mTableView.tableFooterView = [[UIView alloc]init];
//    [self refreshHeader];
    
    
    UIButton *btnSelectCommunity = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSelectCommunity.backgroundColor = [UIColor orangeColor];
    [btnSelectCommunity setTitle:@"选择小区" forState:UIControlStateNormal];
    [btnSelectCommunity addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectCommunity];
    
    [btnSelectCommunity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottomMargin.equalTo(weakSelf.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(40);
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
    return self.locationArr.count;
//    return self.dataArrary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.locationArr[indexPath.row];
//    NSDictionary * tempDic = self.dataArrary[indexPath.row];
//    cell.textLabel.text = tempDic[@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary * tempDic = self.dataArrary[indexPath.row];
//    NSDictionary *community = @{
//                                @"communityName":tempDic[@"name"],
//                                @"communityID":tempDic[@"id"]
//                                };
    if (_locationStyle == LocationTableViewControllerStyleDefult) {
        NSDictionary *community = @{
                                    @"communityName":self.locationArr[indexPath.row],
                                    @"communityID":self.locationID[indexPath.row]
                                    };
        [FileManager saveDataToFile:community filePath:@"Community"];
        [User SaveAuthentication];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else if(_locationStyle == LocationStyleSelectCommunityNameAndID){
        NSDictionary *community = @{
                                    @"communityName":self.locationArr[indexPath.row],
                                    @"communityID":self.locationID[indexPath.row]
                                    };
        [self.delegate selectedFinishedCommunityNameAndID:community];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)selectCommunity{
    SummerSelectCommunityViewController *selectCommunityVC = [[SummerSelectCommunityViewController alloc] init];
    
    [self.navigationController pushViewController:selectCommunityVC animated:YES];
}

@end
