//
//  SummerIntegralExchangeViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerIntegralExchangeViewController.h"
#import "SummerIntergralDetailViewController.h"
#import "SummerScoreTableViewCell.h"

@interface SummerIntegralExchangeViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong)UISegmentedControl *mSegmentControl;
@property (nonatomic ,strong)UITableView *mTableView;
@end

@implementation SummerIntegralExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(scoreInformation)];
    self.navigationItem.rightBarButtonItem = itemRight;
    
    __weak typeof(self)weakSelf = self;
    _mSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"所有兑换",@"我的兑换"]];
    _mSegmentControl.selectedSegmentIndex = 0;
    _mSegmentControl.tintColor = THEMECOLOR;
    [self.view addSubview:_mSegmentControl];
    [_mSegmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(0);
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.right.equalTo(weakSelf.view.mas_right).offset(0);
        make.height.mas_equalTo(34);
    }];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREENSIZE.width, SCREENSIZE.height - 100 - 40) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight = 84;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    [self.view addSubview:_mTableView];
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(0, SCREENSIZE.height - 30, SCREENSIZE.width, 30);
    bgLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:bgLayer];
    
    UILabel *btnScore = [UILabel new];
    btnScore.backgroundColor = THEMECOLOR;
    btnScore.layer.cornerRadius = 5;
    btnScore.layer.masksToBounds = YES;
    btnScore.text = @"积分40000";
    btnScore.frame = CGRectMake(10, SCREENSIZE.height - 30, SCREENSIZE.width - 20, 20);
    [self.view addSubview:btnScore];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerIntergralDetailViewController *intergralDetailVC = [[SummerIntergralDetailViewController alloc] init];
    
    [self.navigationController pushViewController:intergralDetailVC animated:YES];
}

- (void)scoreInformation{
    
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
