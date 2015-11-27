//
//  SummerRePostMyRentViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/21.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRePostMyRentViewController.h"

@interface SummerRePostMyRentViewController ()


@end

@implementation SummerRePostMyRentViewController

- (instancetype)init{
    if (self == [super init]) {
        UIBarButtonItem *pushItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadData)];
        self.navigationItem.rightBarButtonItem = pushItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    _alertViewModel = [[SummerRentAlertView alloc] initWithFrame:self.view.frame];
    _alertViewModel.houseDeal = self.houseDeal;
    [self.view addSubview:_alertViewModel];
    [_alertViewModel setContentTitle];
}

- (void)upLoadData{
    
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
