//
//  SummerSelectCityView.m
//  WeCommunity
//
//  Created by madarax on 15/10/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectCityView.h"

@interface SummerSelectCityView()<UITableViewDataSource ,UITableViewDelegate>
{
    NSMutableArray *cityArrary;
    NSMutableArray *commnityArrary;
}
@property (nonatomic ,strong) UITableView *cityTableView;
@property (nonatomic ,strong) UITableView *commnunityTableView;

@end

@implementation SummerSelectCityView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cityTableView];
        [self addSubview:self.commnunityTableView];
        [self initOfData];
    }
    return self;
}

- (UITableView *)cityTableView{
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 90, self.frame.size.height) style:UITableViewStylePlain];
    [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _cityTableView.tableFooterView = [[UIView alloc] init];
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    return _cityTableView;
}

- (UITableView *)commnunityTableView{
    _commnunityTableView = [[UITableView alloc] initWithFrame:CGRectMake(90, 64, self.frame.size.width - 90, self.frame.size.height - 64) style:UITableViewStylePlain];
    [_commnunityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _commnunityTableView.tableFooterView = [[UIView alloc] init];
    _commnunityTableView.delegate = self;
    _commnunityTableView.dataSource = self;
    return _commnunityTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _cityTableView) {
        return cityArrary.count;
    }
    return commnityArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (tableView == _cityTableView) {
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        NSDictionary *dicTemp = cityArrary[indexPath.row];
        cell.textLabel.text = dicTemp[@"name"];
    }else{
        cell.textLabel.text = @"456";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _cityTableView) {
        [commnityArrary removeAllObjects];
        NSDictionary *dic = cityArrary[indexPath.row];
        [self getCommnunityDataListWithCityName:dic[@"name"]];
    }else{
        
    }
}

- (void)initOfData{
    if ([CLLocationManager locationServicesEnabled]) {
        
    }else{
        [Networking retrieveData:get_ONLY_CITY parameters:nil success:^(id responseObject) {
            cityArrary = responseObject;
            [_cityTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
}

- (void)getCommnunityDataListWithCityName:(NSString *)cityName{
//    NSDictionary *parama = @{@"name": @"",
//                             @"cityName":cityName,
//                             @"baiduPosLong":@"",
//                             @"baiduPosLati":@"",
//                             @"page":@(1),
//                             @"row":@(30)};
    
    NSDictionary *parama = @{@"cityName":cityName,
                             @"page":@"1",
                             @"row":@"30"};
    
    [Networking retrieveData:getCommnityOfCity parameters:parama success:^(id responseObject) {
        commnityArrary = responseObject;
        [_commnunityTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
