//
//  AboutViewController.m
//  WeCommunity
//
//  Created by Harry on 10/14/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAboutUsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupAboutUsView{
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logo.center = CGPointMake(SCREENSIZE.width/2, 120);
    logo.image = [UIImage imageNamed:@"logo"];
    logo.layer.masksToBounds = YES;
    logo.layer.cornerRadius = 5;
    [self.view addSubview:logo];
    
    self.vStr = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.vStr.center = CGPointMake(SCREENSIZE.width/2, 170);
    self.vStr.text = @"小区盒子";
    self.vStr.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.vStr];
    
    NSString *detail =@"小区盒子由上海立夏信息科技有限公司开发，是基于智能物业、小区邻里社交、周边商家服务的手机端软件，致力于打造移动互联网时代的智能小区生态。";
    UIFont *detailFont = [UIFont fontWithName:fontName size:14];
    CGFloat detailHeight = [Util getHeightForString:detail width:SCREENSIZE.width-40 font:detailFont];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.vStr.frame.origin.y+40, SCREENSIZE.width-40, detailHeight)];
    detailLabel.font = detailFont;
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.numberOfLines = 0;
    detailLabel.text =detail;
    [self.view addSubview:detailLabel];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bottomBtn.frame = CGRectMake(20, SCREENSIZE.height-40, SCREENSIZE.width-40, 30);
    [bottomBtn setTitle:@"小区软件使用许可及服务协议" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = detailFont;
    [bottomBtn setTitleColor:[Util colorWithHexString:@"180e5a"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(networkingProtocal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}

-(void)networkingProtocal{
  
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.webURL = @"http://www.xiaoquhezi.com/agreement.html";
    webVC.title = @"网站用户协议";
    [self.navigationController pushViewController:webVC animated:YES];
}



@end
