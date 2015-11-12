//
//  SummerMemberManagerTableViewController.m
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerMemberManagerTableViewController.h"
#import "SummerMemberManagerTableViewCell.h"

@interface SummerMemberManagerTableViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    BOOL cellSpread;
    NSInteger selectIndex;/**<判断点击Section*/
    NSIndexPath *cellDidSelect;/**<要删除的cell*/
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArrary;

@end

@implementation SummerMemberManagerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员管理";
    selectIndex = 0;
    cellSpread = YES;
    
    _dataArrary = [[NSMutableArray alloc] init];
    // cellDidSelect = [[NSIndexPath alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 9, self.view.frame.size.width, self.view.frame.size.height - 9) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.view.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SummerMemberManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self receivePersonalsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *cellTitleIndentify = @"membermanagercell";
    UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellTitleIndentify];
    if (!headerView) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 41)];
        headerView.backgroundColor = [UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1];
        UILabel *roomNumber = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.view.frame.size.width, 40)];
        roomNumber.textColor = [UIColor whiteColor];
        roomNumber.tag = 100;
        [headerView addSubview:roomNumber];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height - 1, headerView.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:lineView];
        
        UIButton *btnSpread = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSpread.frame = headerView.frame;
        btnSpread.tag = section + 1;
        [btnSpread addTarget:self action:@selector(cellSpreadOrContract:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btnSpread];
    }
    UILabel *titleNumber = (UILabel *)[headerView viewWithTag:100];
    NSDictionary *houseDic = _dataArrary[section][@"house"];
    NSString *communityName = [NSString stringWithFormat:@"%@%@室",houseDic[@"communityName"],[houseDic[@"parentNames"] componentsJoinedByString:@""]];
    titleNumber.text = communityName;
    return headerView;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arraryAuth = _dataArrary[indexPath.section][@"authcs"];
    NSDictionary *dicTemp = arraryAuth[indexPath.row];
    if ([dicTemp[@"ownerType"] isEqualToString:@"Owner"]) {
        return 52;
    }else{
    return 72;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArrary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (cellSpread && section == selectIndex) {
        NSArray *arraryAuth = _dataArrary[section][@"authcs"];
        return [arraryAuth count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SummerMemberManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *arraryAuth = _dataArrary[indexPath.section][@"authcs"];
    [cell confirmMemberManagerCellWithData:arraryAuth[indexPath.row] withIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    NSArray *arraryAuth = _dataArrary[indexPath.section][@"authcs"];
    NSDictionary *dicTemp = arraryAuth[indexPath.row];
    if ([dicTemp[@"ownerType"] isEqualToString:@"Owner"]){
        return NO;
    }
    return YES;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"移出";
}
// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arraryAuth = _dataArrary[indexPath.section][@"authcs"];
    NSDictionary *dicTemp = arraryAuth[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete && ![dicTemp[@"ownerType"] isEqualToString:@"Owner"]) {
        // Delete the row from the data source
        cellDidSelect = indexPath;
        SummerMemberAlertView *alertView = [[NSBundle mainBundle] loadNibNamed:@"SummerMemberAlertView" owner:self options:nil].firstObject;
        alertView.frame = [[UIScreen mainScreen] bounds];
        alertView.delegate = self;
        [self.view.window addSubview:alertView];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - SummerMemberAlertViewDelegate

- (void)didSelectIndexWithInformation:(NSInteger)index{
    NSLog(@"--%d-->%d",cellDidSelect.section,cellDidSelect.row);
    if (index == 4) {
        NSArray *arraryAuth = _dataArrary[cellDidSelect.section][@"authcs"];
        NSDictionary *dicTemp = arraryAuth[cellDidSelect.row];
        [Networking retrieveData:getMyAuthentictionDelete parameters:@{@"token": [User getUserToken],@"id":dicTemp[@"id"]}];
        [self receivePersonalsData];
    }
    
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)receivePersonalsData{
    [_dataArrary removeAllObjects];
    [Networking retrieveData:get_HOURSE_PEOPLE_NUMBER parameters:@{@"token": [User getUserToken]} success:^(id responseObject) {
        [_dataArrary addObjectsFromArray:responseObject];
        [_tableView reloadData];
    }];
}

- (void)cellSpreadOrContract:(UIButton *)sender{
    if (sender.tag - 1 == selectIndex && cellSpread) {
        cellSpread = NO;
    }else{
        cellSpread = YES;
    }
    
    selectIndex = sender.tag - 1;
    
    [self.tableView reloadData];
}

@end
