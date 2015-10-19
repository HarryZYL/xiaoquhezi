//
//  OverViewViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "OverViewViewController.h"

@interface OverViewViewController ()

@end

@implementation OverViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    OverView *ovewView = [[OverView alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 100)];
    [self.view addSubview:ovewView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
