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
    NSInteger *selectIndex;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArrary;

@end

@implementation SummerMemberManagerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员管理";
    selectIndex = 1000;
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
    titleNumber.text = [NSString stringWithFormat:@"玉兰香苑 一号楼 20%d",section];
    return headerView;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 52;
    }else{
    return 72;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (cellSpread && section == selectIndex) {
        return 3;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SummerMemberManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell confirmMemberManagerCellWithData:self.dataArrary[indexPath.row] withIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"移出";
}
// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && indexPath != 0) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
