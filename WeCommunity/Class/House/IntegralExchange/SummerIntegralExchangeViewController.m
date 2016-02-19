//
//  SummerIntegralExchangeViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//  兑换

#import "SummerIntegralExchangeViewController.h"
#import "SummerIntergralDetailViewController.h"
#import "SummerJinSubmiteViewController.h"
#import "SummerScoreSegmentControl.h"
#import "SummerScoreTableViewCell.h"
#import "SummerNoInfoError.h"
#import "MBProgressHUD.h"

@interface SummerIntegralExchangeViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSInteger pageNumers;
    UILabel *scoreLab;
    MBProgressHUD *hudProgress;
}
@property (nonatomic ,strong)SummerScoreSegmentControl *mSegmentControl;
@property (nonatomic ,strong) SummerNoInfoError *imgViewError;
@property (nonatomic ,strong)UITableView *mTableView;
@property (nonatomic ,strong)NSMutableArray *dataArrary;
@property (nonatomic ,strong)UIButton *btnSubmite;
@end

@implementation SummerIntegralExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
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
    
    _imgViewError = [[SummerNoInfoError alloc] initWithFrame:CGRectMake(0, 120, SCREENSIZE.width, SCREENSIZE.height - 120)];
    _imgViewError.addNoErrorMore.hidden = YES;
    _imgViewError.labNoError.text = @"暂无兑换信息";
    _imgViewError.hidden = YES;
    [self.view addSubview:_imgViewError];
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(10, SCREENSIZE.height - 50, SCREENSIZE.width - 20, 40);
    bgLayer.cornerRadius = 5;
    bgLayer.masksToBounds = YES;
    bgLayer.backgroundColor = THEMECOLOR.CGColor;
    [self.view.layer addSublayer:bgLayer];
    
    scoreLab = [[UILabel alloc] initWithFrame:CGRectMake(15, SCREENSIZE.height - 50, 100, 40)];
    scoreLab.textColor = [UIColor whiteColor];
    scoreLab.font = [UIFont systemFontOfSize:14];
    User *userModel = [User shareUserDefult];
    
    [self.view addSubview:scoreLab];
    _btnSubmite = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSubmite.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btnSubmite addTarget:self action:@selector(submiteInformation) forControlEvents:UIControlEventTouchUpInside];
    _btnSubmite.frame = CGRectMake(SCREENSIZE.width - 160, SCREENSIZE.height - 50, 150, 40);
    [_btnSubmite setTitle:@"提交资料获得50积分" forState:UIControlStateNormal];
    [self.view addSubview:_btnSubmite];
    if (userModel.userJinDic.jinPoint.integerValue > 0) {
        _btnSubmite.hidden = YES;
    }
    hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    hudProgress.labelText = @"加载网络中";
    [hudProgress show:YES];
    
    [self refreshingHeaderView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    User *userModel = [User shareUserDefult];
    if (userModel.userJinDic.jinPoint.integerValue < 1) {
        scoreLab.text = @"积分：0";
    }else{
        scoreLab.text = [NSString stringWithFormat:@"积分：%@",userModel.userJinDic.jinPoint];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
    NSDictionary *dicTemp = _dataArrary[indexPath.row];
    [cell.cellImgView sd_setImageWithURL:[NSURL URLWithString:dicTemp[@"picture"]] placeholderImage:[UIImage imageNamed:@"loadingLogo"]];
    
    cell.cellExchange.backgroundColor = THEMECOLOR;
    if (_mSegmentControl.currentSelectIndex == 0) {
        cell.cellTitleLab.text = dicTemp[@"name"];
        cell.cellScoreLab.text = [NSString stringWithFormat:@"%@积分",[dicTemp[@"point"] stringValue]];
        cell.cellExchange.text = @"兑换";
        if (![dicTemp[@"remainNumber"] isEqual:[NSNull null]]) {
            if ([dicTemp[@"remainNumber"] integerValue] == 0) {
                cell.cellExchange.text = @"兑换完了";
                [cell.cellExchange setBackgroundColor:[UIColor colorWithWhite:0.698 alpha:1.000]];
            }
        }
        
    }else{
        cell.cellTitleLab.text = dicTemp[@"prize"][@"name"];
        cell.cellScoreLab.text = [NSString stringWithFormat:@"%@积分",[dicTemp[@"point"] stringValue]];
        cell.cellExchange.text = @"兑换成功";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mSegmentControl.currentSelectIndex == 0) {
        SummerIntergralDetailViewController *intergralDetailVC = [[SummerIntergralDetailViewController alloc] init];
        intergralDetailVC.intergralType = DetailGoods;
        intergralDetailVC.detailGoods = _dataArrary[indexPath.row];
        [self.navigationController pushViewController:intergralDetailVC animated:YES];
    }
}

- (void)scoreInformation{
    
}


- (void)refreshingHeaderView{
    NSString *strUrl;
    NSDictionary *parama;
    pageNumers = 1;
    if (_mSegmentControl.currentSelectIndex == 0) {
        strUrl =  JIN_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers]};
    }else{
        strUrl =  JIN_MY_EXPORY;
        parama = @{@"row": @30,@"page":[NSNumber numberWithInteger:pageNumers],@"token":[User getUserToken]};
    }
    __weak typeof(self)weakSelf = self;
    [Networking retrieveData:strUrl parameters:parama success:^(id responseObject) {
        hudProgress.hidden = YES;
        [weakSelf.mTableView.mj_header endRefreshing];
        _dataArrary = responseObject[@"rows"];
        if (_dataArrary.count < 30) {
            [weakSelf.mTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (_dataArrary.count) {
            _imgViewError.hidden = YES;
        }else{
            _imgViewError.hidden = NO;
        }
        [weakSelf.mTableView reloadData];
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
    hudProgress.hidden = NO;
    [self refreshingHeaderView];
    NSLog(@"--->%i",index);
}

- (void)submiteInformation{
    __weak typeof(self)weakSelf = self;
    SummerJinSubmiteViewController *submiteVC = [[SummerJinSubmiteViewController alloc] init];
    submiteVC.submitType = SummerJinSubmiteViewTypeSub;
    submiteVC.submiteSeccess = ^{
        User *userModel = [User shareUserDefult];
        if (userModel.userJinDic.jinPoint.integerValue > 0) {
            weakSelf.btnSubmite.hidden = YES;
            scoreLab.text = [NSString stringWithFormat:@"积分：%@",userModel.userJinDic.jinPoint];
        }
    };
    [self.navigationController pushViewController:submiteVC animated:YES];
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
