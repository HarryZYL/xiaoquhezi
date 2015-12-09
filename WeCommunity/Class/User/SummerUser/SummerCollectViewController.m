//
//  SummerCollectViewController.m
//  WeCommunity
//
//  Created by madarax on 15/12/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerCollectViewController.h"
#import "SummerCollectionTableViewCell.h"

@interface SummerCollectViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mTableView;
@end

@implementation SummerCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.000];
    _mTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_mTableView registerNib:[UINib nibWithNibName:@"SummerCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTableView.rowHeight = 92;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_mTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem" forIndexPath:indexPath];
//    cell.cellImgView.image = [UIImage imageNamed:@"logo"];
//    cell.cellTitleLab.text =
    return cell;
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
