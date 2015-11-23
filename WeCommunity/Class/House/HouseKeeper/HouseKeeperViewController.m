//
//  HouseKeeperViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HouseKeeperViewController.h"

@interface HouseKeeperViewController ()

@end

@implementation HouseKeeperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"更多";
    [self setupAppearance];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAppearance{
    self.functionView = [[FunctionView alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 200)];
//    [self.functionView setupFunctionViewFirst:@"天气查询" title1:@"天气查询" Second:@"预约挂号" title2:@"火车查询" Third:@"火车查询" title3:@"预约挂号" Fourth:@"预约挂号" title4:nil Fifth:nil title5:nil Sixth:nil title6:nil];
    
    [self.functionView setupFunctionViewFirst:@"天气查询" title1:@"天气查询" Second:@"预约挂号" title2:@"火车查询" Third:@"火车查询" title3:nil Fourth:nil title4:nil Fifth:nil title5:nil Sixth:nil title6:nil];
    [self.functionView.firstItem.functionButton addTarget:self action:@selector(getWeather:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.secondItem.functionButton addTarget:self action:@selector(getTrain:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.thirdItem.functionButton addTarget:self action:@selector(noFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionView];
    
}

-(void)getWeather:(id)sender{
    [self webAction:@"weather"];
}

-(void)getTrain:(id)sender{
    [self webAction:@"train"];
}

-(void)noFunction{
    [Util alertNetworingError:@"功能暂未开放"];
}


-(void)webAction:(NSString*)action{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"webType":action};
    [manager POST:[NSString stringWithFormat:@"%@/weblink/getByType",kInitURL ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.webURL = responseObject[@"msg"][@"url"];
        
        if ([action isEqualToString:@"weather"]) {
            [self pushVC:webVC title:@"天气查询"];
        }else{
            [self pushVC:webVC title:@"火车查询"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
