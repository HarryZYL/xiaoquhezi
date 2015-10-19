//
//  BillViewController.m
//  WeCommunity
//
//  Created by Harry on 7/26/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BillViewController.h"

@interface BillViewController ()

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"账单";
    UIBarButtonItem *changeLocation = [[UIBarButtonItem alloc] init];
    changeLocation.title = @"切换";
    self.navigationItem.rightBarButtonItem = changeLocation;
    [self setupAppearance];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAppearance{
    self.functionView1 = [[FunctionView alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 200)];
    [self.functionView1 setupFunctionViewFirst:@"propertyFee" title1:@"物业费" Second:@"waterFee" title2:@"水费" Third:@"elecFee" title3:@"电费" Fourth:@"gasFee" title4:@"燃气费" Fifth:@"board" title5:@"宽带" Sixth:@"phoneCharge" title6:@"手机充值"];
    [self.functionView1.firstItem.functionButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionView1];
    
    self.functionView2 = [[FunctionView alloc] initWithFrame:CGRectMake(30, 300, self.view.frame.size.width-60, 200)];
    [self.functionView2 setupFunctionViewFirst:@"visa" title1:@"信用卡还款" Second:nil title2:nil Third:nil title3:nil Fourth:nil title4:nil Fifth:nil title5:nil Sixth:nil title6:nil];
    [self.view addSubview:self.functionView2];

}

-(void)pay:(id)sender{
    BillTableViewController *billVC = [[BillTableViewController alloc] init];
    [self pushVC:billVC title:@"物业费"];
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
