//
//  SummerIntegralExchangeViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//  兑换

#import "SummerIntegralExchangeViewController.h"
#import "SummerIntergralDetailViewController.h"
#import "SummerScoreSegmentControl.h"
#import "SummerScoreTableViewCell.h"

@interface SummerIntegralExchangeViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSInteger pageNumers;
}
@property (nonatomic ,strong)SummerScoreSegmentControl *mSegmentControl;
@property (nonatomic ,strong)UITableView *mTableView;
@property (nonatomic ,strong)NSMutableArray *dataArrary;
@end

@implementation SummerIntegralExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
//    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(scoreInformation)];
//    self.navigationItem.rightBarButtonItem = itemRight;
    _dataArrary = [[NSMutableArray alloc] initWithCapacity:0];
    __weak typeof(self)weakSelf = self;
    _mSegmentControl = [[SummerScoreSegmentControl alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, 45)];
    _mSegmentControl.items = @[@"所有兑换",@"我的兑换"];
    _mSegmentControl.currentSelectIndex = 0;
    _mSegmentControl.tapIndexTag = ^(NSInteger index){
        [weakSelf segmentControlDidSelectIndex:index];
    };
    [self.view addSubview:_mSegmentControl];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, SCREENSIZE.width, SCREENSIZE.height - 120) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight = 105;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshingHeaderView)];
    _mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshingFooterView)];
    
    _mTableView.backgroundColor = self.view.backgroundColor;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    [self.view addSubview:_mTableView];
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(10, SCREENSIZE.height - 50, SCREENSIZE.width - 20, 40);
    bgLayer.cornerRadius = 5;
    bgLayer.masksToBounds = YES;
    bgLayer.backgroundColor = THEMECOLOR.CGColor;
    [self.view.layer addSublayer:bgLayer];
    
    UILabel *scoreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, SCREENSIZE.height - 50, 100, 40)];
    scoreLab.textColor = [UIColor whiteColor];
    scoreLab.font = [UIFont systemFontOfSize:14];
    scoreLab.text = @"积分：200";
    [self.view addSubview:scoreLab];
    [self refreshingHeaderView];
//    UILabel *btnScore = [UILabel new];
//    btnScore.backgroundColor = THEMECOLOR;
//    btnScore.layer.cornerRadius = 5;
//    btnScore.layer.masksToBounds = YES;
//    btnScore.text = @"积分40000";
//    btnScore.frame = CGRectMake(10, SCREENSIZE.height - 30, SCREENSIZE.width - 20, 20);
//    [self.view addSubview:btnScore];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    if (_mSegmentControl.currentSelectIndex == 0) {
        
    }else{
        
    }
    NSLog(@"--->%d",_mSegmentControl.currentSelectIndex);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerIntergralDetailViewController *intergralDetailVC = [[SummerIntergralDetailViewController alloc] init];
    
    [self.navigationController pushViewController:intergralDetailVC animated:YES];
}

- (void)scoreInformation{
    
}


- (void)refreshingHeaderView{
    NSString *strUrl;
    NSDictionary *parama;
    pageNumers = 0;
    if (_mSegmentControl.currentSelectIndex == 0) {
        strUrl =  JIN_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers]};
    }else{
        strUrl =  JIN_MY_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers],@"token":[User getUserToken]};
    }
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:strUrl parameters:parama success:^(id responseObject) {
        [weakSelf.mTableView.mj_header endRefreshing];
        if (weakSelf.dataArrary.count < 30) {
            [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (void)refreshingFooterView{
    NSString *strUrl;
    NSDictionary *parama;
    pageNumers ++;
    if (_mSegmentControl.currentSelectIndex == 0) {
        strUrl =  JIN_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers]};
    }else{
        strUrl =  JIN_MY_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers]};
    }
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:strUrl parameters:parama success:^(id responseObject) {
        [weakSelf.mTableView.mj_footer endRefreshing];
        if (weakSelf.dataArrary.count < pageNumers * 30) {
            [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
}

- (void)segmentControlDidSelectIndex:(NSInteger)index{
    [self refreshingHeaderView];
    NSLog(@"--->%i",index);
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
