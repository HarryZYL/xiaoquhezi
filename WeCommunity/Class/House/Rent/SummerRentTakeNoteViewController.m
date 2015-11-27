//
//  SummerRentTakeNoteViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRentTakeNoteViewController.h"
#import "SummerRentTakeNoteTableViewCell.h"
#import "UIViewController+HUD.h"

@interface SummerRentTakeNoteViewController ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mTableView;
@property (nonatomic ,strong)NSMutableArray *arraryData;
@end

@implementation SummerRentTakeNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约记录";
    [self mTableView];
    [self getBookingList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arraryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SummerRentTakeNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SummerRentTakeNoteTableViewCell" owner:self options:nil].firstObject;
        [cell.cellBtnPhone addTarget:self action:@selector(cellBtnPhoneNow:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *dicTemp = _arraryData[indexPath.row];
    cell.cellTimeLab.text = [NSString stringWithFormat:@"预约时间：%@",[Util formattedDate:dicTemp[@"time"] type:1]];
    cell.cellNameLab.text = [NSString stringWithFormat:@"姓       名：%@",dicTemp[@"name"]];
    cell.cellPhoneNumber.text = [NSString stringWithFormat:@"联系方式：%@",dicTemp[@"phone"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--->%@",_arraryData[indexPath.row]);
}

- (void)cellBtnPhoneNow:(UIButton *)sender{
    NSIndexPath *index = [_mTableView indexPathForCell:(UITableViewCell *)[sender superview].superview];

    NSDictionary *dicTemp = _arraryData[index.row];
    NSString *strPhone = [NSString stringWithFormat:@"telprompt://%@",[dicTemp[@"phone"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strPhone]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhone]];
    }else{
        [self showHint:@"当前设备不支持打电话"];
    }
}

//查询预约看房记录
-(void)getBookingList{
    __weak typeof(self)weakSelf = self;
    NSDictionary *parameters = @{
                                 @"token":[User getUserToken],
                                 @"id":_strRentID,
                                 @"page":@1,
                                 @"row":@10
                                 };
    [Networking retrieveData:getBooking parameters:parameters success:^(id responseObject) {
        if ([responseObject[@"rows"] count] < 1) {
            [self showHint:@"暂无预约"];
        }else{
            weakSelf.arraryData = responseObject[@"rows"];
            [weakSelf.mTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)mTableView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height - 64) style:UITableViewStylePlain];
//    [_mTableView registerNib:[UINib nibWithNibName:@"SummerRentTakeNoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellItem"];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.rowHeight = 130;
    _mTableView.tableFooterView = [[UIView alloc] init];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:_mTableView];
    return _mTableView;
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
