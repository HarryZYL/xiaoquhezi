//
//  SummerCommunityBrowserViewController.m
//  WeCommunity
//
//  Created by madarax on 15/11/6.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerCommunityBrowserViewController.h"

@interface SummerCommunityBrowserViewController ()
{
    IBOutlet UIImageView *communitImg;
    IBOutlet UILabel *communitLab;
    IBOutlet UIButton *communitBtn;
}
@end

@implementation SummerCommunityBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    communitLab.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1].CGColor;
    communitLab.layer.borderWidth = 2;
}

- (IBAction)btnCallCommunitPhone:(id)sender{
    
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
