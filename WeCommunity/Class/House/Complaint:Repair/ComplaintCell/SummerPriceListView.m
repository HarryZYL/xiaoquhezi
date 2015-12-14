//
//  SummerPriceListView.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//
#import "SummerPriceListTableViewCell.h"
#import "SummerPriceHeaderView.h"
#import "SummerPriceListView.h"
@interface SummerPriceListView()<UITableViewDataSource ,UITableViewDelegate>
{
    NSInteger pageNumber;
    
}
@property (nonatomic ,strong) UITableView *mTaleView;
@property (nonatomic ,strong) NSMutableArray *dataArrary;

@end

@implementation SummerPriceListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        pageNumber = 1;
        self.dataArrary = [[NSMutableArray alloc] init];
        UILabel *nameLab = [UILabel new];
        nameLab.text = @"价格单";
        nameLab.backgroundColor = [UIColor whiteColor];
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.frame = CGRectMake(10, 20, frame.size.width - 20, 45);
        [self addSubview:nameLab];
        
        _mTaleView = [[UITableView alloc] initWithFrame:CGRectMake(10, 65,frame.size.width - 20,frame.size.height - 65 - 64) style:UITableViewStylePlain];
        [_mTaleView registerNib:[UINib nibWithNibName:@"SummerPriceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _mTaleView.delegate = self;
        _mTaleView.dataSource = self;
        _mTaleView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mTaleView.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0);
        _mTaleView.separatorColor = [UIColor colorWithWhite:0.851 alpha:1.000];
        _mTaleView.tableFooterView = [UIView new];
        [self addSubview:_mTaleView];

        UIButton *btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUp.frame = CGRectMake(10, frame.size.height - 64, frame.size.width - 20, 40);
        [btnUp setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
        [btnUp addTarget:self action:@selector(btnUpOffView) forControlEvents:UIControlEventTouchUpInside];
        [btnUp setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:btnUp];
        
        [self receveData];
    }
    
    return self;
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
        cell.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

- (void)btnUpOffView{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
