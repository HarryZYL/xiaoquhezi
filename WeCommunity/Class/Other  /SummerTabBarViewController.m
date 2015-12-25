//
//  SummerTabBarViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/20.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerTabBarViewController.h"
#import "HouseViewController.h"
#import "SummerBusinessViewController.h"
#import "SummerLoadingPageViewController.h"

@interface SummerTabBarViewController ()

@end

@implementation SummerTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FIRST_LOGING"]) {
        self.tabBar.hidden = YES;
        SummerLoadingPageViewController *loadingPageVC = [[SummerLoadingPageViewController alloc] init];
        loadingPageVC.returnViewController = ^{
            [weakSelf loadSubViewControllers];
        };
        [self addChildViewController:loadingPageVC];
    }else{
        [self loadSubViewControllers];
    }
}

- (void)loadSubViewControllers{
    self.tabBar.hidden = NO;
    
    UIStoryboard *homeStory = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    UINavigationController *homeNav =  (UINavigationController *)[homeStory instantiateViewControllerWithIdentifier:@"HOME_STORY"];

//    UIStoryboard *businessStory = [UIStoryboard storyboardWithName:@"BusinessStoryboard" bundle:nil];
//    UINavigationController *businessNav = (UINavigationController *)[businessStory instantiateViewControllerWithIdentifier:@"BUSINESS_STORY"];

    self.viewControllers = @[homeNav];
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
