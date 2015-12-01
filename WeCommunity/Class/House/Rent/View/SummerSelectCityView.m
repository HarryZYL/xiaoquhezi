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

@end

@implementation SummerSelectCityView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cityTableView];
        [self initOfData];
    }
    return self;
}

- (UITableView *)cityTableView{
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, self.frame.size.height) style:UITableViewStylePlain];
    [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _cityTableView.tableFooterView = [[UIView alloc] init];
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    return _cityTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _cityTableView) {
        return cityArrary.count;
    }
    return commnityArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    NSDictionary *dicTemp = cityArrary[indexPath.row];
    cell.textLabel.text = dicTemp[@"name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [commnityArrary removeAllObjects];
    NSDictionary *dic = cityArrary[indexPath.row];
    [self getCommnunityDataListWithCityName:dic[@"name"]];
    
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
