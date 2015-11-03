//
//  SummerNoticeCenterDetailViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/3.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeCenterDetailViewController.h"

@interface SummerNoticeCenterDetailViewController ()
@property (nonatomic ,strong) NSMutableArray *arraryData;
@end

@implementation SummerNoticeCenterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getReceveData];
}

- (void)getReceveData{
    [Networking retrieveData:getNoticesOfCommunity parameters:@{@"id": self.strNoticeID} success:^(id responseObject) {
        NSLog(@"--->%@",responseObject);
    }];
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
