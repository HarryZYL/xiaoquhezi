//
//  CommunityViewController.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"玉兰香苑";
    
    [self setupAppearance];
    // Do any additional setup after loading the view.
}

//设置样式
-(void)setupAppearance{
//    设置功能页面
    self.functionView = [[FunctionView alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 200)];
    [self.functionView setupFunctionViewFirst:@"综合" title1:@"综合" Second:@"活动" title2:@"活动" Third:@"跳蚤市场" title3:@"跳蚤市场" Fourth:@"拼车" title4:@"拼车" Fifth:@"宠物" title5:@"宠物" Sixth:@"游戏" title6:@"游戏"];
    [self.functionView.firstItem.functionButton addTarget:self action:@selector(general:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.thirdItem.functionButton addTarget:self action:@selector(secondHand:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.secondItem.functionButton addTarget:self action:@selector(activity:) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fourthItem.functionButton addTarget:self action:@selector(noFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.fifthItem.functionButton addTarget:self action:@selector(noFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.functionView.sixthItem.functionButton addTarget:self action:@selector(noFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)noFunction{
    [Util alertNetworingError:@"功能暂未开放"];
}

//跳转综合页面
-(void)general:(id)sender{
    GeneralTableViewController *generalVC = [[GeneralTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self pushVC:generalVC title:@"综合"];
}
//跳转二手页面
-(void)secondHand:(id)sender{
    RentViewController *secondHandVC = [[RentViewController alloc] init];
    secondHandVC.function = @"secondHand";
    secondHandVC.playAdvertise = NO;
    [self pushVC:secondHandVC title:@"跳蚤市场"];
}
//跳转活动页面
-(void)activity:(id)sender{
    RentViewController *activityVC = [[RentViewController alloc] init];
    activityVC.function = @"activity";
    activityVC.playAdvertise = NO;
    [self pushVC:activityVC title:@"活动"];
}
//封装的跳转功能
-(void)pushVC:(UIViewController*)vc title:(NSString*)title{
    vc.navigationItem.title = title;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
