//
//  SummerPriceListViewController.m
//  WeCommunity
//
//  Created by madarax on 15/10/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerPriceListViewController.h"
#import "SummerPriceListTableViewCell.h"
#import "SummerPriceHeaderView.h"

@interface SummerPriceListViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSInteger pageNumber;
    
}
@property (nonatomic ,strong) UITableView *mTaleView;
@property (nonatomic ,strong) NSMutableArray *dataArrary;

@end

@implementation SummerPriceListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"价格单";
    pageNumber = 1;
    self.dataArrary = [[NSMutableArray alloc] init];
    _mTaleView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 10) style:UITableViewStylePlain];
    [_mTaleView registerNib:[UINib nibWithNibName:@"SummerPriceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _mTaleView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
//    [_mTaleView registerNib:[UINib nibWithNibName:@"SummerPriceHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerview"];
    _mTaleView.delegate = self;
    _mTaleView.dataSource = self;
    _mTaleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mTaleView];
    
    [self receveData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SummerPriceHeaderView *headerView = (SummerPriceHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerview"];
    if (!headerView) {
        headerView = [[NSBundle mainBundle] loadNibNamed:@"SummerPriceHeaderView" owner:self options:nil].firstObject;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerPriceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row%2 == 1) {
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    }
    NSDictionary *dic = self.dataArrary[indexPath.row];
    cell.cellPriceNO.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    cell.cellPriceProject.text = dic[@"name"];
    cell.cellPriceUnit.text = dic[@"price"];
    
    return cell;
}

- (void)receveData{
    __weak typeof(self)WeakVC = self;
    NSDictionary *parameter = @{@"communityId": [Util getCommunityID],
                                @"page":[NSNumber numberWithInteger:pageNumber],
                                @"row":@(20)};
    [Networking retrieveData:get_COMMNITY_PRICE parameters:parameter success:^(id responseObject) {
        _dataArrary = responseObject[@"rows"];
        [WeakVC.mTaleView reloadData];
    }];
}

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

@end
