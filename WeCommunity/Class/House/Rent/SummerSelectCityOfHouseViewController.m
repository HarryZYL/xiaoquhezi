//
//  SummerSelectCityOfHouseViewController.m
//  WeCommunity
//
//  Created by madarax on 15/10/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerSelectCityOfHouseViewController.h"

@implementation SummerSelectCityOfHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择小区";
    
    SummerSelectCityView *cityView = [[SummerSelectCityView alloc] initWithFrame:self.view.frame];
    cityView.delegate = self;
    [self.view addSubview:cityView];
}

#pragma mark - SummerSelectCityView Delegate

- (void)selectCityCommnityWithData:(NSDictionary *)commnityDic{
    
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

















